module Rcm.Private.Dotfiles (getDotfiles, Dotfile(..)) where

import Control.Monad (forM)
import Control.Applicative ((<$>))
import Control.Exception (handle, IOException)
import System.Posix (getFileStatus, isDirectory)
import System.Directory (getDirectoryContents)
import System.FilePath (joinPath)
import Data.Foldable (foldrM)

import Rcm.Util (isDotted)
import Rcm.Private.Data

getDotfiles :: Config -> [FilePath] -> IO [Dotfile]
getDotfiles config files = foldrM g [] (dotfilesDirs config)
  where
    g dotfilesDir acc = do
      dotfiles <- getFiles dotfilesDir
      return $ acc ++ dotfiles

getFiles :: FilePath -> IO [Dotfile]
getFiles baseDir = getFiles' baseDir ""

getFiles' baseDir subdir = do
  files <- ls (joinPath [baseDir, subdir])
  foldrM g [] files
  where
    g file acc = handle (handler acc) $ do
          isDir <- (isDirectory <$> getFileStatus (joinPath [baseDir, subdir, file]))
          if isDir then do
            files <- getFiles' baseDir $ joinPath [subdir, file]
            return $ files ++ acc
          else
            let dt = DotfileTarget {
                       dtBase = baseDir
                      ,dtPath = if subdir == "" then Nothing else Just subdir
                      ,dtFile = file
                      ,dtTag = Nothing
                      ,dtHost = Nothing
                      } in
            return $ (Dotfile dt "/tmp/unknown"):acc

    handler :: a -> IOException -> IO a
    handler acc e = do
      print e
      return acc

ls :: FilePath -> IO [FilePath]
ls dir = filter (not . isDotted) <$> getDirectoryContents dir

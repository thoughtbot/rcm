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

import System.Posix (getFileStatus, isDirectory)

getDotfiles :: Config -> [FilePath] -> IO [Dotfile]
getDotfiles config files = foldrM g [] (dotfilesDirs config)
  where
    g dotfilesDir acc = do
      dotfiles <- getFiles config dotfilesDir
      return $ acc ++ dotfiles

getFiles :: Config -> FilePath -> IO [Dotfile]
getFiles config baseDir = getFiles' config baseDir ""

getFiles' config baseDir subdir = do
  files <- ls (joinPath [baseDir, subdir])
  foldrM g [] files
  where
    g file acc = handle (handler acc) $ do
      isDir <- (isDirectory <$> getFileStatus (joinPath [baseDir, subdir, file]))
      if isDir then do
        files <- getFiles' config baseDir $ joinPath [subdir, file]
        return $ files ++ acc
      else
        let dt = mkTarget baseDir subdir file
            ds = mkSource config dt in
        return $ (Dotfile dt ds):acc

    handler :: a -> IOException -> IO a
    handler acc e = do
      print e
      return acc

ls :: FilePath -> IO [FilePath]
ls dir = filter (not . isDotted) <$> getDirectoryContents dir

mkTarget :: FilePath -> FilePath -> FilePath -> DotfileTarget
mkTarget baseDir subdir file =
  DotfileTarget {
     dtBase = baseDir
    ,dtPath = if subdir == "" then Nothing else Just subdir
    ,dtFile = file
    ,dtTag = Nothing
    ,dtHost = Nothing
    }

mkSource :: Config -> DotfileTarget -> DotfileSource
mkSource config dt = joinPath [homeDir config, "." ++ pathToFile (dtPath dt)]
  where
    pathToFile Nothing = dtFile dt
    pathToFile (Just p) = joinPath [p, dtFile dt]

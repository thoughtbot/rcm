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
      return $ acc ++ map mkDotfile dotfiles

getFiles :: FilePath -> IO [FilePath]
getFiles baseDir = do
  files <- ls baseDir
  foldrM g [] files
  where

    g file acc = handle (handler acc) $ do
          isDir <- (isDirectory <$> getFileStatus file)
          if isDir then do
            files <- getFiles file
            return $ files ++ acc
          else
            return $ file:acc

    handler :: a -> IOException -> IO a
    handler acc e = do
      print e
      return acc

mkDotfile :: FilePath -> Dotfile
mkDotfile target = Dotfile target "/tmp/unknown"

ls :: FilePath -> IO [FilePath]
ls dir =
  map (\file -> (joinPath [dir, file]))
  <$>
  filter (not . isDotted)
  <$>
  getDirectoryContents dir

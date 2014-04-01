module Rcm.Private.Dotfiles (getDotfiles, Dotfile(..)) where

import Control.Applicative ((<$>))
import Control.Monad (forM)
import System.Posix (getFileStatus, isDirectory)
import System.Directory (getDirectoryContents)
import Data.Foldable (foldrM)

import Rcm.Private.Data

getDotfiles :: Config -> [FilePath] -> IO [Dotfile]
getDotfiles config files = foldrM g [] (dotfilesDirs config)
  where
    g dotfilesDir acc = do
      dotfiles <- getFiles dotfilesDir
      return $ acc ++ map mkDotfile dotfiles

getFiles :: FilePath -> IO [FilePath]
getFiles baseDir = do
  files <- getDirectoryContents baseDir
  foldrM g [] files
  where
    g file acc = do
      isDir <- (isDirectory <$> getFileStatus file)
      if isDir then
        getFiles file
      else
        return $ file:acc

mkDotfile :: FilePath -> Dotfile
mkDotfile target = Dotfile target

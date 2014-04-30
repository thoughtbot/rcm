module Rcm.Private.Dotfiles (getDotfiles, Dotfile(..)) where

import Control.Monad (forM, filterM)
import Control.Applicative ((<$>))
import Control.Exception (handle, IOException)
import System.Posix (getFileStatus, isDirectory, isRegularFile)
import System.Directory (getDirectoryContents)
import System.FilePath (joinPath)
import Data.Foldable (foldrM)
import Data.List (stripPrefix, isPrefixOf)

import Rcm.Util (isDotted)
import Rcm.Private.Data

getDotfiles :: Config -> [FilePath] -> IO [Dotfile]
getDotfiles config files = foldrM g [] (dotfilesDirs config)
  where
    g dotfilesDir acc = do
      dotfiles <- getFiles config dotfilesDir
      return $ acc ++ dotfiles

getFiles :: Config -> FilePath -> IO [Dotfile]
getFiles config baseDir = do
  metaDirs <- getMetaDirs config baseDir
  normalDirs <- getNormalDirs config baseDir
  normalFiles <- getNormalFiles config baseDir
  recurredDotfiles <- foldrM g [] (metaDirs ++ normalDirs)
  let normalDotfiles = map (mkDotfile config baseDir) normalFiles

  return $ normalDotfiles ++ recurredDotfiles

  where
    g dir dotfiles = do
      files <- getFiles' config baseDir dir
      return $ dotfiles ++ files

getMetaDirs config baseDir =
  filter (isDesiredMetadir config) <$> ls baseDir

isDesiredMetadir config dir =
  case stripPrefix "tag-" dir of
    Just tag -> tag `elem` (tags config)
    Nothing -> False

getNormalDirs config baseDir = do
  files <- ls baseDir
  filterM g files
  where
    g file = do
      isDir' <- isDir (joinPath [baseDir, file])
      return $ isDir' && (not $ isMetaDir file)

isMetaDir dir = "tag-" `isPrefixOf` dir

isDir file = isDirectory <$> getFileStatus file

getNormalFiles :: Config -> FilePath -> IO [FilePath]
getNormalFiles config baseDir = do
  subdirs <- ls baseDir
  filterM onlyFile subdirs
  where
    onlyFile :: FilePath -> IO Bool
    onlyFile file = isRegularFile <$> getFileStatus (joinPath [baseDir, file])

mkDotfile config baseDir file = Dotfile dt ds
  where
    dt = mkTarget baseDir "" file
    ds = mkSource config dt

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

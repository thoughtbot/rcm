module Rcm.Private.Dotfiles (getDotfiles, Dotfile(..)) where

import Control.Monad (forM, filterM)
import Control.Applicative ((<$>))
import Control.Exception (handle, IOException)
import System.Posix (getFileStatus, isDirectory, isRegularFile)
import System.Directory (getDirectoryContents)
import System.FilePath (joinPath)
import Data.Foldable (foldrM)
import Data.List (stripPrefix, isPrefixOf)
import qualified Data.Map.Lazy as Map

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
  files <- ls baseDir
  fileStatuses <- mapM (\file -> getFileStatus $ joinPath [baseDir, file]) files
  let directoryContents = Map.fromList $ zip files fileStatuses
      metaDirs = Map.keys $ getMetaDirs config directoryContents
      normalDirs = Map.keys $ getNormalDirs config directoryContents
      normalFiles = Map.keys $ getNormalFiles config directoryContents

  recurredMetaDotfiles <- foldrM h [] metaDirs
  recurredDotfiles <- foldrM g [] normalDirs
  let normalDotfiles = map (mkDotfile config baseDir) normalFiles

  return $ normalDotfiles ++ recurredDotfiles ++ recurredMetaDotfiles

  where
    g dir dotfiles = do
      files <- getFiles' config baseDir dir
      return $ dotfiles ++ files
    h dir dotfiles = do
      files <- getFiles' config (baseDir ++  dir) ""
      return $ dotfiles ++ files

getMetaDirs config = Map.filterWithKey (\k _ -> isDesiredMetadir config k)

isDesiredMetadir config dir =
  case stripPrefix "tag-" dir of
    Just tag -> tag `elem` (tags config)
    Nothing -> case stripPrefix "host-" dir of
      Just host -> host == hostname config
      Nothing -> False

getNormalDirs config filesMap = Map.filterWithKey g filesMap
  where
    g basename fileStatus =
      isDirectory fileStatus && (not $ isMetaDir basename)

isMetaDir dir = "tag-" `isPrefixOf` dir || "host-" `isPrefixOf` dir

getNormalFiles config filesMap = Map.filter isRegularFile filesMap

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

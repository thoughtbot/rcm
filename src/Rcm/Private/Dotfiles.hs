module Rcm.Private.Dotfiles (getDotfiles, Dotfile(..)) where

import Control.Monad (forM, filterM)
import Control.Applicative ((<$>))
import Control.Exception (handle, IOException)
import System.Posix (getFileStatus, isDirectory, isRegularFile, FileStatus)
import System.Directory (getDirectoryContents)
import System.FilePath (joinPath)
import Data.Foldable (foldrM)
import Data.List (stripPrefix, isPrefixOf)
import Data.Maybe (listToMaybe, fromJust, isJust)
import qualified Data.Map.Lazy as Map

import Rcm.Util (isDotted)
import Rcm.Private.Data

getDotfiles :: Config -> [FilePath] -> IO [Dotfile]
getDotfiles config _ = do
  dotfiles <- forM (dotfilesDirs config) $ \dir -> do
                files <- walkPath config dir
                print config
                print files
                print $ prune config files
                return $ prune config files
  return $ concat dotfiles

data DFNode = DFNode FilePath [FilePath] String FileStatus
--                   baseDir  subdirs  basename status

walkPath :: Config -> FilePath -> IO [Dotfile]
walkPath config dir = subtrees [dir]
  where

    subtrees :: [FilePath] -> IO [Dotfile]
    subtrees subdirs = do
      let path = joinPath subdirs
      status <- getFileStatus path
      collectSubtrees path status subdirs

    collectSubtrees :: FilePath -> FileStatus -> [FilePath] -> IO [Dotfile]
    collectSubtrees path status subdirs
      | isDirectory status = do
        files <- ls path
        trees <- mapM (\file -> subtrees $ subdirs ++ [file]) files
        return $ concat trees
      | otherwise =
        return $ [mkDotfile config subdirs status]

prune :: Config -> [Dotfile] -> [Dotfile]
prune config dotfiles = filter prune' dotfiles
  where

  prune' :: Dotfile -> Bool
  prune' dotfile 
    | isMeta dotfile = tag `elem` (tags config) || host == (hostname config)
    | otherwise = True
    where
      tag = maybe "" id $ dtTag $ dotfileTarget dotfile
      host = maybe "" id $ dtHost $ dotfileTarget dotfile

ls :: FilePath -> IO [FilePath]
ls dir = filter (not . isDotted) <$> getDirectoryContents dir

mkDotfile :: Config -> [FilePath] -> FileStatus -> Dotfile
mkDotfile config dirs status =
  let (basedir, subdirs, basename, tag, hostname) = splitDir dirs
      target = DotfileTarget basedir
                             (Just $ joinPath subdirs)
                             basename
                             tag
                             hostname
      -- subdirs, tag, and hostname must be combined to produce the
      -- sourcedir ... with a dot.
      source = (homeDir config) ... basename
  in Dotfile target source

splitDir :: [FilePath] -> (FilePath, [FilePath], FilePath, Maybe String, Maybe String)
splitDir dirs =
  let basedir = head dirs
      subdirs = init (tail dirs)
      basename = last dirs
      possibleMetadir = maybe "" id $ listToMaybe subdirs
  in case stripPrefix "tag-" possibleMetadir of
    Just tag -> (basedir, tail subdirs, basename, Just tag, Nothing)
    Nothing -> case stripPrefix "host-" possibleMetadir of
      Just host -> (basedir, tail subdirs, basename, Nothing, Just host)
      Nothing -> (basedir, subdirs, basename, Nothing, Nothing)

isMetaDir dir = "tag-" `isPrefixOf` dir || "host-" `isPrefixOf` dir

isMeta dotfile = isJust (dtHost dt) || isJust (dtTag dt)
  where dt = dotfileTarget dotfile

--- Prior ideas: ---
-- 
-- getDotfiles :: Config -> [FilePath] -> IO [Dotfile]
-- getDotfiles config files = foldrM g [] (dotfilesDirs config)
--   where
--     g dotfilesDir acc = do
--       dotfiles <- getFiles config dotfilesDir
--       return $ acc ++ dotfiles
-- 
-- getFiles :: Config -> FilePath -> IO [Dotfile]
-- getFiles config baseDir = do
--   files <- ls baseDir
--   fileStatuses <- mapM (\file -> getFileStatus $ joinPath [baseDir, file]) files
--   let directoryContents = Map.fromList $ zip files fileStatuses
--       metaDirs = Map.keys $ getMetaDirs config directoryContents
--       normalDirs = Map.keys $ getNormalDirs config directoryContents
--       normalFiles = Map.keys $ getNormalFiles config directoryContents
-- 
--   recurredMetaDotfiles <- foldrM h [] metaDirs
--   recurredDotfiles <- foldrM g [] normalDirs
--   let normalDotfiles = map (mkDotfile config baseDir) normalFiles
-- 
--   return $ normalDotfiles ++ recurredDotfiles ++ recurredMetaDotfiles
-- 
--   where
--     g dir dotfiles = do
--       files <- getFiles' config baseDir dir
--       return $ dotfiles ++ files
--     h dir dotfiles = do
--       files <- getFiles' config (baseDir ++  dir) ""
--       return $ dotfiles ++ files
-- 
-- getMetaDirs config = Map.filterWithKey (\k _ -> isDesiredMetadir config k)
-- 
-- isDesiredMetadir config dir =
--   case stripPrefix "tag-" dir of
--     Just tag -> tag `elem` (tags config)
--     Nothing -> case stripPrefix "host-" dir of
--       Just host -> host == hostname config
--       Nothing -> False
-- 
-- getNormalDirs config filesMap = Map.filterWithKey g filesMap
--   where
--     g basename fileStatus =
--       isDirectory fileStatus && (not $ isMetaDir basename)
-- 
-- isMetaDir dir = "tag-" `isPrefixOf` dir || "host-" `isPrefixOf` dir
-- 
-- getNormalFiles config filesMap = Map.filter isRegularFile filesMap
-- 
-- mkDotfile config baseDir file = Dotfile dt ds
--   where
--     dt = mkTarget baseDir "" file
--     ds = mkSource config dt
-- 
-- getFiles' config baseDir subdir = do
--   files <- ls (joinPath [baseDir, subdir])
--   foldrM g [] files
--   where
--     g file acc = handle (handler acc) $ do
--       isDir <- (isDirectory <$> getFileStatus (joinPath [baseDir, subdir, file]))
--       if isDir then do
--         files <- getFiles' config baseDir $ joinPath [subdir, file]
--         return $ files ++ acc
--       else
--         let dt = mkTarget baseDir subdir file
--             ds = mkSource config dt in
--         return $ (Dotfile dt ds):acc
-- 
--     handler :: a -> IOException -> IO a
--     handler acc e = do
--       print e
--       return acc
-- 
-- ls :: FilePath -> IO [FilePath]
-- ls dir = filter (not . isDotted) <$> getDirectoryContents dir
-- 
-- mkTarget :: FilePath -> FilePath -> FilePath -> DotfileTarget
-- mkTarget baseDir subdir file =
--   DotfileTarget {
--      dtBase = baseDir
--     ,dtPath = if subdir == "" then Nothing else Just subdir
--     ,dtFile = file
--     ,dtTag = Nothing
--     ,dtHost = Nothing
--     }
-- 
-- mkSource :: Config -> DotfileTarget -> DotfileSource
-- mkSource config dt = joinPath [homeDir config, "." ++ pathToFile (dtPath dt)]
--   where
--     pathToFile Nothing = dtFile dt
--     pathToFile (Just p) = joinPath [p, dtFile dt]

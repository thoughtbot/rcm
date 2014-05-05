module Rcm.Private.Dotfiles (getDotfiles, Dotfile(..)) where

import Control.Monad (forM, filterM)
import Control.Applicative ((<$>))
import Control.Exception (handle, IOException)
import System.Posix (getFileStatus, isDirectory, isRegularFile, FileStatus)
import System.Directory (getDirectoryContents)
import System.FilePath (joinPath)
import Data.Foldable (foldrM)
import Data.List (stripPrefix, isPrefixOf)
import Data.Maybe (listToMaybe, fromJust, isJust, fromMaybe)
import qualified Data.Map.Lazy as Map

import Rcm.Util (isDotted)
import Rcm.Private.Data

getDotfiles :: Config -> [FilePath] -> IO [Dotfile]
getDotfiles config _ = do
  dotfiles <- forM (dotfilesDirs config) $ \dir -> do
                files <- walkPath config dir
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
    | isMeta dotfile =
      (tagStr dotfile) `elem` (tags config) ||
        (hostnameStr dotfile) == (hostname config)
    | otherwise = True

ls :: FilePath -> IO [FilePath]
ls dir = filter (not . isDotted) <$> getDirectoryContents dir

mkDotfile :: Config -> [FilePath] -> FileStatus -> Dotfile
mkDotfile config dirs status =
  let (basedir, subdirs, basename, tag, hostname) = splitDir dirs
      path = if null subdirs then Nothing else Just $ joinPath subdirs
      target = DotfileTarget basedir path basename tag hostname
      paths = subdirs ++ [basename]
      source = joinPath $ [homeDir config, "." ++ head paths] ++ tail paths
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

tagStr = fromMaybe "" . dtTag . dotfileTarget

hostnameStr = fromMaybe "" . dtHost . dotfileTarget

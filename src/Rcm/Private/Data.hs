module Rcm.Private.Data where

import System.FilePath (joinPath)

type DotfileSource = FilePath

data Dotfile = Dotfile {
  dotfileTarget :: DotfileTarget
 ,dotfileSource :: DotfileSource
} deriving (Show, Eq, Ord)

data Config = Config {
   showSigils :: Bool
  ,showHelp :: Bool
  ,includes :: [String]
  ,tags :: [String]
  ,verbosity :: Integer
  ,dotfilesDirs :: [FilePath]
  ,showVersion :: Bool
  ,excludes :: [String]
  ,symlinkDirs :: [String]
  ,homeDir :: FilePath
  ,hostname :: String
} deriving (Show, Eq)

data DotfileTarget = DotfileTarget {
  dtBase :: FilePath
 ,dtPath :: Maybe FilePath
 ,dtFile :: FilePath
 ,dtTag  :: Maybe String
 ,dtHost :: Maybe String
} deriving (Eq, Ord)

instance Show DotfileTarget where
  show dt = joinPath paths
    where
    paths = [dtBase dt] ++ tag ++ host ++ path ++ [dtFile dt]
    tag = maybe [] return (dtTag dt)
    host = maybe [] return (dtHost dt)
    path = maybe [] return (dtPath dt)

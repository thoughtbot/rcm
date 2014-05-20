module Rcm.Private.Data where

import System.FilePath.Glob (Pattern)
import System.FilePath (joinPath)
import System.Posix (FileStatus)

type DotfileSource = FilePath

data ExclPat = ExclPatAll Pattern | ExclPatDotfileDir FilePath Pattern
  deriving (Show, Eq)

data Dotfile = Dotfile {
  dotfileTarget :: DotfileTarget
 ,dotfileSource :: DotfileSource
} deriving (Show, Eq, Ord)

data Config = Config {
   showSigils :: Bool
  ,showHelp :: Bool
  ,includes :: [ExclPat]
  ,tags :: [String]
  ,verbosity :: Integer
  ,dotfilesDirs :: [FilePath]
  ,showVersion :: Bool
  ,excludes :: [ExclPat]
  ,symlinkDirs :: [ExclPat]
  ,homeDir :: FilePath
  ,hostname :: String
} deriving (Show, Eq)

data DotfileTarget = DotfileTarget {
  dtBase   :: FilePath
 ,dtPath   :: Maybe FilePath
 ,dtFile   :: FilePath
 ,dtTag    :: Maybe String
 ,dtHost   :: Maybe String
} deriving (Eq, Ord)

instance Show DotfileTarget where
  show dt = joinPath paths
    where
    paths = [dtBase dt] ++ tag ++ host ++ path ++ [dtFile dt]
    tag = maybe [] (return . (++) "tag-") (dtTag dt)
    host = maybe [] (return . (++) "host-") (dtHost dt)
    path = maybe [] return (dtPath dt)

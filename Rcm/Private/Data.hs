module Rcm.Private.Data where

data Dotfile = Dotfile {
  dotfileTarget :: FilePath
 ,dotfileSource :: FilePath
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
} deriving (Show, Eq)

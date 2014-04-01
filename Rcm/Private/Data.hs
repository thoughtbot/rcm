module Rcm.Private.Data where

data Dotfile = Dotfile {
  dotfileTarget :: FilePath
} deriving (Show, Eq)

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

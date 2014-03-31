{-# LANGUAGE MultiWayIf #-}

module Rcm.Lsrc where

import System.Environment (getArgs, getEnv)
import Rcm.GetOpt (getOpt)

main = do
  args <- getArgs
  homedir <- getEnv "HOME"
  let c = defaultConfig homedir
      (config,files) = parseArgs c args

  putStrLn "Config:"
  print config
  putStrLn "Files:"
  print files

  return ()

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
} deriving (Show)

parseArgs :: Config -> [String] -> (Config, [String])
parseArgs config args = (foldr handleOpt config flags, files)
  where (flags, files) = getOpt "FVqvhI:x:S:t:d:" args

handleOpt ('F', _            ) c = c { showSigils = True }
handleOpt ('h', _            ) c = c { showHelp = True }
handleOpt ('I', (Just optArg)) c = c { includes = optArg : (includes c) }
handleOpt ('t', (Just optArg)) c = c { tags = optArg : (tags c) }
handleOpt ('v', _            ) c = c { verbosity = (verbosity c) + 1 }
handleOpt ('q', _            ) c = c { verbosity = (verbosity c) - 1 }
handleOpt ('d', (Just optArg)) c = c { dotfilesDirs = optArg : (dotfilesDirs c) }
handleOpt ('V', _            ) c = c { showVersion = True }
handleOpt ('x', (Just optArg)) c = c { excludes = optArg : (excludes c) }
handleOpt ('S', (Just optArg)) c = c { symlinkDirs = optArg : (symlinkDirs c) }
handleOpt ('?', _            ) c = c

defaultConfig homeDir = Config {
   showSigils = False
  ,showHelp = False
  ,includes = []
  ,tags = []
  ,verbosity = 0
  ,dotfilesDirs = [homeDir ++ "/.dotfiles"]
  ,showVersion = False
  ,excludes = []
  ,symlinkDirs = []
}

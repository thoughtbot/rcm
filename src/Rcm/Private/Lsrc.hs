module Rcm.Private.Lsrc where

import System.FilePath (joinPath)
import Rcm.Private.Data
import Rcm.GetOpt (getOpt, Flag)

parseArgs :: Config -> [String] -> (Config, [String])
parseArgs config args = (foldr handleOpt config flags, files)
  where (flags, files) = getOpt "FVqvhI:x:S:t:d:" args

handleOpt :: Flag -> Config -> Config
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
handleOpt ('?', _            ) c = c -- TODO: new functionality

defaultConfig homeDir hostname = Config {
   showSigils = False
  ,showHelp = False
  ,includes = []
  ,tags = []
  ,verbosity = 0
  ,dotfilesDirs = [joinPath [homeDir, ".dotfiles"]]
  ,showVersion = False
  ,excludes = []
  ,symlinkDirs = []
  ,homeDir = homeDir
  ,hostname = hostname
}

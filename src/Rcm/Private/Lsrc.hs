module Rcm.Private.Lsrc where

import Rcm.Private.Data
import Rcm.GetOpt (getOpt, Flag)
import Rcm.Private.Patterns (exclPat)
import Rcm.Private.Util (absolutize)

parseArgs :: [String] -> Config -> (Config, [String])
parseArgs args config = (foldr handleOpt config flags, files)
  where (flags, files) = getOpt "FVqvhI:x:S:t:d:" args

handleOpt :: Flag -> Config -> Config
handleOpt ('F', _            ) c = c { showSigils = True }
handleOpt ('h', _            ) c = c { showHelp = True }
handleOpt ('I', (Just optArg)) c = c { includes = (exclPat optArg) : (includes c) }
handleOpt ('t', (Just optArg)) c = c { tags = optArg : (tags c) }
handleOpt ('v', _            ) c = c { verbosity = (verbosity c) + 1 }
handleOpt ('q', _            ) c = c { verbosity = (verbosity c) - 1 }
handleOpt ('d', (Just optArg)) c = c { dotfilesDirs = optArg : (dotfilesDirs c) }
handleOpt ('V', _            ) c = c { showVersion = True }
handleOpt ('x', (Just optArg)) c = c { excludes = (exclPat optArg) : (excludes c) }
handleOpt ('S', (Just optArg)) c = c { symlinkDirs = (exclPat optArg) : (symlinkDirs c) }
handleOpt ('?', _            ) c = c -- TODO: new functionality

initialConfig homeDir hostname = Config {
   showSigils = False
  ,showHelp = False
  ,includes = []
  ,tags = []
  ,verbosity = 0
  ,dotfilesDirs = []
  ,showVersion = False
  ,excludes = []
  ,symlinkDirs = []
  ,homeDir = homeDir
  ,hostname = hostname
}

defaultConfig homeDir pwd config =
  config { dotfilesDirs = defaultDotfilesDirs, excludes = defaultExcludes }
  where
    defaultDotfilesDirs
      | null $ dotfilesDirs config = [absolutize homeDir ".dotfiles"]
      | otherwise = map (absolutize pwd) (dotfilesDirs config)

    defaultExcludes = map absExcl (excludes config)

    absExcl (ExclPatDotfileDir dir p) = ExclPatDotfileDir (absolutize pwd dir) p
    absExcl x = x

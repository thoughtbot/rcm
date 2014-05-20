module Rcm.Private.Rcrc (readRcrc, parseRcrc) where

import Control.Exception (catch, IOException)
import System.FilePath (joinPath)
import Data.List.Split (splitOn)

import Rcm.Private.Patterns (exclPat)
import Rcm.Private.Data

readRcrc :: FilePath -> IO String
readRcrc homedir = (readFile $ joinPath [homedir, ".rcrc"]) `catch` handler
  where 
    handler :: IOException -> IO String
    handler _ = return ""

parseRcrc :: String -> Config -> Config
parseRcrc rcrc config = foldr updateConfig config $ map parseLine $ lines rcrc

parseLine :: String -> ConfigLine
parseLine s = key valueString
  where
    [keyString, valueString] = splitOn "=" s
    key = parseKey keyString

parseKey :: String -> (String -> ConfigLine)
parseKey "COPY_ALWAYS" = const (CopyAlways False) -- not needed for lsrc
parseKey "DOTFILES_DIRS" = DotfilesDirs . splitOn " " . stripQuotes
parseKey "EXCLUDES" = Excludes . splitOn " " . stripQuotes
parseKey "HOSTNAME" = Hostname . stripQuotes
parseKey "TAGS" = Tags . splitOn " " . stripQuotes
parseKey "SYMLINK_DIRS" = SymlinkDirs . splitOn " " . stripQuotes

updateConfig :: ConfigLine -> Config -> Config
updateConfig (CopyAlways _) c = c
updateConfig (DotfilesDirs dirs) c = c { dotfilesDirs = dirs }
updateConfig (Excludes globs) c = c { excludes = map exclPat globs }
updateConfig (Hostname s) c = c { hostname = s }
updateConfig (Tags s) c = c { tags = s }
updateConfig (SymlinkDirs dirs) c = c { symlinkDirs = map exclPat dirs }

stripQuotes :: String -> String
stripQuotes ('"':s) = init s
stripQuotes ('\'':s) = init s
stripQuotes s = s

data ConfigLine =
    CopyAlways Bool
  | DotfilesDirs [FilePath]
  | Excludes [String]
  | Hostname String
  | Tags [String]
  | SymlinkDirs [String]
  deriving (Show)

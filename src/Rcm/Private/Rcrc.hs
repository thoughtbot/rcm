module Rcm.Private.Rcrc (readRcrc, parseRcrc) where

import Control.Exception (catch, IOException)
import System.FilePath (joinPath)

readRcrc :: FilePath -> IO String
readRcrc homedir = (readFile $ joinPath [homedir, ".rcrc"]) `catch` handler
  where 
    handler :: IOException -> IO String
    handler _ = return ""

parseRcrc = undefined

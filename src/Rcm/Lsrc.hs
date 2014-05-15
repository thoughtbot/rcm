{-# LANGUAGE MultiWayIf #-}

module Rcm.Lsrc where

import Control.Monad (forM_)
import System.Environment (getArgs, getEnv)
import System.Posix.Directory (getWorkingDirectory)
import Network.BSD (getHostName)
import Control.Arrow ((&&&))
import Data.List (intercalate)
import Rcm.Private.Lsrc
import Rcm.Private.Rcrc
import Rcm.Private.Data
import Rcm.Private.Dotfiles (getDotfiles, Dotfile(..))

main = do
  args <- getArgs
  homedir <- getEnv "HOME"
  hostname <- getHostName
  pwd <- getWorkingDirectory
  rcrc <- readRcrc homedir

  let c = initialConfig homedir hostname
      c' = parseRcrc rcrc c
      (c'',files) = parseArgs args c'
      config = defaultConfig homedir pwd c''

  if showHelp config then do
    putStrLn "Usage: lsrc [-FVqvh] [-I EXCL_PAT] [-x EXCL_PAT] [-N EXCL_PAT ] [-t TAG] [-d DOT_DIR]"
    putStrLn "see lsrc(1) and rcm(5) for more details"
  else if showVersion config then do
    putStrLn "lsrc (rcm) 1.2.2"
    putStrLn "Copyright (C) 2013 Mike Burns"
    putStrLn "Copyright (C) 2014 thoughtbot"
    putStrLn "License BSD: BSD 3-clause license"
    putStrLn ""
    putStrLn "Written by Mike Burns."
  else do

    dotfiles <- getDotfiles config files

    forM_ dotfiles $
      putStrLn .
        uncurry (\a b -> a ++ ":" ++ (show b)) .
        (dotfileSource &&& dotfileTarget)

    return ()

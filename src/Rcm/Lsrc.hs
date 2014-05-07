{-# LANGUAGE MultiWayIf #-}

module Rcm.Lsrc where

import Control.Monad (forM_)
import System.Environment (getArgs, getEnv)
import Network.BSD (getHostName)
import Rcm.Private.Lsrc
import Rcm.Private.Rcrc
import Rcm.Private.Data
import Rcm.Private.Dotfiles (getDotfiles, Dotfile(..))

main = do
  args <- getArgs
  homedir <- getEnv "HOME"
  hostname <- getHostName
  rcrc <- readRcrc homedir

  let c = defaultConfig homedir hostname
      c' = parseRcrc rcrc c
      (config,files) = parseArgs c' args

  dotfiles <- getDotfiles config files

  forM_ dotfiles $ \dotfile ->
    putStrLn $ (dotfileSource dotfile) ++ ":" ++ (show $ dotfileTarget dotfile)

  return ()

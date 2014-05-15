{-# LANGUAGE MultiWayIf #-}

module Rcm.Lsrc where

import Control.Monad (forM_)
import System.Environment (getArgs, getEnv)
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
  rcrc <- readRcrc homedir

  let c = initialConfig homedir hostname
      c' = parseRcrc rcrc c
      (c'',files) = parseArgs args c'
      config = defaultConfig homedir c''

  dotfiles <- getDotfiles config files

  forM_ dotfiles $
    putStrLn .
      uncurry (\a b -> a ++ ":" ++ (show b)) .
      (dotfileSource &&& dotfileTarget)

  return ()

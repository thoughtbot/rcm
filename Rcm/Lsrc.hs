{-# LANGUAGE MultiWayIf #-}

module Rcm.Lsrc where

import System.Environment (getArgs, getEnv)
import Rcm.Private.Lsrc

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

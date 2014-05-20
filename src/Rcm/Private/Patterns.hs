module Rcm.Private.Patterns (exclPat) where

import Data.List (intercalate)
import System.FilePath.Glob (compileWith, compPosix)
import Rcm.Private.Data

exclPat :: String -> ExclPat
exclPat s
  | ':' `elem` s =
    let (dir, glob) = break (== ':') s
    in ExclPatDotfileDir dir $ c $ tail glob
  | otherwise = ExclPatAll $ c s
  where c = compileWith compPosix

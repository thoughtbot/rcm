module Test.Main where

import Test.Hspec
import Test.LsrcSpecs (lsrcSpecs)
import Test.UtilSpecs (utilSpecs)
import Test.GetOptSpecs (getOptSpecs)
import Test.DotfilesSpecs (dotfilesSpecs)
import Test.RcrcSpecs (rcrcSpecs)
import Test.PatternsSpecs (patternsSpecs)

main = hspec $ do
  lsrcSpecs
  utilSpecs
  getOptSpecs
  dotfilesSpecs
  rcrcSpecs
  patternsSpecs

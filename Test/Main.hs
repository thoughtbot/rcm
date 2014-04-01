module Test.Main where

import Test.Hspec
import Test.LsrcSpecs (lsrcSpecs)
import Test.UtilSpecs (utilSpecs)
import Test.GetOptSpecs (getOptSpecs)

main = hspec $ do
  lsrcSpecs
  utilSpecs
  getOptSpecs

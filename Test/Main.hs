module Test.Main where

import Test.Hspec
import Test.LsrcSpecs (lsrcSpecs)
import Test.UtilSpecs (utilSpecs)

main = hspec $ do
  lsrcSpecs
  utilSpecs

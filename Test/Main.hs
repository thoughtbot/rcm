module Test.Main where

import Test.Hspec
import Test.LsrcSpecs (lsrcSpecs)

main =  do
  hspec $ do
    lsrcSpecs

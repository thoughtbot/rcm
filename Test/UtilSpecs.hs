module Test.UtilSpecs (utilSpecs) where

import Test.Hspec
import Test.QuickCheck
import Data.Maybe (isJust, isNothing)

import Rcm.Util (at, afterElem)

utilSpecs = describe "Rcm.Util" $ do
  context "at" $ do
    it "produces missing and existing values as correct" $ property $
      prop_at_missing_existing

prop_at_missing_existing :: Positive Int -> [Char] -> Bool
prop_at_missing_existing pIdx xs =
  let idx = getPositive pIdx
      assertion = if length xs > idx then isJust else isNothing in
  assertion $ xs `at` idx

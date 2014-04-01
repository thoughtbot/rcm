module Test.UtilSpecs (utilSpecs) where

import Test.Hspec
import Test.QuickCheck
import Data.Maybe (isJust, isNothing)

import Rcm.Util (at, afterElem)

utilSpecs = describe "Rcm.Util" $ do
  context "at" $ do
    it "produces missing and existing values as correct" $ property $
      prop_atMissingExisting

  context "afterElem" $ do
    it "produces missing and existing values as correct" $ property $
      prop_afterElemMissingExisting

prop_atMissingExisting :: Positive Int -> [Char] -> Bool
prop_atMissingExisting pIdx xs =
  let idx = getPositive pIdx
      assertion = if length xs > idx then isJust else isNothing in
  assertion $ xs `at` idx

prop_afterElemMissingExisting :: [Char] -> Bool
prop_afterElemMissingExisting [] = isNothing $ 'x' `afterElem` []
prop_afterElemMissingExisting xss@(x:xs) =
  let assertion = if null xs then isNothing else isJust in
  assertion $ x `afterElem` xss

module Test.UtilSpecs (utilSpecs) where

import Test.Hspec
import Test.QuickCheck
import Data.Maybe (isJust, isNothing)
import Data.List (isPrefixOf)

import Rcm.Private.Util (at, afterElem, splitOn, isDotted, absolutize)

utilSpecs = describe "Rcm.Private.Util" $ do
  context "at" $ do
    it "produces missing and existing values as correct" $ property $
      prop_atMissingExisting

  context "afterElem" $ do
    it "produces missing and existing values as correct" $ property $
      prop_afterElemMissingExisting

  context "splitOn" $ do
    it "splits a list into componentes with a delimiter" $ property $
      prop_intercalateSplittedIsId

  context "isDotted" $ do
    it "is true when the string begins with a dot" $ property $
      prop_isDottedBeginsWithDot

  context "absolutize" $ do
    it "combines relative directories with the supplied directory" $ property $
      prop_absolutizeCominesDirectories

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

prop_intercalateSplittedIsId :: (Eq a) => [a] -> [a] -> Bool
prop_intercalateSplittedIsId del lst = (intercalate del $ splitOn del lst) == lst

prop_isDottedBeginsWithDot :: String -> Bool
prop_isDottedBeginsWithDot s@('.':ss) = isDotted s == True
prop_isDottedBeginsWithDot s = isDotted s == False

prop_absolutizeCominesDirectories :: String -> Bool
prop_absolutizeCominesDirectories path =
  let expectedPath = if null path then "/tmp" else "/tmp/" ++ path
      assertion = if "/" `isPrefixOf` path then (== path) else (== expectedPath)
  in assertion $ absolutize "/tmp" path

module Rcm.Private.Util (at, afterElem, splitOn, isDotted, absolutize) where

import Data.List (elemIndex, isPrefixOf)
import System.FilePath (joinPath)

-- |The element in a list that comes after the given element. Think of
-- it as @elem + 1@.
afterElem :: (Eq a) => a -> [a] -> Maybe a
afterElem e xs = do
  idx <- elemIndex e xs
  xs `at` (idx + 1)

splitAtInfix :: (Eq a) => [a] -> [a] -> Maybe ([a],[a])
splitAtInfix del txt = findInfix del txt 0 >>= mkRes
  where
    findInfix _ [] _ = Nothing
    findInfix d l@(_:xs) i = if d `isPrefixOf` l
                                then Just i
                                else findInfix d xs (i+1)
    mkRes i = let (pre,pos) = splitAt i txt
              in return (pre, drop (length del) pos)

-- |Given a delimiter, splits a list and return the components.
splitOn :: (Eq a) => [a] -> [a] -> [[a]]
splitOn [] l = [l]
splitOn _ [] = [[]]
splitOn d l = let msp = splitAtInfix d l
              in case msp of
                   Nothing -> [l]
                   Just (pre,pos) -> pre : splitOn d pos

-- |Just like (!!) except it produces a Maybe.
at :: [a] -> Int -> Maybe a
at xs i = at' xs i 0
at' [] _ _ = Nothing
at' (x:xs) i idx | idx == i = Just x
                 | otherwise = at' xs i (idx + 1)

-- |True if the String begins with a period.
isDotted :: String -> Bool
isDotted ('.':_) = True
isDotted _ = False

-- |Prefix the path with the given string if it is a relative path.
-- Useful for adding the pwd onto the front of the path.
absolutize pwd path
  | "/" `isPrefixOf` path = path
  | otherwise = joinPath [pwd, path]

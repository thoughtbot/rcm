module Rcm.Private.Util (at, afterElem, isDotted) where

import Data.List (elemIndex)

-- |The element in a list that comes after the given element. Think of
-- it as @elem + 1@.
afterElem :: (Eq a) => a -> [a] -> Maybe a
afterElem e xs = do
  idx <- elemIndex e xs
  xs `at` (idx + 1)

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

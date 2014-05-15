{-|
Module      : Rcm.GetOpt
Description : getopt(3) in haskell
Copyright   : (c) thoughtbot 2014
License     : BSD
Maintainer  : hello@thoughtbot.com
Stability   : experimental

This is an implementation of the standard unix getopt(3) function in a
manner still useful to a Haskell developer.

This differs from POSIX in that it does not expose the array index.
Instead, it produces two lists: one list of Flag (the option and its
argument), and one list of unparsed arguments (files, intuitively).
-}

module Rcm.GetOpt (Flag, getOpt) where

import Data.List (isPrefixOf)
import Rcm.Private.Util (at, afterElem)

-- |A flag represents one command line option and its argument.
type Flag = (Char, Maybe String)

-- |An approximation of the standard unix getopt(3) function. It takes
-- an option string and the unparsed list of options. Unlike standard
-- getopt(3), it produces a tuple of lists: the first list is a list of
-- Flag, and the second is a list of remaining, unparsed arguments.
--
-- Just like in getopt(3), we support two special flag characters: @?@
-- and @:@. If the user passes an option that is not specified in the
-- option string, we return the @?@ flag. If they pass a valid option
-- and don't pass an argument for the option, but the option requires an
-- argument, we return either @:@ or @?@ - @:@ if the option string
-- begins with a colon, and @?@ otherwise.
getOpt :: String -> [String] -> ([Flag], [String])
getOpt optString [] = ([], [])
getOpt optString (arg:args)
  | arg == "--"          = ([], args)
  | "-" `isPrefixOf` arg = (flags ++ flags'', files'')
  | otherwise            = (flags', arg:files')
    where
      (flags', files') = getOpt optString args

      (flags, args') = foldr g ([], args) (tail arg)
      g arg (flgs, as) = (flag:flgs, as')
        where (flag, as') = getAnOpt optString arg as

      (flags'', files'') = getOpt optString args'

getAnOpt :: String -> Char -> [String] -> (Flag, [String])
getAnOpt optString arg args
  | isArgFlag arg optString    = optArg optString arg args
  | arg `elem` optString       = ((arg, Nothing), args)
  | otherwise                  = (('?', Nothing), args)

optArg :: String -> Char -> [String] -> (Flag, [String])
optArg optString arg []
  | ":" `isPrefixOf` optString = ((':', Nothing), [])
  | otherwise                  = (('?', Nothing), [])
optArg optString arg (opt:args) = ((arg, Just opt), args)

isArgFlag :: Char -> String -> Bool
isArgFlag arg optString = inOptString && optStringColon
  where
    inOptString = arg `elem` optString
    optStringColon = maybe False (== ':') $ arg `afterElem` optString

module Test.GetOptSpecs (getOptSpecs) where

import Test.Hspec
import Test.QuickCheck

import Rcm.GetOpt (getOpt)

getOptSpecs = describe "Rcm.GetOpt" $ do
  context "getOpt" $ do
    it "parses empty arguments" $
      getOpt "x" [] `shouldBe` ([], [])

    it "parses complex situations" $
      let args = ["-x", "f1", "-y", "y-file", "-x", "f2"]
          expected = (
            [('x', Nothing), ('y', Just "y-file"), ('x', Nothing)],
            ["f1", "f2"]
            ) in
      getOpt "xy:z" args `shouldBe` expected

    it "handles an unheard of option" $
      let args = ["-x", "-y"]
          expected = ([('x', Nothing), ('?', Nothing)], []) in
      getOpt "x" args `shouldBe` expected

    it "handles a missing option argument" $
      let args = ["-x"]
          expected = ([('?', Nothing)], []) in
      getOpt "x:" args `shouldBe` expected

    it "handles a missing option argument with colon" $
      let args = ["-x"]
          expected = ([(':', Nothing)], []) in
      getOpt ":x:" args `shouldBe` expected

    it "handles mistakes and successes combined" $
      let args = ["-x", "-y", "f1", "-z", "-q", "f2"]
          expected = (
            [('x', Nothing), ('y', Just "f1"), ('z', Just "-q")],
            ["f2"]) in
      getOpt "xy:z:q" args `shouldBe` expected

    it "handles forced end of parsing" $
      let args = ["-x", "--", "-z", "-q", "f1"]
          expected = ([('x', Nothing)], ["-z", "-q", "f1"]) in
       getOpt "xy:z:q" args `shouldBe` expected

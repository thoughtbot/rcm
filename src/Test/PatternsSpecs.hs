module Test.PatternsSpecs (patternsSpecs) where

import Test.Hspec
import Test.QuickCheck
import System.FilePath.Glob (compile, compileWith, compPosix)

import Rcm.Private.Patterns (exclPat)
import Rcm.Private.Data

patternsSpecs = describe "Rcm.Private.Patterns" $ do
  context "exclPat" $ do
    it "parses a simple pattern" $
      let expectedPattern = compile "bash_profile" in
      exclPat "bash_profile" `shouldBe` ExclPatAll expectedPattern

    it "parses a glob" $
      let expectedPattern = compile "bash*" in
      exclPat "bash*" `shouldBe` ExclPatAll expectedPattern

    it "parses a fancy glob" $
      let glob = "bash/**/*history*" 
          expectedPattern = compileWith compPosix glob in
      exclPat glob `shouldBe` ExclPatAll expectedPattern

    it "parses a dotfile directory" $
      let glob = "*emacs*"
          pattern = "df:" ++ glob
          expectedPattern = compile glob
          expected = ExclPatDotfileDir "df" expectedPattern in
      exclPat pattern `shouldBe` expected

module Test.LsrcSpecs (lsrcSpecs) where

import Test.Hspec
import Test.QuickCheck
import System.FilePath (FilePath)
import Data.List (isSuffixOf)
import Rcm.Private.Data

import Rcm.Private.Lsrc (parseArgs, defaultConfig, handleOpt)

data HandleOptArg = HandleOpt Char String Config (Config -> [String])

lsrcSpecs = describe "Rcm.Private.Lsrc" $ do

  context "parseArgs" $ do
    it "turns sigils on when passed -F" $
      let c = mkConfig { showSigils = False } in
      parseArgs c ["-F"] `shouldBe` (c { showSigils = True }, [])

    it "adds the inclusion pattern when passed -I" $
      let c = mkConfig { includes = [] } in
      parseArgs c ["-I", "pat"] `shouldBe` (c { includes = ["pat"] }, [])

  context "defaultConfig" $ do
    it "sets a default dotfiles directory" $
      dotfilesDirs (defaultConfig "/tmp") `shouldBe` ["/tmp/.dotfiles"]

  context "handleOpt" $ do
    it "augments Configs when the opt takes an argument" $ property $
      \(HandleOpt opt arg c get) ->
        let c' = handleOpt (opt, (Just arg)) c in
        (get c) `isSuffixOf` (get c')

instance Show HandleOptArg where
  show (HandleOpt opt arg c _) =
    "HandleOpt " ++ (show opt) ++ " " ++ (show arg) ++ " " ++ (show c)

instance Arbitrary HandleOptArg where
  arbitrary = elements [
    HandleOpt 'I' "pat" (mkConfig { includes = ["foo"] }) includes
   ,HandleOpt 't' "tag" (mkConfig { tags = ["foo"] }) tags
   ,HandleOpt 'd' "dir" (mkConfig { dotfilesDirs = ["foo"] }) dotfilesDirs
   ,HandleOpt 'x' "pat" (mkConfig { excludes = ["foo"] }) excludes
   ,HandleOpt 'S' "pat" (mkConfig { symlinkDirs = ["foo"] }) symlinkDirs
    ]

mkConfig = Config {
  showSigils = False
 ,showHelp = False
 ,includes = []
 ,tags = []
 ,verbosity = 0
 ,dotfilesDirs = []
 ,showVersion = False
 ,excludes = []
 ,symlinkDirs = []
}

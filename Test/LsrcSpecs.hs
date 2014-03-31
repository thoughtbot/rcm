module Test.LsrcSpecs (lsrcSpecs) where

import Test.Hspec
import Rcm.Private.Lsrc (parseArgs, defaultConfig, Config(..))
import System.FilePath (FilePath)

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

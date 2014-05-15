module Test.RcrcSpecs (rcrcSpecs) where

import Test.Hspec
import System.FilePath (joinPath)
import System.Posix.Temp (mkdtemp)
import Data.List (intercalate)
import Rcm.Private.Data

import Rcm.Private.Rcrc (readRcrc, parseRcrc)

rcrcSpecs = describe "Rcm.Private.Rcrc" $ do

  context "readRcrc" $ do
    it "produces the contents of the .rcrc" $
      let test = do
          homedir <- mkdtemp "/tmp/rcm"
          writeFile (joinPath [homedir, ".rcrc"]) sampleRcrc
          readRcrc homedir in

      test `shouldReturn` sampleRcrc

    it "produces the empty string if no .rcrc exists" $
      let test = do
          homedir <- mkdtemp "/tmp/rcm"
          readRcrc homedir in

      test `shouldReturn` ""

  context "parseRcrc" $ do
    it "updates the given config" $
      let c = Config { 
             showSigils = False
            ,showHelp = False
            ,includes = []
            ,tags = []
            ,verbosity = 0
            ,dotfilesDirs = ["/tmp/foo"]
            ,showVersion = False
            ,excludes = []
            ,symlinkDirs = []
            ,homeDir = "/tmp"
            ,hostname = "baz"
          }
          expectedConfig = Config {
             showSigils = False
            ,showHelp = False
            ,includes = []
            ,tags = ["freebsd", "development", "email", "git", "laptop", "gmail"]
            ,verbosity = 0
            ,dotfilesDirs = ["/home/mike/.dotfiles", "/usr/share/dotfiles"]
            ,showVersion = False
            ,excludes = ["irbrc", "*:*emacs*", "dotfiles:python*"]
            ,symlinkDirs = ["zprezto"]
            ,homeDir = "/tmp"
            ,hostname = "baz"
            }
          in

      parseRcrc sampleRcrc c `shouldBe` expectedConfig

sampleRcrc = intercalate "\n" configs
  where
    configs = [
       "COPY_ALWAYS=\"ssh/id_* weechat/* netrc\""
      ,"DOTFILES_DIRS=\"/home/mike/.dotfiles /usr/share/dotfiles\""
      ,"EXCLUDES=\"irbrc *:*emacs* dotfiles:python*\""
      ,"TAGS=\"freebsd development email git laptop gmail\""
      ,"SYMLINK_DIRS=\"zprezto\""
      ]

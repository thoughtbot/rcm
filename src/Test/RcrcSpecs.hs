module Test.RcrcSpecs (rcrcSpecs) where

import Test.Hspec
import System.FilePath (joinPath)
import System.Posix.Temp (mkdtemp)
import Data.List (intercalate)
import Rcm.Private.Data

import Rcm.Private.Rcrc (readRcrc, parseRcrc)

rcrcSpecs = describe "Rcm.Private.Rcrc" $ do

  homedir <- mkdtemp "rcm"

  context "readRcrc" $ do
    around (withHomeAndRcrc homedir) $ do
      it "produces the contents of the .rcrc" $
        readRcrc homedir `shouldReturn` sampleRcrc


withHomeAndRcrc homedir test = do
  writeFile (joinPath [homedir, ".rcrc"]) sampleRcrc
  test

sampleRcrc = intercalate '\n' configs
  where
    configs = [
       "COPY_ALWAYS=\"ssh/id_* weechat/* netrc\""
      ,"DOTFILES_DIRS=\"/home/mike/.dotfiles /usr/share/dotfiles\""
      ,"EXCLUDES=\"irbrc *:*emacs* dotfiles:python*\""
      ,"TAGS=\"freebsd development email git laptop gmail notmuch\""
      ,"SYMLINK_DIRS=\"zprezto\""
      ]

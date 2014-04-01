module Test.DotfilesSpecs (dotfilesSpecs) where

import Test.Hspec
import Test.QuickCheck
import System.Directory
import System.IO
import System.FilePath (joinPath)
import Control.Exception (finally)

import Rcm.Private.Dotfiles (getDotfiles, Dotfile(..))
import Rcm.Private.Data

dotfilesSpecs = describe "Rcm.Private.DotfilesSpecs" $ do
  context "getDotfiles" $ do
    context "normal dotfiles" $ do
      around setupNormalDotfiles $ do
        it "produces dotfiles from the given directories" $
          let config = mkConfig { dotfilesDirs = [tmpDotfileDir] }
              expected = map mkDotfile [
                              joinPath [tmpDotfileDir, "gnupg", "gpg.conf"]
                            , joinPath [tmpDotfileDir, "cabal", "config"]
                            , joinPath [tmpDotfileDir, "zshrc"]
                            , joinPath [tmpDotfileDir, "vimrc"] ] in
          getDotfiles config [] `shouldReturn` expected

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

tmpDotfileDir = "/tmp/rcm-tmp-dotfile-dir"

setupNormalDotfiles :: IO () -> IO ()
setupNormalDotfiles test =
  (createNormalDotfiles >> test) `finally` removeNormalDotfiles

createNormalDotfiles = do
  createDirectory tmpDotfileDir
  createDirectory (joinPath [tmpDotfileDir, "gnupg"])
  createDirectory (joinPath [tmpDotfileDir, "cabal"])
  writeFile (joinPath [tmpDotfileDir, "gnupg", "gpg.conf"]) ""
  writeFile (joinPath [tmpDotfileDir, "cabal", "config"]) ""
  writeFile (joinPath [tmpDotfileDir, "zshrc"]) ""
  writeFile (joinPath [tmpDotfileDir, "vimrc"]) ""

removeNormalDotfiles = removeDirectoryRecursive tmpDotfileDir

mkDotfile filePath = Dotfile { dotfileTarget = filePath }

module Test.DotfilesSpecs (dotfilesSpecs) where

import Test.Hspec
import Test.QuickCheck
import System.Directory
import System.IO
import System.FilePath (joinPath)
import Control.Exception (finally)
import Data.Set (Set)
import qualified Data.Set as Set

import Rcm.Private.Dotfiles (getDotfiles, Dotfile(..))
import Rcm.Private.Data

dotfilesSpecs = describe "Rcm.Private.Dotfiles" $ do
  context "getDotfiles" $ do
    context "normal dotfiles" $ do
      around setupNormalDotfiles $ do
        it "produces dotfiles from the given directories" $
          let config = mkConfig { dotfilesDirs = [tmpDotfileDir] }
              expected = [mkDotfile tmpDotfileDir (Just "gnupg") "gpg.conf"
                         ,mkDotfile tmpDotfileDir (Just "cabal") "config"
                         ,mkDotfile tmpDotfileDir Nothing "zshrc"
                         ,mkDotfile tmpDotfileDir Nothing "vimrc"] in
          getDotfiles config [] `shouldReturnWithSet` expected

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

mkDotfile baseDir path file = Dotfile {
  dotfileTarget = DotfileTarget {
    dtBase = baseDir
   ,dtPath = path
   ,dtFile = file
   ,dtTag  = Nothing
   ,dtHost = Nothing
   }
 ,dotfileSource = "/tmp/unknown"
}

shouldReturnWithSet :: (Show a, Ord a) => IO [a] -> [a] -> Expectation
shouldReturnWithSet action expected =
  action >>= \actual ->
    shouldBe (Set.fromList actual) (Set.fromList expected)

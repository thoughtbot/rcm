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
          let config = mkConfig {
               dotfilesDirs = [tmpDotfileDir], homeDir = tmpHomeDir }
              mkD = mkDotfile tmpHomeDir tmpDotfileDir
              expected = [mkD (Just "gnupg") "gpg.conf"
                         ,mkD (Just "cabal") "config"
                         ,mkD Nothing "zshrc"
                         ,mkD Nothing "vimrc"] in
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
 ,homeDir = "/home/foo"
}

tmpDotfileDir = "/tmp/rcm-tmp-dotfile-dir"
tmpHomeDir = "/tmp/rcm-tmp-home-dir"

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

mkDotfile homeDir baseDir path file = Dotfile {
    dotfileTarget = DotfileTarget {
      dtBase = baseDir
     ,dtPath = path
     ,dtFile = file
     ,dtTag  = Nothing
     ,dtHost = Nothing
     }
   ,dotfileSource = joinPath [homeDir, "." ++ pathAndFile]
  }
  where pathAndFile = maybe file (\p -> joinPath [p, file]) path

shouldReturnWithSet :: (Show a, Ord a) => IO [a] -> [a] -> Expectation
shouldReturnWithSet action expected =
  action >>= \actual ->
    shouldBe (Set.fromList actual) (Set.fromList expected)

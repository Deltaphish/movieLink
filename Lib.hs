module Lib(
  getExtension,
  removeBrackets,
  cleanFiles,
  Posix.createSymbolicLink,
  Posix.createLink,
  Posix.rename,
  Dir.doesDirectoryExist,
  linkFiles
) where

import qualified System.Posix as Posix
import qualified System.Directory as Dir
import Control.Monad.Extra

getExtension :: [Char] -> [Char]
getExtension (x:xs)
  | x == '.' = ['.']
  | otherwise = (getExtension xs) ++ [x]
getExtension [] = []

removeBrackets :: [Char] -> [Char]
removeBrackets (x:xs)
  | x == '[' = removeBrackets $ tail $ dropWhile( /= ']') xs
  | x == '(' = removeBrackets $ tail $ dropWhile( /= ')') xs
  | otherwise = x : (removeBrackets xs)
removeBrackets [] = []

--TODO: Add error handling to cleanDir

cleanFiles :: String -> IO [(String,String)]
cleanFiles x = do
 files <- Dir.listDirectory x
 return(zip files (map removeBrackets files))

linkFiles :: String -> String -> (String -> String -> IO ()) -> IO()
linkFiles srcDir tgtDir linker = cleanFiles srcDir >>= \files -> mapM (\(f1,f2) -> linker (srcDir ++ ['/'] ++ (f1::String)) (tgtDir ++ ['/'] ++ (f2::String))) files >> return()


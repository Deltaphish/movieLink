module Main where

import System.Environment
import Lib

printHelp :: IO()
printHelp = putStr "movieLinker: clean and link files from dir A to dir B\n" >>
            putStr "Usage: movieLinker srcDir tgtDir [opt]\n" >>
            putStr "[opt]ions: --hard -> Create Hard link (Default)\n" >>
            putStr "           --soft -> Create Symbolic link\n" >>
            putStr "           --move -> Move files\n" >>
            putStr "\n">>
            putStr "movieLinker -v for version\n" >>
            putStr "movieLinker -h or --help to get this message\n"

printVersion :: IO()
printVersion = putStr "movieLinker version 0.1.0: Written in Haskel\n"

movieLinker :: [String] -> IO()

movieLinker [src,tgt] = linkFiles src tgt createLink
movieLinker [src,tgt,opt]
  | opt == "--soft" = linkFiles src tgt createSymbolicLink
  | opt == "--hard" = linkFiles src tgt createLink
  | opt == "--move" = linkFiles src tgt rename
  | otherwise = printHelp

movieLinker ["-v"] = printVersion
movieLinker _  = printHelp

main :: IO ()
main = do
 args <- getArgs
 movieLinker args

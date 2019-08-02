module Main where

import System.Environment
import Lib

printHelp :: IO()
printHelp = putStr "movieLink: clean and link files from dir A to dir B\n" >>
            putStr "Usage: movieLink srcDir tgtDir [opt]\n" >>
            putStr "[opt]ions: --hard -> Create Hard link (Default)\n" >>
            putStr "           --soft -> Create Symbolic link\n" >>
            putStr "           --move -> Move files\n" >>
            putStr "\n">>
            putStr "movieLink -v for version\n" >>
            putStr "movieLink -h or --help to get this message\n"

printVersion :: IO()
printVersion = putStr "movieLink version 0.1.0: Written in Haskel\n"

movieLink :: [String] -> IO()

movieLink [src,tgt] = linkFiles src tgt createLink
movieLink [src,tgt,opt]
  | opt == "--soft" = linkFiles src tgt createSymbolicLink
  | opt == "--hard" = linkFiles src tgt createLink
  | opt == "--move" = linkFiles src tgt rename
  | otherwise = printHelp

movieLink ["-v"] = printVersion
movieLink _  = printHelp


makeAddrAbs :: [String] -> IO [String]
makeAddrAbs (src:xs) = canonicalizePath src >>= \f -> return(f:xs)

main :: IO ()
main = do
 args <- getArgs
 args_abs <- makeAddrAbs args
 movieLink args_abs

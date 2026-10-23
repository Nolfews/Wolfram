{-
-- EPITECH PROJECT, 2025
-- Haskell
-- File description:
-- Lib
-}

module Lib
    ( wolfram
    ) where

import Types
import Parser
import Rules
import Display
import System.Environment (getArgs)

initialGeneration :: Int -> Generation
initialGeneration width =
    let mid = width `div` 2
        gen = replicate width Dead
    in take width $
        take mid gen ++ [Alive] ++ drop (mid + 1) gen

runGenerations :: Options -> Generation -> Int -> IO ()
runGenerations opts gen count
    | Just n <- numLines opts, count >= n + start opts = return ()
    | count >= start opts =
        let baseOffset = (length gen - window opts) `div` 2
            offset = baseOffset - move opts
            displayed = take (window opts) $ drop offset gen
        in displayGeneration (window opts) displayed >>
            runGenerations opts (nextGeneration (rule opts) gen) (count + 1)
    | otherwise =
        runGenerations opts (nextGeneration (rule opts) gen) (count + 1)


wolfram :: IO ()
wolfram = do
    args <- getArgs
    opts <- parseArgs args
    let width = window opts * 3
        initialGen = initialGeneration width
    runGenerations opts initialGen 0

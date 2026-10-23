{-
-- EPITECH PROJECT, 2025
-- Haskell
-- File description:
-- Display
-}

module Display
    ( displayGeneration
    ) where

import Types

cellToChar :: Cell -> Char
cellToChar Alive = '*'
cellToChar Dead = ' '

displayGeneration :: Int -> Generation -> IO ()
displayGeneration width gen =
    putStrLn $ map cellToChar $ take width gen

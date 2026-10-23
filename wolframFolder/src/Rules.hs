{-
-- EPITECH PROJECT, 2025
-- Haskell
-- File description:
-- Rules
-}

module Rules
    ( nextGeneration
    ) where

import Types

cellsToInt :: (Cell, Cell, Cell) -> Int
cellsToInt (l, c, r) =
    let toBit Dead = 0
        toBit Alive = 1
    in (toBit l) * 4 + (toBit c) * 2 + (toBit r)

isBitSet :: Int -> Int -> Bool
isBitSet number pos = (number `div` (2^pos)) `mod` 2 == 1

applyRule :: Rule -> (Cell, Cell, Cell) -> Cell
applyRule (Rule ruleNumber) pattern =
    let index = cellsToInt pattern
    in if isBitSet ruleNumber index
        then Alive
        else Dead

getNeighbors :: Generation -> Int -> (Cell, Cell, Cell)
getNeighbors gen pos =
    let left = if pos > 0 then gen !! (pos - 1) else Dead
        center = gen !! pos
        right = if pos < length gen - 1 then gen !! (pos + 1) else Dead
    in (left, center, right)

nextGeneration :: Rule -> Generation -> Generation
nextGeneration rule gen =
    [applyRule rule (getNeighbors gen i) | i <- [0..length gen - 1]]

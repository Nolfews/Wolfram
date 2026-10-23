{-
-- EPITECH PROJECT, 2025
-- B-FUN-400-NAN-4-1-wolfram-nolan.papa
-- File description:
-- Types
-}

module Types where

data Pixel = Pixel Int Int Int deriving (Show, Eq)
type Image = [[Pixel]]

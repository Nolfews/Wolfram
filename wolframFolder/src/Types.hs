{-
-- EPITECH PROJECT, 2025
-- Haskell
-- File description:
-- Types
-}

module Types
    ( Options(..)
    , Rule(..)
    , Generation
    , Cell(..)
    ) where

newtype Rule = Rule Int
    deriving (Show, Eq)

data Cell = Dead | Alive
    deriving (Show, Eq)

type Generation = [Cell]

data Options = Options
    { rule :: Rule
    , start :: Int
    , numLines :: Maybe Int
    , window :: Int
    , move :: Int
    } deriving (Show)

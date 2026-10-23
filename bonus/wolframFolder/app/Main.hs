{-
-- EPITECH PROJECT, 2025
-- Haskell
-- File description:
-- Main
-}

module Main where

import Convert
import Display
import Lib
import Resize

main :: IO ()
main = do
    putStrLn "Entrez le chemin de l'image BMP :"
    path <- getLine
    img <- readBMP path
    resizedImg <- resizeImage img
    printASCIIImage resizedImg

{-
-- EPITECH PROJECT, 2025
-- B-FUN-400-NAN-4-1-wolfram-nolan.papa
-- File description:
-- Convert
-}

module Convert where

import Types (Pixel, Image)

-- Convertir un pixel en niveau de gris
pixelToGray :: Pixel -> Int
pixelToGray (Pixel r g b) = round (0.3 * fromIntegral r + 0.59 * fromIntegral g + 0.11 * fromIntegral b)

-- Table des caractères ASCII (du plus foncé au plus clair)
asciiChars :: String
asciiChars = "@%#*+=-:. "

-- Convertir un pixel en caractère ASCII
pixelToChar :: Pixel -> Char
pixelToChar p = let gray = pixelToGray p
                    index = (gray * (length asciiChars - 1)) `div` 255
                in asciiChars !! index

-- Convertir une image en ASCII
imageToASCII :: Image -> [String]
imageToASCII = map (map pixelToChar)

{-
-- EPITECH PROJECT, 2025
-- B-FUN-400-NAN-4-1-wolfram-nolan.papa
-- File description:
-- Resize
-}

module Resize where

import Types (Pixel, Image)
import System.Console.Terminal.Size (Window(..), size)

-- Redimensionner une image (en échantillonnant)
resizeImage :: Image -> IO Image
resizeImage [] = return []
resizeImage img = do
    maybeWin <- size
    let (h, w) = case maybeWin of
                    Just (Window h w) -> (h - 2, w `div` 2)
                    Nothing -> (40, 80)
        origH = length img
        origW = if null img then 0 else length (head img)
        stepX = max 1 (origW `div` w)
        stepY = max 1 (origH `div` h)
    return [[img !! (y * stepY) !! (x * stepX) | x <- [0..w-1], x * stepX < origW]
                                             | y <- [0..h-1], y * stepY < origH]


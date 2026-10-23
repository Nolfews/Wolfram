{-
-- EPITECH PROJECT, 2025
-- B-FUN-400-NAN-4-1-wolfram-nolan.papa
-- File description:
-- Display
-}

module Display where

import Types (Pixel, Image)
import System.Console.ANSI (setSGR, SGR(..), Color(..), ConsoleLayer(..))
import System.Console.ANSI (clearScreen, setCursorPosition)

-- Afficher un caractère en couleur ANSI
printPixel :: Pixel -> Char -> IO ()
printPixel (r, g, b) c = do
    setSGR [SetColor Foreground Vivid (rgbColor r g b)]  -- Appliquer la couleur à l'avant-plan
    putChar c  -- Afficher le caractère

-- Convertir un pixel (r, g, b) en une couleur ANSI approximée
rgbColor :: Int -> Int -> Int -> Color
rgbColor r g b
  | r > 128 && g <= 128 && b <= 128 = Red
  | g > 128 && r <= 128 && b <= 128 = Green
  | b > 128 && r <= 128 && g <= 128 = Blue
  | r > 128 && g > 128 && b <= 128 = Yellow
  | r <= 128 && g > 128 && b > 128 = Magenta
  | r <= 128 && g <= 128 && b > 128 = Cyan
  | r > 128 && g > 128 && b > 128 = White
  | otherwise = Black  -- Par défaut, la couleur noire si aucune condition n'est remplie

-- Afficher l'image ASCII en couleur
printASCIIImage :: Image -> IO ()
printASCIIImage img = do
    clearScreen
    setCursorPosition 0 0
    let asciiImg = imageToASCII img
    mapM_ (\(row, asciiRow) -> do
        mapM_ (\(pixel, char) -> printPixel pixel char) (zip row asciiRow)
        putStrLn ""
        ) (zip img asciiImg)
    setSGR [Reset]  -- Réinitialiser les attributs de couleur après l'affichage

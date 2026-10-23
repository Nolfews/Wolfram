{-
-- EPITECH PROJECT, 2025
-- Haskell
-- File description:
-- Lib
-}

module Lib where

import System.IO
import Data.Word (Word8)
import Data.List (intercalate)
import Data.Bits (shiftL, (.|.))
import Control.Monad (replicateM)
import System.Console.ANSI (setCursorPosition, clearScreen)
import Data.Char (ord)
import Types (Pixel)

type Image = [[Pixel]]        -- Matrice de pixels

-- Lire un entier 4 octets (Little Endian)
readInt32LE :: Handle -> IO Int
readInt32LE h = do
    b1 <- fromIntegral . ord <$> hGetChar h
    b2 <- fromIntegral . ord <$> hGetChar h
    b3 <- fromIntegral . ord <$> hGetChar h
    b4 <- fromIntegral . ord <$> hGetChar h
    return $ b1 .|. (b2 `shiftL` 8) .|. (b3 `shiftL` 16) .|. (b4 `shiftL` 24)

-- Lire un entier 2 octets (Little Endian)
readInt16LE :: Handle -> IO Int
readInt16LE h = do
    b1 <- fromIntegral . ord <$> hGetChar h
    b2 <- fromIntegral . ord <$> hGetChar h
    return $ b1 .|. (b2 `shiftL` 8)

-- Lire un pixel (BGR -> RGB)
readPixel :: Handle -> IO Pixel
readPixel h = do
    b <- fromIntegral . ord <$> hGetChar h
    g <- fromIntegral . ord  <$> hGetChar h
    r <- fromIntegral . ord <$> hGetChar h
    return (fromIntegral r, fromIntegral g, fromIntegral b)

-- Lire une ligne de pixels (BMP aligne les lignes sur des multiples de 4 octets)
readRow :: Handle -> Int -> IO [Pixel]
readRow h width = do
    pixels <- replicateM width (readPixel h)
    let padding = (4 - (width * 3) `mod` 4) `mod` 4
    _ <- replicateM padding (hGetChar h)  -- Ignorer le padding
    return pixels

-- Lire une image BMP
readBMP :: FilePath -> IO Image
readBMP path = withBinaryFile path ReadMode $ \h -> do
    _ <- replicateM 18 (hGetChar h)  -- Ignorer les 18 premiers octets
    width  <- readInt32LE h
    height <- readInt32LE h
    _ <- replicateM 28 (hGetChar h)  -- Ignorer le reste de l'en-tête
    rows <- replicateM height (readRow h width)
    return $ reverse rows  -- BMP stocke l'image de bas en haut

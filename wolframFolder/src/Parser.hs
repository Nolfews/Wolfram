{-
-- EPITECH PROJECT, 2025
-- Haskell
-- File description:
-- Parser
-}

module Parser
    ( parseArgs
    , usage
    ) where

import Types
import System.Exit (exitWith, ExitCode(..))
import System.IO (hPutStrLn, stderr)

usage :: IO Options
usage = exitWithUsage

exitWithUsage :: IO Options
exitWithUsage = hPutStrLn stderr ("USAGE: ./wolfram [--rule n] [--start n]" ++
        " [--lines n] [--window n] [--move n]") >>
    hPutStrLn stderr " --rule : ruleset to use (0-255)" >>
    hPutStrLn stderr (" --start : generation number at which to start the"
        ++ "display (default: 0)") >>
    hPutStrLn stderr " --lines : number of lines to display" >>
    hPutStrLn stderr (" --window : number of cells to display on each line"
        ++ "(default: 80)") >>
    hPutStrLn stderr " --move : translation to apply on the window" >>
    exitWith (ExitFailure 84)

parseRule :: String -> Maybe Rule
parseRule n = case reads n of
    [(num, "")] | num >= 0 && num <= 255 -> Just (Rule num)
    _ -> Nothing

parseArgs :: [String] -> IO Options
parseArgs [] = exitWithUsage
parseArgs args = parseArgs' args defaultOptions
    where
        defaultOptions = Options
            { rule = Rule 30
            , start = 0
            , numLines = Nothing
            , window = 80
            , move = 0
            }

parseArgs' :: [String] -> Options -> IO Options
parseArgs' [] opts = return opts
parseArgs' ("--rule":n:rest) opts = case parseRule n of
    Just r -> parseArgs' rest (opts { rule = r })
    Nothing -> exitWithUsage
parseArgs' ("--start":n:rest) opts = case reads n of
    [(num, "")] -> parseArgs' rest (opts { start = num })
    _ -> exitWithUsage
parseArgs' ("--lines":n:rest) opts = case reads n of
    [(num, "")] -> parseArgs' rest (opts { numLines = Just num })
    _ -> exitWithUsage
parseArgs' ("--window":n:rest) opts = case reads n of
    [(num, "")] -> parseArgs' rest (opts { window = num })
    _ -> exitWithUsage
parseArgs' ("--move":n:rest) opts = case reads n of
    [(num, "")] -> parseArgs' rest (opts { move = num })
    _ -> exitWithUsage
parseArgs' _ _ = exitWithUsage

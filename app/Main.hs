{-# LANGUAGE DeriveDataTypeable #-}
{-# OPTIONS_GHC -fno-cse #-}

module Main where


import           Lib
import           System.Console.CmdArgs
import           System.Exit

import qualified Data.Text              as DText
import qualified Data.Text.IO           as DText



-- Datatype for cmdArgs
data EasyPasswordGenerator = EasyPasswordGenerator {arg1 :: String, arg2 :: String, arg3 :: String, number :: Int} deriving(Data, Show, Typeable)

createEasyPasswordGenerator = EasyPasswordGenerator
    {arg1 = def &= typ "file" &= argPos 0
    ,arg2 = def &= typ "seperator1" &= argPos 1
    ,arg3 = def &= typ "seperator2" &= argPos 2
    ,number = 4 &= typ "number" &= help "Number of words used for the password"
    } &= help "A program to create passwords like in xkcd.com/936.\nThe file has to have one word per line.\nOne seperator should be a special character.\nThe other seperator should be a number."
    &= program "easy-password"
    &= summary "easy-password v1.0"


-- auxiliary functions to get the arguments
pullOut :: EasyPasswordGenerator -> [String]
pullOut (EasyPasswordGenerator arg1 arg2 arg3 arg4) = [arg1, arg2, arg3]

pullInt :: EasyPasswordGenerator -> Int
pullInt (EasyPasswordGenerator arg1 arg2 arg3 arg4) = arg4


-- main function
--
-- The function gets the arguments and creates then a easy to remember but secure password.
--main = cmdArgs createEasyPasswordGenerator >>= \args -> fmap DText.lines (DText.readFile (head (pullOut args))) >>= \wordlist -> rand (pullInt args) >>= \nums -> prePassword wordlist nums (pullInt args) >>= \list -> putStrLn (password (pullOut args !! 1) (pullOut args !! 2) list) >>= \_ -> exitSuccess
main = do
    -- get the arguments from create
    args <- cmdArgs createEasyPasswordGenerator
    -- get the file with the words that should be used
    wordlist <- fmap DText.lines (DText.readFile (head (pullOut args)))
    -- list with random numbers
    nums <- rand (pullInt args)
    -- creating of a random list of words
    list <- chooseWords wordlist nums (pullInt args)
    -- generate password
    putStrLn (password (pullOut args !! 1) (pullOut args !! 2) list)
    -- exit
    exitSuccess

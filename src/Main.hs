{-# LANGUAGE DeriveDataTypeable #-}
{-# OPTIONS_GHC -fno-cse #-}

module Main where
import           Control.Monad
import           Data.List
import           Raaz
import           System.Console.CmdArgs
import           System.Environment
import           System.Exit

import qualified Data.Text              as DText
import qualified Data.Text.IO           as DText



-- main function
--
-- The function gets the arguments and creates then a easy to remember but secure password.

-- main = cmdArgs Main.create >>= \args -> fmap DText.lines (DText.readFile (head (pullOut args))) >>= \wordlist -> rand (pullInt args) >>= \nums -> prePassword wordlist nums (pullInt args) >>= \list -> putStrLn (password (pullOut args !! 1) (pullOut args !! 2) list)

main = do
    -- get the arguments from create
    args <- cmdArgs Main.create
    -- get the file with the words that should be used
    wordlist <- fmap DText.lines (DText.readFile (head (pullOut args)))
    -- list with random numbers
    nums <- rand (pullInt args)
    -- creating of a random list of words
    list <- prePassword wordlist nums (pullInt args)
    -- generate password
    putStrLn (password (pullOut args !! 1) (pullOut args !! 2) list)



-- Datatype for cmdArgs

data EasyPasswordGenerator = EasyPasswordGenerator {arg1 :: String, arg2 :: String, arg3 :: String, number :: Int} deriving(Data, Show, Typeable)

create = EasyPasswordGenerator
    {arg1 = def &= typ "file" &= argPos 0
    ,arg2 = def &= typ "seperator 1" &= argPos 1
    ,arg3 = def &= typ "seperator 2" &= argPos 2
    ,number = 4 &= typ "number" &= help "Number of words used for the password"
    } &= help "A program to create passwords like in xkcd.com/936"
    &= program "easypassword"
    &= summary "easypassword v0.1"


-- auxiliary functions to get the arguments

pullOut :: EasyPasswordGenerator -> [String]
pullOut (EasyPasswordGenerator arg1 arg2 arg3 arg4) = [arg1, arg2, arg3]

pullInt :: EasyPasswordGenerator -> Int
pullInt (EasyPasswordGenerator arg1 arg2 arg3 arg4) = arg4


-- auxiliary function for random numbers
--
-- Creates a list of random numbers from a cryptographically secure random number generator

rand :: Int -> IO [Int]
rand 0 = return []
rand n = do
    r  <- insecurely (random :: RandM Int)
    rs <- rand (n-1)
    return (r:rs)


-- password creation function
--
-- "str1" is Argument 1 and "str2" is Argument 2. These get interlaced in between the
-- words from the list xs to create a secure and easy to remember password.

password :: String -> String -> [String] -> String
password str1 str2 [] = ""
password str1 str2 xs = head xs ++ str1 ++ password str2 str1 (tail xs)


-- random word collector
--
-- Creates a list of random words with the help of a list of random numbers.

prePassword :: [DText.Text] -> [Int] -> Int -> IO [String]
prePassword xs ys 0 = return []
prePassword xs ys n = do
    let r = DText.unpack x
    rs <- prePassword (delete x xs) (tail ys) (n-1)
    return (r:rs)
      where x = xs !! mod (head ys) (Data.List.length xs - 1)

--prePassword :: [DText.Text] -> [Int] -> Int -> [String]
--prePassword xs ys 0 = []
--prePassword xs ys n = DText.unpack x : prePassword (delete x xs) (tail ys) (n-1)
--    where x = xs !! mod (head ys) (Data.List.length xs - 1)

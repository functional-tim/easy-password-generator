{-# OPTIONS_GHC -fno-cse #-}

module Lib
    ( chooseWords
    , rand
    , password
    ) where


import           Data.List
import           Raaz

import qualified Data.Char              as Char
import qualified Data.Text              as DText
import qualified Data.Text.IO           as DText



-- auxiliary function for random numbers
--
-- Creates a list of random numbers from a cryptographically secure random number generator

rand :: Int -> IO [Int]
rand 0 = return []
rand n = do
    r  <- insecurely ran
    rs <- rand (n-1)
    return (r:rs)
        where ran :: RandM Int
              ran = random


-- auxiliary function to capitalize first letter of every word

capitalized :: String -> String
capitalized (head:tail) = Char.toUpper head : tail


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

chooseWords :: [DText.Text] -> [Int] -> Int -> IO [String]
chooseWords xs ys 0 = return []
chooseWords xs ys n = do
    let r = capitalized (DText.unpack x)
    rs <- chooseWords (delete x xs) (tail ys) (n-1)
    return (r:rs)
      where x = xs !! mod (head ys) (Data.List.length xs - 1)

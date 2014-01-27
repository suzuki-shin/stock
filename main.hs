{-# OPTIONS_GHC -Wall #-}

import Text.XML.HXT.Core
import Text.HandsomeSoup
-- import Control.Monad.Trans.Maybe
import Data.List (intersperse)
import Data.List.Split

main :: IO ()
main = do
  as <- kenmile "tmp/kenmile_utf8_1.html"
  let ids = map head as
  mapM_ putStrLn ids

kenmile :: FilePath -> IO [[String]]
kenmile file = do
  c <- readFile file
  let doc = readString [withParseHTML yes, withWarnings no] c
  as <- runX $ doc >>> css "table" >>> hasAttrValue "id" (=="dataTable") //> css "td" //> css "a" //> getText
--   mapM_ putStrLn as
  return $ map (splitOn " ") as

printJsIdList :: [String] -> IO ()
printJsIdList idList = do
  let jsStr = "var idList = [" ++ concatWithCommna idList ++ "];"
  writeFile "html/idList.js" jsStr

concatWithCommna :: [String] -> String
concatWithCommna = concat . intersperse ","

-- yahooFinance file = do
--   c <- readFile file
--   let doc = readString [withParseHTML yes, withWarnings no] c
--   trs <- runX $ doc >>> css "table" >>> hasAttrValue "class" (=="boardFin yjSt marB6") //> css "tr"


data Company = Company {
  companyCode :: Integer
 ,companyName :: String
} deriving (Show)

data Price = Price {
  company :: Company
 ,start :: Double
 ,high :: Double
 ,low :: Double
 ,finish :: Double
 ,adjusted :: Double
} deriving (Show)


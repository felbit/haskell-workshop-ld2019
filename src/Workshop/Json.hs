{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Workshop.Json where

import Data.List (intercalate)
import Data.Aeson (FromJSON, ToJSON, eitherDecode)
import GHC.Generics (Generic)
import qualified Data.ByteString.Lazy as B
import Network.HTTP.Conduit (simpleHttp)

-- hints:
-- type FilePath = String
-- readFile :: FilePath -> IO ByteString
-- simpleHttp :: MonadIO m => String -> m ByteString
-- decode :: FromJSON a => ByteString -> Maybe a
-- eitherDecode :: FromJSON a => ByteString -> Either String a
-- (<$>) :: Functor f => (a -> b) -> f a -> f b
-- fmap  :: Functor f => (a -> b) -> f a -> f b


-- TASK 1
data ToDo = ToDo
    { userId    :: Int 
    , id        :: Int
    , title     :: String
    , completed :: Bool
    } deriving (Show, Eq, Generic, FromJSON, ToJSON)

-- TASK 2
decodeToDos :: B.ByteString -> Either String [ToDo]
decodeToDos = eitherDecode

-- TASK 3
getToDo :: Int -> IO (Either String ToDo)
getToDo nr = fmap eitherDecode $ simpleHttp $ "https://jsonplaceholder.typicode.com/todos/" ++ show nr
-- from: https://jsonplaceholder.typicode.com/todos/

-------------

-- TASK 4
data Person = Person
    { firstName :: String
    , lastName  :: String
    , age       :: Int
    } deriving (Show, Eq, Generic, FromJSON, ToJSON)

-- TASK 5
jsonFile :: FilePath
jsonFile = "data/people.json"
-- look in `data` folder

-- TASK 6
getJsonByteString :: IO B.ByteString
getJsonByteString = B.readFile jsonFile

-- TASK 7
decodePersons :: B.ByteString -> Either String [Person]
decodePersons = eitherDecode

-- TASK 8
getPersons :: IO (Either String [Person])
getPersons = decodePersons <$> getJsonByteString

-------------

-- TASK 9: Uncomment code below and the commented fragments in tests
-- Check if all tests pass

run :: IO ()
run = do
  personsE <- getPersons
  case personsE of
    Left err -> putStrLn err
    Right persons -> print persons
  todoE <- getToDo 1
  case todoE of
    Left err -> putStrLn err
    Right todo -> print todo
  putStrLn "done"

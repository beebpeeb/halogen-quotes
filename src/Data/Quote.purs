module Quotes.Data.Quote
  ( Quote
  , Quotes
  , count
  , decodeQuotes
  , first
  , printAuthor
  , printContent
  ) where

import Prelude

import Data.Argonaut (class DecodeJson, Json, JsonDecodeError, (.:), decodeJson)
import Data.Either (Either)
import Data.List.NonEmpty (NonEmptyList, head, length)
import Data.String.NonEmpty (NonEmptyString, toString)
import Data.Traversable (traverse)

type Quotes = NonEmptyList Quote

newtype Quote = Quote
  { author :: NonEmptyString
  , content :: NonEmptyString
  }

derive instance eqQuote :: Eq Quote

derive instance ordQuote :: Ord Quote

instance decodeJsonQuote :: DecodeJson Quote where
  decodeJson json = do
    obj <- decodeJson json
    author <- obj .: "author"
    content <- obj .: "content"
    pure $ Quote { author, content }

instance showQuote :: Show Quote where
  show quote = "(Quote " <> show (printContent quote) <> ")"

count :: Quotes -> Int
count = length

decodeQuotes :: Json -> Either JsonDecodeError Quotes
decodeQuotes = decodeJson >=> traverse decodeJson

first :: Quotes -> Quote
first = head

printAuthor :: Quote -> String
printAuthor (Quote { author }) = toString author

printContent :: Quote -> String
printContent (Quote { content }) = toString content

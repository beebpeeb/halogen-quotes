module Quotes.Data.Quote
  ( Quote
  , Quotes
  , decodeJsonQuotes
  , getAuthor
  , getContent
  ) where

import Prelude

import Data.Argonaut (class DecodeJson, Json, JsonDecodeError, (.:), decodeJson)
import Data.Array.NonEmpty (NonEmptyArray)
import Data.Either (Either)
import Data.String.NonEmpty (NonEmptyString, toString)
import Data.Traversable (traverse)

type Quotes = NonEmptyArray Quote

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
  show (Quote q) = "(Quote " <> show q.content <> ")"

decodeJsonQuotes :: Json -> Either JsonDecodeError Quotes
decodeJsonQuotes = decodeJson >=> traverse decodeJson

getAuthor :: Quote -> String
getAuthor (Quote q) = toString q.author

getContent :: Quote -> String
getContent (Quote q) = toString q.content

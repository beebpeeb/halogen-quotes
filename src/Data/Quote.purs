module Quotes.Data.Quote
  ( Quote
  , Quotes
  , decodeQuotes
  , getFirstQuote
  , printAuthor
  , printContent
  ) where

import Prelude

import Data.Argonaut (class DecodeJson, Json, JsonDecodeError, (.:), decodeJson)
import Data.Array.NonEmpty (NonEmptyArray, head)
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
  show quote = "(Quote " <> show (printContent quote) <> ")"

decodeQuotes :: Json -> Either JsonDecodeError Quotes
decodeQuotes = decodeJson >=> traverse decodeJson

getFirstQuote :: Quotes -> Quote
getFirstQuote = head

printAuthor :: Quote -> String
printAuthor (Quote { author }) = toString author

printContent :: Quote -> String
printContent (Quote { content }) = toString content

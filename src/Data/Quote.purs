module Quotes.Data.Quote where

import Prelude

import Data.Argonaut (class DecodeJson, (.:), decodeJson)
import Data.String.NonEmpty (NonEmptyString, toString)

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

printAuthor :: Quote -> String
printAuthor (Quote { author }) = toString author

printContent :: Quote -> String
printContent (Quote { content }) = toString content

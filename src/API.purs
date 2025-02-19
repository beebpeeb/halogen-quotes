module Quotes.API
  ( APIError
  , APIResponse
  , fetchQuotes
  ) where

import Prelude

import Affjax.ResponseFormat (json)
import Affjax.Web (get, printError)
import Data.Argonaut (decodeJson, printJsonDecodeError)
import Data.Bifunctor (lmap)
import Data.Traversable (traverse)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData, fromEither)

import Quotes.Data.Quote (Quotes)

type APIError = String

type APIResponse = RemoteData APIError Quotes

fetchQuotes :: Aff APIResponse
fetchQuotes = fromEither <$> decode <$> get json url
  where
  decode = lmap printError >=> _.body >>> decodeAll >>> lmap printJsonDecodeError
  decodeAll = decodeJson >=> traverse decodeJson
  url = "https://api.quotable.io/quotes/random"

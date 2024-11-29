module Quotes.API
  ( APIError
  , APIResponse
  , fetchQuotes
  ) where

import Prelude

import Affjax.ResponseFormat (json)
import Affjax.Web (URL, get, printError)
import Data.Argonaut (Json, JsonDecodeError, decodeJson, printJsonDecodeError)
import Data.Bifunctor (lmap)
import Data.Either (Either)
import Data.Traversable (traverse)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData, fromEither)

import Quotes.Data.Quote (Quotes)

type APIError = String

type APIResponse = RemoteData APIError Quotes

decodeBody :: Json -> Either JsonDecodeError Quotes
decodeBody = decodeJson >=> traverse decodeJson

fetchQuotes :: Aff APIResponse
fetchQuotes = fromEither <$> decode <$> get json url
  where
  decode = lmap printError >=> _.body >>> decodeBody >>> lmap printJsonDecodeError

url :: URL
url = "https://api.quotable.io/quotes/random"

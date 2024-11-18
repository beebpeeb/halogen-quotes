module Quotes.API where

import Prelude

import Affjax.ResponseFormat (json)
import Affjax.Web (get, printError)
import Data.Argonaut (decodeJson, printJsonDecodeError)
import Data.Bifunctor (lmap)
import Data.Traversable (traverse)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData, fromEither)

import Quotes.Data.Quote (Quote)

type APIError = String

type APIResponse = RemoteData APIError (Array Quote)

fetchQuotes :: Aff APIResponse
fetchQuotes = fromEither <$> decode <$> get json url
  where
  decode = lmap printError >=> decodeBody
  decodeBody = lmap printJsonDecodeError <<< decodeQuotes <<< _.body
  decodeQuotes = decodeJson >=> traverse decodeJson
  url = "https://api.quotable.io/quotes/random"

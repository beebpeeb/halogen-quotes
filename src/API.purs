module Quotes.API
  ( APIError
  , APIResponse
  , fetchQuotes
  ) where

import Prelude

import Affjax.ResponseFormat as ResponseFormat
import Affjax.Web (URL)
import Affjax.Web as Http
import Data.Argonaut (Json, JsonDecodeError)
import Data.Argonaut as Json
import Data.Bifunctor (lmap)
import Data.Either (Either)
import Data.Traversable (traverse)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData)
import Network.RemoteData as RemoteData

import Quotes.Data.Quote (Quote)

type APIError = String

type APIResponse = RemoteData APIError (Array Quote)

decodeJson :: Json -> Either JsonDecodeError (Array Quote)
decodeJson = Json.decodeJson >=> traverse Json.decodeJson

fetchQuotes :: Aff APIResponse
fetchQuotes = RemoteData.fromEither <$> decode <$> Http.get ResponseFormat.json url
  where
  decode = lmap Http.printError >=> decodeBody
  decodeBody = lmap Json.printJsonDecodeError <<< decodeJson <<< _.body

url :: URL
url = "https://api.quotable.io/quotes/random"

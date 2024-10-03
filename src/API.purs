module Quotes.API where

import Prelude

import Affjax.ResponseFormat (json)
import Affjax.Web (get, printError)
import Data.Argonaut (printJsonDecodeError)
import Data.Bifunctor (lmap)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData, fromEither)

import Quotes.Data.Quote (Quotes, decodeJsonQuotes)

type APIError = String

type APIResponse = RemoteData APIError Quotes

fetchQuotes :: Aff APIResponse
fetchQuotes = fromEither <$> decode <$> get json url
  where
  decode = lmap printError >=> decodeBody
  decodeBody = lmap printJsonDecodeError <<< decodeJsonQuotes <<< _.body
  url = "https://api.quotable.io/quotes/random?limit=1"

-- Is it worth implementing an Application Monad for a small application?

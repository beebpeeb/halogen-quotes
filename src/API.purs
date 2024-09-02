module Quotes.API
  ( APIError
  , APIResponse
  , fetchQuotes
  ) where

import Prelude

import Affjax.ResponseFormat as ResponseFormat
import Affjax.Web (URL)
import Affjax.Web as Affjax
import Data.Argonaut as Argonaut
import Data.Bifunctor (bimap, lmap)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData)
import Network.RemoteData as RemoteData

import Quotes.Data.Quote (Quotes)
import Quotes.Data.Quote as Quote

type APIError = String

type APIResponse = RemoteData APIError Quotes

fetchQuotes :: Aff APIResponse
fetchQuotes = Affjax.get ResponseFormat.json url <#> decode
  where
  decode = (lmap Affjax.printError >=> decodeBody) >>> RemoteData.fromEither
  decodeBody { body } = bimap Argonaut.printJsonDecodeError identity (Quote.decode body)

url :: URL
url = "https://api.quotable.io/quotes/random?limit=1"

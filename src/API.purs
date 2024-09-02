module Quotes.API
  ( APIError
  , APIResponse
  , fetchQuotes
  ) where

import Prelude

import Affjax.ResponseFormat (json)
import Affjax.Web (URL, get, printError)
import Data.Argonaut (printJsonDecodeError)
import Data.Bifunctor (bimap, lmap)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData)
import Network.RemoteData as RemoteData
import Quotes.Data.Quote (Quotes)
import Quotes.Data.Quote as Quote

type APIError = String

type APIResponse = RemoteData APIError Quotes

fetchQuotes :: Aff APIResponse
fetchQuotes = get json url <#> decode
  where
  decode = (lmap printError >=> decodeBody) >>> RemoteData.fromEither
  decodeBody { body } = bimap printJsonDecodeError identity (Quote.decode body)

url :: URL
url = "https://api.quotable.io/quotes/random?limit=1"

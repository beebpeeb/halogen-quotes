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
import Network.RemoteData (RemoteData, fromEither)
import Quotes.Data.Quote (Quotes, decodeQuotes)

type APIError = String

type APIResponse = RemoteData APIError Quotes

fetchQuotes :: Aff APIResponse
fetchQuotes = get json url <#> decode
  where
  decode = (lmap printError >=> decodeBody) >>> fromEither
  decodeBody { body } = bimap printJsonDecodeError identity (decodeQuotes body)

url :: URL
url = "https://api.quotable.io/quotes/random?limit=1"

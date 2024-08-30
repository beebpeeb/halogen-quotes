module Quotes.API where

import Prelude

import Affjax.ResponseFormat (json)
import Affjax.Web (URL, get, printError)
import Data.Argonaut (decodeJson, printJsonDecodeError)
import Data.Array.NonEmpty (head)
import Data.Bifunctor (bimap, lmap)
import Data.Traversable (traverse)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData, fromEither)
import Quotes.Data.Quote (Quote)

type APIResponse = RemoteData String Quote

fetchQuote :: Aff APIResponse
fetchQuote = get json url <#> decode
  where
  decode = (lmap printError >=> decodeBody) >>> fromEither
  decodeBody { body } = bimap printJsonDecodeError identity (decodeQuotes body) <#> head
  decodeQuotes = decodeJson >=> traverse decodeJson

url :: URL
url = "https://api.quotable.io/quotes/random?limit=1"

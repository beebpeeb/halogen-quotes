module Quotes.API where

import Prelude

import Affjax.ResponseFormat (json)
import Affjax.Web (get, printError)
import Data.Argonaut (printJsonDecodeError)
import Data.Bifunctor (bimap, lmap)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData, fromEither)

import Quotes.Data.Quote (Quote, decodeJsonQuotes, getFirst)

type APIResponse = RemoteData String Quote

fetchQuotes :: Aff APIResponse
fetchQuotes = get json url >>= decode >>> fromEither >>> pure
  where
  decode =
    lmap printError
      >=> _.body
        >>> decodeJsonQuotes
        >>> bimap printJsonDecodeError getFirst

  url = "https://api.quotable.io/quotes/random?limit=1"

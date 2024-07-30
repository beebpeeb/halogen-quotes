module Quotes.API where

import Prelude

import Affjax.ResponseFormat (json)
import Affjax.Web (get, printError)
import Data.Argonaut (printJsonDecodeError)
import Data.Array.NonEmpty (head)
import Data.Bifunctor (bimap, lmap)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData, fromEither)

import Quotes.Data.Quote (Quote, decodeJsonQuotes)

type APIResponse = RemoteData String Quote

fetchQuote :: Aff APIResponse
fetchQuote = get json url >>= decode >>> fromEither >>> pure
  where
  decode =
    lmap printError
      >=> _.body
        >>> decodeJsonQuotes
        >>> bimap printJsonDecodeError head

  url = "https://api.quotable.io/quotes/random?limit=1"

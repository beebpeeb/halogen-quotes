module Quotes.API where

import Prelude

import Affjax.ResponseFormat (json)
import Affjax.Web (get, printError)
import Data.Argonaut (decodeJson, printJsonDecodeError)
import Data.Array.NonEmpty (head)
import Data.Bifunctor (bimap, lmap)
import Data.Traversable (traverse)
import Effect.Aff (Aff)
import Network.RemoteData (RemoteData, fromEither)
import Quotes.Data.Quote (Quote)

type APIResponse = RemoteData String Quote

fetchQuote :: Aff APIResponse
fetchQuote = do
  response <- get json url
  pure $ decode response
  where
  decode response = fromEither do
    { body } <- lmap printError response
    quotes <- bimap printJsonDecodeError identity (traverse decodeJson =<< decodeJson body)
    pure $ head quotes

  url = "https://api.quotable.io/quotes/random?limit=1"
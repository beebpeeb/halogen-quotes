module Test.API where

import Prelude

import Data.List (null)
import Network.RemoteData (RemoteData(..))
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldSatisfy)

import Quotes.API (APIResponse, fetchQuotes)

spec :: Spec Unit
spec = describe "API" do
  describe "fetchQuotes" do
    it "should fetch a quote successfully" do
      result <- fetchQuotes
      result `shouldSatisfy` isSuccessfulQuote

isSuccessfulQuote :: APIResponse -> Boolean
isSuccessfulQuote = case _ of
  Success quotes -> not $ null quotes
  _ -> false

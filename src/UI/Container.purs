module Quotes.UI.Container where

import Prelude

import Control.Monad.State.Class (modify_)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff, liftAff)
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Halogen.HTML (html_)
import Network.RemoteData (RemoteData(..))

import Quotes.API (fetchQuotes)
import Quotes.UI.Header as Header
import Quotes.UI.Quote as Quote

data Action = FetchQuotes

component :: forall q i o m. MonadAff m => Component q i o m
component =
  mkComponent
    { initialState
    , render
    , eval:
        mkEval
          $ defaultEval
              { handleAction = handleAction
              , initialize = initialize
              }
    }
  where
  handleAction = case _ of
    FetchQuotes -> do
      response <- liftAff fetchQuotes
      modify_ _ { response = response }

  initialState = const { response: Loading }

  initialize = Just FetchQuotes

  render = html_ <<< flap [ Header.render, Quote.render ]

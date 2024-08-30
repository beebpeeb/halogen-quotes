module Quotes.UI.Common where

import Prelude

import Halogen.HTML (HTML)
import Halogen.HTML as H
import Halogen.HTML.Properties as P
import Halogen.Themes.Bootstrap5 as B
import Network.RemoteData (RemoteData(..))
import Quotes.API (APIResponse)

type State = { response :: APIResponse }

responseEmoji :: forall e a w i. RemoteData e a -> HTML w i
responseEmoji = H.text <<< case _ of
  Loading -> "\x23F3"
  Failure _ -> "\x274C"
  Success _ -> "\x2705"
  _ -> mempty

whenElem :: forall w i. Boolean -> (Unit -> HTML w i) -> HTML w i
whenElem cond f = if cond then f unit else H.text mempty

withSpinner :: forall e a w i. RemoteData e a -> (a -> HTML w i) -> HTML w i
withSpinner remoteData f = case remoteData of
  Success a -> f a
  Loading -> H.div [ P.classes [ B.spinnerBorder, B.textMuted ] ] []
  _ -> H.text mempty

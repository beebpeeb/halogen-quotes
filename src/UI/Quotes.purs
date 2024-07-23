module Quotes.UI.Quote where

import Prelude

import Halogen (ComponentHTML)
import Halogen.HTML as H
import Halogen.HTML.Properties as P
import Halogen.Themes.Bootstrap5 as B

import Quotes.Data.Quote (getAuthor, getContent)
import Quotes.UI.Common (State, withSpinner)

render :: forall a m. State -> ComponentHTML a () m
render { response } =
  H.section [ P.class_ B.container ]
    [ withSpinner response renderQuote ]
  where
  renderQuote q =
    H.div_ [ H.h4 [ P.classes [ B.textPrimary, B.textUppercase ] ]
      [ H.text $ getAuthor q ]
      , H.p [ P.class_ B.textMuted ]
          [ H.text $ getContent q ]
      ]

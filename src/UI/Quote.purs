module Quotes.UI.Quote where

import Prelude

import Data.Array.NonEmpty (head)
import Halogen (ComponentHTML)
import Halogen.HTML as H
import Halogen.HTML.Properties as P
import Halogen.Themes.Bootstrap5 as B

import Quotes.Data.Quote (printAuthor, printContent)
import Quotes.UI.Common (State, withSpinner)

render :: forall a m. State -> ComponentHTML a () m
render { response } =
  H.section [ P.class_ B.container ]
    [ withSpinner response renderQuotes ]
  where
  renderQuotes quotes =
    let
      firstQuote = head quotes
    in
      H.div_
        [ H.h4 [ P.class_ B.textPrimary ]
            [ H.text $ printAuthor firstQuote ]
        , H.p [ P.class_ B.textMuted ]
            [ H.text $ printContent firstQuote ]
        ]

module Quotes.UI.Quote where

import Prelude

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
  renderQuotes = case _ of
    [ quote, _ ] ->
      H.div_
        [ H.h4 [ P.class_ B.textPrimary ]
            [ H.text $ printAuthor quote ]
        , H.p [ P.class_ B.textMuted ]
            [ H.text $ printContent quote ]
        ]
    _ -> H.text mempty

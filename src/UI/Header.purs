module Quotes.UI.Header where

import Halogen (ComponentHTML)
import Halogen.HTML as H
import Halogen.HTML.Properties as P
import Halogen.Themes.Bootstrap5 as B

import Quotes.UI.Common (State, emoji)

render :: forall a m. State -> ComponentHTML a () m
render { response } =
  H.header [ P.class_ B.my4 ]
    [ H.div [ P.class_ B.container ]
        [ H.div [ P.class_ B.row ]
            [ H.h1 [ P.class_ B.display3 ]
                [ H.text "Pure Quotes" ]
            , H.h3 [ P.classes [ B.fs5, B.textInfo ] ]
                [ emoji response ]
            ]
        ]
    ]

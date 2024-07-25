module Main where

import Prelude

import Effect (Effect)
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.VDom.Driver (runUI)

import Quotes.UI.Container (component)

main :: Effect Unit
main = runHalogenAff $ runUI component unit =<< awaitBody

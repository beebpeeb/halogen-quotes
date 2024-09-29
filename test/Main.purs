module Test.Main where

import Prelude

import Effect (Effect)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)

import Test.API as API

main :: Effect Unit
main = runSpecAndExitProcess [ consoleReporter ] do
  API.spec

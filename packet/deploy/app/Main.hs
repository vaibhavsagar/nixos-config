 {-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import System.Environment (getArgs)

import Data.Monoid (mconcat)

main = getArgs >>= \(port:_) -> scotty (read port) $ do
    get "/:word" $ do
        beam <- param "word"
        html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]

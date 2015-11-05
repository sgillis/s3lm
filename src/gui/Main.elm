module Main where

import StartApp
import Html exposing (Html)

import Gui exposing (init, update, view, Model)


app : StartApp.App Model
app = StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


main : Signal Html
main = app.html

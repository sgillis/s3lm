module Main where

import StartApp
import Html exposing (Html)
import Signal exposing (Signal)
import Task exposing (Task)
import Effects exposing (Never)

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

port tasks : Signal (Task Never ())
port tasks = app.tasks
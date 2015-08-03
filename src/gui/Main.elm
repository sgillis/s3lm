module Gui where

import Signal exposing (..)
import Html exposing (..)


type alias GuiState = { seconds : Int }

initialGuiState : GuiState
initialGuiState = { seconds = 0 }

type GuiAction = NoOp

update : GuiAction -> GuiState -> GuiState
update a s = s

view : GuiState -> Html
view s = div [ ] [ text "s3lm" ]

main : Signal Html
main = map view state

state : Signal GuiState
state = foldp update initialGuiState actions.signal

actions : Mailbox GuiAction
actions = mailbox NoOp

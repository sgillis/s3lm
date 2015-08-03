module Background where

import Signal exposing (..)


type alias BackgroundState = { seconds : Int }

initialBackgroundState : BackgroundState
initialBackgroundState = { seconds = 0 }

type BackgroundAction = NoOp

update : BackgroundAction -> BackgroundState -> BackgroundState
update a s = s

state : Signal BackgroundState
state = foldp update initialBackgroundState actions.signal

actions : Mailbox BackgroundAction
actions = mailbox NoOp

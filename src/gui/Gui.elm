module Gui where

import Effects exposing (Effects)
import Signal exposing (Address, forwardTo)
import Html exposing (..)

import Login


-- MODEL

type alias Model =
     { login : Login.Model
     }

init : (Model, Effects Action)
init =
     let (login, loginFx) = Login.init
     in ( { login = login }
        , Effects.batch
          [ Effects.map LoginAction loginFx ]
        )


-- UPDATE

type Action = LoginAction Login.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
         LoginAction act ->
             let (login', fx) = Login.update act model.login
             in ( { model | login <- login' }
                , Effects.map LoginAction fx
                )


-- VIEW

view : Address Action -> Model -> Html
view address model =
     div []
         [ h1 [] [ text "s3lm" ]
         , Login.view (forwardTo address LoginAction) model.login
         ]
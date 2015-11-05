module Login where

import Effects exposing (Effects)
import Signal exposing (Address, forwardTo)
import Html.Attributes exposing (type')
import Html exposing (..)

import FormField


-- MODEL

type alias Model =
     { id     : FormField.Model
     , secret : FormField.Model
     }

init : (Model, Effects Action)
init =
     let (id, idFx) = FormField.init "" []
         (secret, secretFx) = FormField.init "" [type' "password"]
     in ( { id = id
          , secret = secret
          }
        , Effects.batch
          [ Effects.map IdAction idFx
          , Effects.map SecretAction secretFx
          ]
        )


-- UPDATE

type Action = IdAction FormField.Action
            | SecretAction FormField.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
         IdAction act ->
             let (id', idFx) = FormField.update act model.id
             in ( { model | id <- id' }
                , Effects.map IdAction idFx
                )
         SecretAction act ->
             let (secret', secretFx) = FormField.update act model.secret
             in ( { model | secret <- secret' }
                , Effects.map SecretAction secretFx
                )


-- VIEW

view : Address Action -> Model -> Html
view address model =
     div []
         [ FormField.view (forwardTo address IdAction) model.id
         , FormField.view (forwardTo address SecretAction) model.secret
         ]
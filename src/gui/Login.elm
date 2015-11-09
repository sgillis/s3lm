module Login where

import Effects exposing (Effects)
import Signal exposing (Address, forwardTo)
import Html.Attributes exposing (type')
import Html.Events exposing (onClick)
import Html exposing (..)
import Storage exposing (setItem)
import Json.Encode as Json
import Task

import Debug exposing (log)

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
            | Login
            | LoggedIn (Maybe ())

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
         Login -> (model, login model.id.contents model.secret.contents)
         LoggedIn m -> case m of
                            Nothing -> log "got nothing" (model, Effects.none)
                            Just _ -> log "got something" (model, Effects.none)


-- VIEW

view : Address Action -> Model -> Html
view address model =
     div []
         [ FormField.view (forwardTo address IdAction) model.id
         , FormField.view (forwardTo address SecretAction) model.secret
         , submitButton address
         ]

submitButton : Address Action -> Html
submitButton address =
    button [ onClick address Login]
           [ text "Login" ]


-- EFFECTS

login : String -> String -> Effects Action
login id secret =
    setItem "id" (Json.string id)
    |> Task.toMaybe
    |> Task.map LoggedIn
    |> Effects.task
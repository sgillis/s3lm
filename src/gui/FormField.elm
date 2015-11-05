module FormField where

import Effects exposing (Effects)
import Signal exposing (Address, message)
import Html exposing (..)
import Html.Events exposing (on, targetValue)


-- MODEL

type alias Model =
     { contents   : String
     , attributes : List Attribute
     }

init : String -> List Attribute -> (Model, Effects Action)
init contents attrs =
     ( Model contents attrs
     , Effects.none
     )


-- UPDATE

type Action = UpdateContents String
            | Erase

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
         UpdateContents contents' ->
             ( { model | contents <- contents' }
             , Effects.none )
         Erase ->
             ( { model | contents <- "" }
             , Effects.none )


-- VIEW

view : Address Action -> Model -> Html
view address model =
    let sendattr = on "input" targetValue (message address << UpdateContents)
        attrs = sendattr :: model.attributes
    in div []
        [ input attrs [] ]
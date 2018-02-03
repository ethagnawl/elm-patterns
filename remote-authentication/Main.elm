port module Main exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Http
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Action
import Update
import View
import Types
import Model


init : Types.Flags -> ( Model.Model, Cmd Action.Action )
init flags =
    let
        defaultModel =
            Model.defaultModel
    in
        ( { defaultModel | apiRoot = flags.apiRoot }, Cmd.none )


main : Program Types.Flags Model.Model Action.Action
main =
    Html.programWithFlags
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = Update.update
        , view = View.view
        }

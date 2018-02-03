port module Main exposing (..)

import Action
import Html exposing (..)
import Model
import Types
import Update
import View


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

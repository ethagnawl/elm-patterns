module Main exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Port


type alias Model =
    { paused : Bool
    , playing : Bool
    }


type Msg
    = Pause
    | Play


init =
    ( { paused = True
      , playing = True
      }
    , Cmd.none
    )


subscriptions _ =
    Sub.none


update action model =
    case action of
        Pause ->
            ( { model | paused = True, playing = False }, Port.pause "pause" )

        Play ->
            ( { model | paused = False, playing = True }, Port.play "play" )


view model =
    div
        [ class "wrapper" ]
        [ video [ src "https://www.quirksmode.org/html5/videos/big_buck_bunny.mp4" ] []
        , button [ onClick Play ] [ text "PLAY" ]
        , button [ onClick Pause ] [ text "PAUSE" ]
        ]


main =
    program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }

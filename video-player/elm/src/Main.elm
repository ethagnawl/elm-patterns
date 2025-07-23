port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode


port pause : String -> Cmd msg


port play : String -> Cmd msg


port progress : (Float -> msg) -> Sub msg


port replay : String -> Cmd msg


port timeUpdate : String -> Cmd msg


type alias Model =
    { paused : Bool
    , playing : Bool
    , progress : Float
    }


type Msg
    = Pause
    | Play
    | Progress Float
    | TimeUpdate


init : () -> ( Model, Cmd Msg )
init flags =
    -- NOTE: This flag argument seems to be required by the compiler as of
    -- 0.19.1 but is not actually used.
    ( { paused = True
      , playing = True
      , progress = 0.0
      }
    , Cmd.none
    )


subscriptions _ =
    progress Progress


update action model =
    case action of
        Pause ->
            ( { model | paused = True, playing = False }, pause "pause" )

        Play ->
            ( { model | paused = False, playing = True }, play "play" )

        TimeUpdate ->
            ( model, timeUpdate "timeUpdate" )

        Progress newProgress ->
            ( { model | progress = newProgress }, Cmd.none )


view model =
    let
        width =
            Debug.toString model.progress ++ "%"
    in
    div
        [ class "wrapper" ]
        [ div
            [ class "video-wrapper" ]
            [ video
                [ on "timeupdate" (Decode.succeed TimeUpdate)
                , src "https://pdoherty-demos.s3.amazonaws.com/elm-video-player/big-buck-bunny.mp4"
                ]
                []
            , div
                [ class "progress"
                , style "background-color" "#e4c5af"
                , style "height" "22px"
                , style "width" width
                ]
                []
            ]
        , button [ onClick Play ] [ text "PLAY" ]
        , button [ onClick Pause ] [ text "PAUSE" ]
        ]


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }

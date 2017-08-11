module Main exposing (..)

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)
import Json.Decode as Decode
import Task
import Time


type alias Model =
    { hideAt : Maybe Time.Time
    , shown : Bool
    }


type Msg
    = AttemptToHide Time.Time
    | ScheduleHide Time.Time
    | Show


show model =
    ( { model | shown = True }
    , Task.perform ScheduleHide Time.now
    )


scheduleHide model time =
    let
        hideAtTime =
            time + (1 * Time.second)
    in
        ( { model
            | hideAt = (Just hideAtTime)
          }
        , Cmd.none
        )


attemptToHide model time =
    case (model.hideAt) of
        Just hideAt ->
            case (time > hideAt) of
                True ->
                    ( { model
                        | hideAt = Nothing
                        , shown = False
                      }
                    , Cmd.none
                    )

                False ->
                    model ! []

        Nothing ->
            model ! []


update action model =
    case action of
        AttemptToHide time ->
            attemptToHide model time

        ScheduleHide time ->
            scheduleHide model time

        Show ->
            show model


subscriptions model =
    (Time.every Time.second AttemptToHide)


view model =
    div
        [ on "mousemove" (Decode.succeed (Show))
        , class "wrapper"
        , classList [ ( "wrapper-active", model.shown ) ]
        ]
        [ div [ class "default" ] [ text "Default" ]
        , div [ class "active" ] [ text "Active" ]
        ]


init =
    ( { hideAt = Nothing
      , shown = False
      }
    , Cmd.none
    )


main =
    program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }

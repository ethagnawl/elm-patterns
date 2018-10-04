module Main exposing (..)

import Browser
import Css
import Css.Global
import Css.Transitions
import Html
import Html.Styled
import Html.Styled.Attributes
import Html.Styled.Events
import Html.Styled.Keyed
import Time
import Task
import Process


type ViewState
    = Start
    | LoadQueued
    | Load
    | Done


type Action
    = DoStart
    | DoLoadQueued
    | DoLoad
    | DoDone


type alias Model =
    { viewState : ViewState
    }


defaultModel =
    { viewState = Start
    }


styles =
    { colors =
        { lightGreen = Css.rgb 212 238 172
        , darkGreen = Css.rgb 140 176 86
        }
    }


init _ =
    ( defaultModel, Cmd.none )


visibilityHelper state =
    let
        display =
            if state then
                "visible"
            else
                "hidden"
    in
        Html.Styled.Attributes.style "visibility" display


loadingDelay =
    4000


view model =
    let
        state =
            case model.viewState of
                Start ->
                    "Start"

                Load ->
                    "Load"

                LoadQueued ->
                    "LoadQueued"

                Done ->
                    "Done"

        start =
            ( "start"
            , Html.Styled.div
                [ (visibilityHelper (model.viewState == Start))
                , Html.Styled.Attributes.css
                    [ Css.color styles.colors.lightGreen
                    , Css.cursor Css.pointer
                    , Css.fontFamily Css.sansSerif
                    , Css.fontSize (Css.rem 4)
                    , Css.left (Css.px 0)
                    , Css.position Css.fixed
                    , Css.right (Css.px 0)
                    , Css.textAlign Css.center
                    , Css.top (Css.pct 50)
                    , Css.transform (Css.translateY (Css.pct -50))
                    ]
                , Html.Styled.Events.onClick DoLoadQueued
                ]
                [ Html.Styled.text "Click to start!" ]
            )

        loading =
            ( "loading"
            , Html.Styled.div
                [ (visibilityHelper (model.viewState == LoadQueued || model.viewState == Load))
                , Html.Styled.Attributes.class
                    (if (model.viewState == LoadQueued || model.viewState == Load) then
                        "loading"
                     else
                        ""
                    )
                , Html.Styled.Attributes.css
                    [ Css.color styles.colors.lightGreen
                    , Css.fontFamily Css.sansSerif
                    , Css.fontSize (Css.rem 4)
                    , Css.left (Css.px 0)
                    , Css.position Css.fixed
                    , Css.right (Css.px 0)
                    , Css.textAlign Css.center
                    , Css.top (Css.pct 50)
                    , Css.transform (Css.translateY (Css.pct -50))
                    , Css.Transitions.transition
                        [ Css.Transitions.color3 loadingDelay 0 Css.Transitions.linear ]
                    , Css.Global.withClass "loading"
                        [ Css.color styles.colors.darkGreen
                        ]
                    ]
                ]
                [ Html.Styled.p [] [ Html.Styled.text "Loading ..." ]
                , Html.Styled.span
                    [ Html.Styled.Attributes.css [ Css.fontSize (Css.rem 1) ] ]
                    [ Html.Styled.text "(State transition is synced with CSS transition!)" ]
                ]
            )

        done =
            ( "done"
            , Html.Styled.div
                [ (visibilityHelper (model.viewState == Done))
                , Html.Styled.Attributes.css
                    [ Css.color styles.colors.lightGreen
                    , Css.fontFamily Css.sansSerif
                    , Css.fontSize (Css.rem 4)
                    , Css.left (Css.px 0)
                    , Css.position Css.fixed
                    , Css.right (Css.px 0)
                    , Css.textAlign Css.center
                    , Css.top (Css.pct 50)
                    , Css.transform (Css.translateY (Css.pct -50))
                    ]
                ]
                [ Html.Styled.text "Done!" ]
            )

        body_ =
            List.singleton <|
                Html.Styled.toUnstyled <|
                    Html.Styled.Keyed.node "div"
                        [ Html.Styled.Attributes.css
                            [ Css.backgroundColor styles.colors.darkGreen
                            , Css.height (Css.vh 100)
                            , Css.left (Css.px 0)
                            , Css.position Css.fixed
                            , Css.right (Css.px 0)
                            , Css.top (Css.px 0)
                            ]
                        ]
                        [ start
                        , loading
                        , done
                        ]
    in
        { body = body_, title = "" }


delay time msg =
    Process.sleep time
        |> Task.perform (\_ -> msg)


update msg model =
    case msg of
        DoStart ->
            ( { model | viewState = Start }, Cmd.none )

        DoLoadQueued ->
            ( { model | viewState = LoadQueued }, (delay loadingDelay DoLoad) )

        _ ->
            ( { model | viewState = Done }, Cmd.none )


type alias Flags =
    {}


main : Program Flags Model Action
main =
    Browser.document
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }

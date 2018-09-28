port module CreepySpywareDemo exposing (main, init)

import Browser
import Html
import Html.Events
import Json.Encode


port creepySpywarePort : Json.Encode.Value -> Cmd msg


constructCSEventObject category action label =
    Json.Encode.object <|
        [ ( "hitType", (Json.Encode.string "event") )
        , ( "eventCategory", (Json.Encode.string category) )
        , ( "eventAction", (Json.Encode.string action) )
        , ( "eventLabel", (Json.Encode.string label) )
        ]


type alias Flags =
    {}


type Action
    = ButtonClick
    | None


type alias Model =
    { buttonClickCount : Int }


defaultModel =
    { buttonClickCount = 0 }


update msg model =
    case msg of
        ButtonClick ->
            let
                newModel =
                    { model | buttonClickCount = (model.buttonClickCount + 1) }

                category =
                    "User interactions"

                action =
                    "button click"

                label =
                    ("click count: " ++ (String.fromInt model.buttonClickCount))

                eventObject =
                    constructCSEventObject category action label
            in
                ( newModel, (creepySpywarePort eventObject) )

        _ ->
            ( model, Cmd.none )


init flags =
    ( defaultModel, Cmd.none )


view model =
    { body =
        [ Html.div []
            [ Html.button
                [ Html.Events.onClick ButtonClick ]
                [ Html.text "Click!" ]
            , Html.p
                []
                [ Html.text ("Button Clicks: " ++ (String.fromInt model.buttonClickCount)) ]
            ]
        ]
    , title = "Creepy Spyware Demo"
    }


main : Program Flags Model Action
main =
    Browser.document
        { init = init
        , subscriptions = (\_ -> Sub.none)
        , update = update
        , view = view
        }

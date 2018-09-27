module Main exposing (init)

import Browser
import Html
import Html.Events


type alias Model =
    { normalizedName : Maybe String
    , rawName : Maybe String
    }


type Action
    = UpdateName String
    | None


defaultModel : Model
defaultModel =
    { normalizedName = Nothing
    , rawName = Nothing
    }


update : Action -> Model -> Model
update msg model =
    case msg of
        UpdateName rawInput ->
            let
                normalizedName_ =
                    Just <| String.trim <| String.toLower rawInput
            in
                { model
                    | normalizedName = normalizedName_
                    , rawName = Just rawInput
                }

        _ ->
            model


init : Model
init =
    defaultModel


view : Model -> Html.Html Action
view model =
    let
        normalizedName =
            Maybe.withDefault "" model.normalizedName

        rawName =
            Maybe.withDefault "" model.rawName
    in
        Html.div []
            [ Html.form []
                [ Html.fieldset []
                    [ Html.label [] [ Html.text "Your raw input" ]
                    , Html.input [ Html.Events.onInput UpdateName ] []
                    ]
                , Html.fieldset []
                    [ Html.label [] [ Html.text "Your raw name: " ]
                    , Html.output [] [ Html.text rawName ]
                    ]
                , Html.fieldset []
                    [ Html.label [] [ Html.text "Your normalized name: " ]
                    , Html.output [] [ Html.text normalizedName ]
                    ]
                ]
            ]


title =
    "Normalized Form Input"


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }

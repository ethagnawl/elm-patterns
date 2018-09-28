module Main exposing (init)

import Browser
import Html
import Html.Attributes
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
    , rawName = Just "SlOPPy JOe"
    }


update : Action -> Model -> Model
update msg model =
    case msg of
        UpdateName rawInput ->
            let
                normalizedName_ =
                    Just <|
                        (String.replace " " "_") <|
                            String.toLower <|
                                String.trim rawInput
            in
                { model
                    | normalizedName = normalizedName_
                    , rawName = Just rawInput
                }

        _ ->
            model


init : Model
init =
    let
        rawName =
            Maybe.withDefault "" defaultModel.rawName
    in
        (update (UpdateName rawName) defaultModel)


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
                    [ Html.label [] [ Html.text "rawName (what user sees during input and maybe elsewhere in the UI): " ]
                    , Html.input
                        [ Html.Attributes.type_ "text"
                        , Html.Attributes.value rawName
                        , Html.Events.onInput UpdateName
                        ]
                        []
                    ]
                , Html.fieldset []
                    [ Html.label [] [ Html.text "normalizedName (what Elm uses for business logic): " ]
                    , Html.output [] [ Html.text normalizedName ]
                    ]
                ]
            ]


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }

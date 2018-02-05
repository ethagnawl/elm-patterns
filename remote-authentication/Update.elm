module Update exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Action
import Http
import Model
import Types


attributesDecoder : Decoder Types.Attributes
attributesDecoder =
    Decode.map3 Types.Attributes
        (Decode.field "email" Decode.string)
        (Decode.field "first_name" Decode.string)
        (Decode.field "last_name" Decode.string)


dataDecoder : Decoder Types.Data
dataDecoder =
    Decode.map Types.Data
        (Decode.field "attributes" attributesDecoder)


wrapperDecoder : Decoder Types.Wrapper
wrapperDecoder =
    Decode.map Types.Wrapper
        (Decode.field "data" dataDecoder)


badStatusDecoder error =
    let
        defaultErrorMessage =
            "Unknown error. Please wait a moment and try again."
    in
        case error of
            Http.BadStatus response ->
                let
                    maybeErrors =
                        decodeString
                            (keyValuePairs (Decode.list Decode.string))
                            response.body
                in
                    case maybeErrors of
                        Ok errors ->
                            case (List.head errors) of
                                Just errors ->
                                    String.join " " <| Tuple.second errors

                                Nothing ->
                                    defaultErrorMessage

                        Err _ ->
                            defaultErrorMessage

            Http.NetworkError ->
                "Authentication service is unavailable."

            _ ->
                defaultErrorMessage


responseHandler : Model.Model -> Result Http.Error Types.Wrapper -> ( Model.Model, Cmd Action.Action )
responseHandler model result =
    case result of
        Ok response ->
            ( { model
                | signedIn = True
                , firstName = response.data.attributes.firstName
                , lastName = response.data.attributes.lastName
                , email = response.data.attributes.email
              }
            , Cmd.none
            )

        Err error ->
            ( { model | errorMsg = badStatusDecoder error }, Cmd.none )


signInUserEncoder : Model.Model -> Encode.Value
signInUserEncoder model =
    Encode.object
        [ ( "email", Encode.string model.email )
        , ( "password", Encode.string model.password )
        ]


signUpUserEncoder : Model.Model -> Encode.Value
signUpUserEncoder model =
    Encode.object
        [ ( "email", Encode.string model.email )
        , ( "password", Encode.string model.password )
        , ( "first_name", Encode.string model.firstName )
        , ( "last_name", Encode.string model.lastName )
        ]


constructPostRequest model apiUrl encoder =
    let
        body =
            model
                |> encoder
                |> Http.jsonBody
    in
        Http.post apiUrl body wrapperDecoder


apiRequest model apiUrl encoder =
    Http.send Action.ResponseHandler (constructPostRequest model apiUrl encoder)


registerUrl : String -> String
registerUrl apiRoot =
    apiRoot ++ "users"


loginUrl : String -> String
loginUrl apiRoot =
    apiRoot ++ "users/auth/sign_in"


update : Action.Action -> Model.Model -> ( Model.Model, Cmd Action.Action )
update msg model =
    case msg of
        Action.ClickLogIn ->
            ( model, apiRequest model (loginUrl model.apiRoot) signInUserEncoder )

        Action.ClickRegisterUser ->
            ( model, apiRequest model (registerUrl model.apiRoot) signUpUserEncoder )

        Action.ResponseHandler response ->
            responseHandler model response

        Action.LogOut ->
            let
                defaultModel =
                    Model.defaultModel

                newModel =
                    { defaultModel | apiRoot = model.apiRoot }
            in
                ( newModel, Cmd.none )

        Action.SetFirstName firstName ->
            ( { model | firstName = firstName }, Cmd.none )

        Action.SetLastName lastName ->
            ( { model | lastName = lastName }, Cmd.none )

        Action.SetPassword password ->
            ( { model | password = password }, Cmd.none )

        Action.SetUsername email ->
            ( { model | email = email }, Cmd.none )

        Action.TogglePageState ->
            let
                newPageState =
                    if (model.pageState == Types.Login) then
                        Types.Register
                    else
                        Types.Login

                defaultModel =
                    Model.defaultModel

                newModel =
                    { defaultModel
                        | apiRoot = model.apiRoot
                        , pageState = newPageState
                    }
            in
                ( newModel, Cmd.none )

module View exposing (..)

import Action
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Model
import Types


view : Model.Model -> Html Action.Action
view model =
    let
        signedIn : Bool
        signedIn =
            (model.signedIn == True)

        disabledHelper state =
            disabled
                (if state then
                    True
                 else
                    False
                )

        displayHelper block state =
            let
                display =
                    if state then
                        block
                    else
                        "none"
            in
                [ ( "display", display ) ]

        profileView model =
            div [ id "profile" ]
                [ h3 [] [ text ("Welcome, " ++ model.firstName ++ "!") ]
                , p [] [ text ("Email: " ++ model.email) ]
                , p [] [ text ("First Name: " ++ model.firstName) ]
                , p [] [ text ("Last Name: " ++ model.lastName) ]
                ]

        authBoxViewSignUp =
            let
                showError =
                    not <| String.isEmpty model.errorMsg
            in
                if signedIn then
                    profileView model
                else
                    div [ id "form", class "mui-form" ]
                        [ legend [] [ text "Register" ]
                        , div
                            [ class "mui-panel mui--bg-accent-dark", style (displayHelper "block" showError) ]
                            [ div [ class "mui--text-dark-secondary" ] [ text <| "There was a problem with your request: " ++ model.errorMsg ] ]
                        , div []
                            [ div [ class "mui-textfield" ]
                                [ label [ for "first_name" ] [ text "First name:" ]
                                , input
                                    [ id "first_name"
                                    , type_ "first_name"
                                    , class "form-control"
                                    , Html.Attributes.value model.firstName
                                    , onInput Action.SetFirstName
                                    ]
                                    []
                                ]
                            ]
                        , div []
                            [ div [ class "mui-textfield" ]
                                [ label [ for "last_name" ] [ text "Last name:" ]
                                , input
                                    [ id "last_name"
                                    , type_ "last_name"
                                    , class "form-control"
                                    , Html.Attributes.value model.lastName
                                    , onInput Action.SetLastName
                                    ]
                                    []
                                ]
                            ]
                        , div []
                            [ div [ class "mui-textfield" ]
                                [ label [ for "email" ] [ text "Email:" ]
                                , input
                                    [ id "email"
                                    , type_ "email"
                                    , class "form-control"
                                    , Html.Attributes.value model.email
                                    , onInput Action.SetEmail
                                    ]
                                    []
                                ]
                            ]
                        , div []
                            [ div [ class "mui-textfield" ]
                                [ label [ for "password" ] [ text "Password:" ]
                                , input
                                    [ id "password"
                                    , type_ "password"
                                    , class "form-control"
                                    , Html.Attributes.value model.password
                                    , onInput Action.SetPassword
                                    ]
                                    []
                                ]
                            ]
                        , div []
                            [ button
                                [ class "mui-btn mui-btn--primary"
                                , onClick Action.ClickRegister
                                ]
                                [ text "Submit" ]
                            ]
                        ]

        authBoxViewSignIn =
            let
                showError =
                    not <| String.isEmpty model.errorMsg
            in
                if signedIn then
                    profileView model
                else
                    div [ id "form", class "mui-form" ]
                        [ legend [] [ text "Log In" ]
                        , div
                            [ class "mui-panel mui--bg-accent-dark", style (displayHelper "block" showError) ]
                            [ div [ class "mui--text-dark-secondary" ] [ text <| "There was a problem with your request: " ++ model.errorMsg ] ]
                        , div []
                            [ div [ class "mui-textfield" ]
                                [ label [ for "email" ] [ text "Email:" ]
                                , input
                                    [ id "email"
                                    , type_ "email"
                                    , class "form-control"
                                    , Html.Attributes.value model.email
                                    , onInput Action.SetEmail
                                    ]
                                    []
                                ]
                            ]
                        , div []
                            [ div [ class "mui-textfield" ]
                                [ label [ for "password" ] [ text "Password:" ]
                                , input
                                    [ id "password"
                                    , type_ "password"
                                    , class "form-control"
                                    , Html.Attributes.value model.password
                                    , onInput Action.SetPassword
                                    ]
                                    []
                                ]
                            ]
                        , div []
                            [ button
                                [ class "mui-btn mui-btn--primary"
                                , onClick Action.ClickLogIn
                                ]
                                [ text "Submit" ]
                            ]
                        ]
    in
        div [ class "mui-container" ]
            [ div []
                [ div
                    [ class "mui-panel"
                    , style (displayHelper "block" (model.pageState == Types.Register))
                    ]
                    [ authBoxViewSignUp ]
                , div
                    [ class "mui-panel"
                    , style (displayHelper "block" (model.pageState == Types.Login))
                    ]
                    [ authBoxViewSignIn ]
                ]
            , div [ class "mui--text-center" ]
                [ button
                    [ class "mui-btn mui-btn--danger"
                    , style (displayHelper "inline-block" (not signedIn))
                    , onClick Action.TogglePageState
                    , (disabledHelper (model.pageState == Types.Register))
                    ]
                    [ text "Register" ]
                , button
                    [ class "mui-btn mui-btn--danger"
                    , style (displayHelper "inline-block" (not signedIn))
                    , onClick Action.TogglePageState
                    , (disabledHelper (model.pageState == Types.Login))
                    ]
                    [ text "Login" ]
                , button
                    [ class "mui-btn mui-btn--danger"
                    , style (displayHelper "inline-block" signedIn)
                    , onClick Action.LogOut
                    ]
                    [ text "Log Out" ]
                ]
            ]

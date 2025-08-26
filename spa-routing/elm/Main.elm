-- _Heavily_ inspired by: github.com:simon-larsson/elm-spa-template.git


module Main exposing (..)

import Html.Attributes as Attr exposing (..)
import Html exposing (..)
import Json.Decode as Decode exposing (Value)
import Navigation exposing (Location)
import UrlParser exposing ((</>), Parser)


type Route
    = HomeRoute
    | AlbumRoute String


type alias Album =
    { coverThumbnailUrl : String
    , description : String
    , slug : String
    , title : String
    , wikipediaUrl : String
    }


type alias Model =
    { selectedAlbum : Maybe Album
    , albums : List Album
    }


type Msg
    = SetRoute (Maybe Route)


routeMatcher : Parser (Route -> a) a
routeMatcher =
    UrlParser.oneOf
        [ UrlParser.map HomeRoute (UrlParser.s "")
        , UrlParser.map AlbumRoute (UrlParser.s "albums" </> UrlParser.string)
        ]


routeToString : Route -> String
routeToString page =
    case page of
        AlbumRoute slug ->
            "#/albums/" ++ slug

        HomeRoute ->
            ""


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just HomeRoute
    else
        UrlParser.parseHash routeMatcher location


findAlbumBySlug : List Album -> String -> Maybe Album
findAlbumBySlug albums slug =
    List.filter (\n -> n.slug == slug) albums |> List.head


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    case route of
        Just (AlbumRoute slug) ->
            let
                selectedAlbum =
                    findAlbumBySlug model.albums slug
            in
                ( { model | selectedAlbum = selectedAlbum }, Cmd.none )

        _ ->
            ( model, Cmd.none )



-- Album data taken from respective Wikipedia pages


albums : List Album
albums =
    [ { coverThumbnailUrl = "https://upload.wikimedia.org/wikipedia/en/6/6b/Dsothunder-250.jpg"
      , description = "Delicate Sound of Thunder is a double live album by the English progressive rock band Pink Floyd which was recorded over five nights at the Nassau Coliseum on Long Island, New York in August 1988 and mixed at Abbey Road Studios in September 1988. It was released on 22 November 1988, through EMI Records in the United Kingdom and Columbia Records in the United States. - Wikipedia"
      , slug = "delicate-sound-of-thunder"
      , title = "Delicate Sound of Thunder"
      , wikipediaUrl = "https://en.wikipedia.org/wiki/Delicate_Sound_of_Thunder"
      }
    , { coverThumbnailUrl = "https://upload.wikimedia.org/wikipedia/en/3/38/Is_there_anybody_out_there%3F_40273_big.jpg"
      , description = "Is There Anybody Out There? The Wall Live 1980-81 is a live album released by Pink Floyd in 2000. It is a live rendition of The Wall, produced and engineered by James Guthrie, with tracks selected from the August 1980 and June 1981 performances at Earls Court in London. The album was first released in The Netherlands by EMI Records on 23 March 2000, who released a limited edition in the United Kingdom on 27 March. The general release followed on 18 April 2000 with US and Canadian distribution by Columbia Records. - Wikipedia"
      , slug = "is-there-anybody-out-there"
      , title = "Is There Anybody Out There?"
      , wikipediaUrl = "https://en.wikipedia.org/wiki/Is_There_Anybody_Out_There%3F_The_Wall_Live_1980%E2%80%9381"
      }
    , { coverThumbnailUrl = "https://upload.wikimedia.org/wikipedia/en/5/5c/Floyd_PULSE_Cover.jpg"
      , description = "Pulse (stylised as p·u·l·s·e) is a live double album by the English progressive rock band Pink Floyd. It was originally released on 29 May 1995, on the label EMI in the United Kingdom and on 6 June 1995 by Columbia in the United States.[3]\n\nThe album was recorded during the band's Division Bell Tour in 1994, specifically the UK and European leg, which ran from July to October 1994. - Wikipedia"
      , slug = "pulse"
      , title = "Pulse"
      , wikipediaUrl = "https://en.wikipedia.org/wiki/Pulse_(Pink_Floyd_album)"
      }
    ]


init : Value -> Location -> ( Model, Cmd Msg )
init val location =
    setRoute (fromLocation location)
        { selectedAlbum = Nothing
        , albums = albums
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    case model.selectedAlbum of
        Just album ->
            div [ class "album" ]
                [ h1 [ class "title" ] [ text album.title ]
                , img
                    [ class "cover"
                    , src album.coverThumbnailUrl
                    ]
                    []
                , div [] [ p [ class "description" ] [ text album.description ] ]
                ]

        _ ->
            div [ class "albums-wrapper" ]
                ([ h1 [] [ text "Live Pink Floyd Albums:" ]
                 , ul [ class "albums" ]
                    (List.map
                        (\v ->
                            li [ class "album" ]
                                [ a
                                    [ href (AlbumRoute v.slug) ]
                                    [ text v.title ]
                                ]
                        )
                        model.albums
                    )
                 ]
                )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetRoute route ->
            case route of
                Just (AlbumRoute slug) ->
                    let
                        selectedAlbum =
                            findAlbumBySlug model.albums slug
                    in
                        ( { model | selectedAlbum = selectedAlbum }, Cmd.none )

                _ ->
                    ( { model | selectedAlbum = Nothing }, Cmd.none )


main : Program Value Model Msg
main =
    Navigation.programWithFlags (fromLocation >> SetRoute)
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }

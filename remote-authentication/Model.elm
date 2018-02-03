module Model exposing (..)

import Types


type alias Model =
    { apiRoot : String
    , email : String
    , errorMsg : String
    , firstName : String
    , lastName : String
    , name : String
    , pageState : Types.PageState
    , password : String
    , signedIn : Bool
    , token : String
    }


defaultModel =
    { apiRoot = ""
    , email = ""
    , errorMsg = ""
    , firstName = ""
    , lastName = ""
    , name = ""
    , pageState = Types.Login
    , password = ""
    , signedIn = False
    , token = ""
    }

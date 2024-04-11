module Model exposing (..)

import Types


type alias Model =
    { apiRoot : String
    , email : String
    , errorMsg : String
    , firstName : String
    , lastName : String
    , pageState : Types.PageState
    , password : String
    , signedIn : Bool
    }


defaultModel =
    { apiRoot = ""
    , email = ""
    , errorMsg = ""
    , firstName = ""
    , lastName = ""
    , pageState = Types.Register
    , password = ""
    , signedIn = False
    }

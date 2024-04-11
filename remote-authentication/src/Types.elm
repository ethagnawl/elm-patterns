module Types exposing (..)


type alias Flags =
    { apiRoot : String }


type PageState
    = Login
    | Register


type alias Data =
    { attributes : Attributes }


type alias Wrapper =
    { data : Data }


type alias Attributes =
    { email : String
    , firstName : String
    , lastName : String
    }

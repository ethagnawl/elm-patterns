module Action exposing (..)

import Http
import Types


type Action
    = ClickLogIn
    | ClickRegister
    | LogOut
    | ResponseHandler (Result Http.Error Types.Wrapper)
    | SetEmail String
    | SetFirstName String
    | SetLastName String
    | SetPassword String
    | TogglePageState

module Action exposing (..)

import Http
import Types


type Action
    = ClickLogIn
    | ClickRegisterUser
    | ResponseHandler (Result Http.Error Types.Wrapper)
    | LogOut
    | SetFirstName String
    | SetLastName String
    | SetPassword String
    | SetUsername String
    | TogglePageState

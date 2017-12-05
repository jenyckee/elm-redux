port module Redux exposing (program)

import Platform
import Json.Encode as Json

port elmToReact : ( String, Json.Value ) -> Cmd msg

program : 
    { init : ( model, Cmd msg )
    , update : msg -> model -> ( model, Cmd msg )
    , encode : model -> Json.Value
    , subscriptions : model -> Sub msg
    }
    -> Program Never model msg
program app =
    let
        reducer action ( message, cmd ) =
            ( message
            , Cmd.batch
                [ cmd
                , ( toString action
                  , app.encode message
                  )
                    |> elmToReact
                ]
            )

        wrap update msg model =
            reducer msg <| update msg model
            in
        Platform.program
            { init = app.init
            , update = wrap app.update
            , subscriptions = app.subscriptions
            }


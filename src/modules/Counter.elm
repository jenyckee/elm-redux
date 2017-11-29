port module Counter exposing (..)
import Json.Decode exposing (..)
import Platform
import Json.Encode as Json

port increment : (Value -> msg) -> Sub msg
port elmToRedux : ( String, Json.Value ) -> Cmd msg

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch
  [
    increment <| always Increment
  ]

init : ( Model, Cmd Msg )
init =
    ( Model 0, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        Increment -> 
            ( { model | value = model.value + 1 }, Cmd.none )

type alias Model =
    {
      value : Int
    }

type Msg = NoOp
         | Increment 

main : Program Never Model Msg
main =
        Platform.program
            { init = init
            , update = update
            , subscriptions = subscriptions
            }
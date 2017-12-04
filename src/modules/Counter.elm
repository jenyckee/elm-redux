port module Reducer exposing (..)
import Json.Decode exposing (..)
import Platform
import Json.Encode as Json
import Debug

port increment : (Int -> msg) -> Sub msg
port elmToReact : ( String, Json.Value ) -> Cmd msg

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch
  [
    increment Increment
  ]

init : ( Model, Cmd Msg )
init =
    ( Model 0, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        Increment amount -> 
            let _ = Debug.log "increment" (toString model) in
            ( { model | value = model.value + 1 }, Cmd.none )

type alias Model =
    {
      value : Int
    }

type Msg = NoOp
         | Increment Int

wrap : Msg -> Model -> ( Model, Cmd Msg )
wrap msg model = let newModel = update msg model in
    newModel

encodeModel : Model -> Json.Value
encodeModel { value } =
    Json.object
        [ 
         ( "value", Json.int value )
        ]

main : Program Never Model Msg
main =
    let
        reducer action ( message, cmd ) =
            ( message
            , Cmd.batch
                [ cmd
                , ( toString action
                  , encodeModel message
                  )
                    |> elmToReact
                ]
            )

        wrap update msg model =
            reducer msg <| update msg model
            in
        Platform.program
            { init = init
            , update = wrap update
            , subscriptions = subscriptions
            }
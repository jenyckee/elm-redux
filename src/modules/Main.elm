port module Reducer exposing (Model, Msg, init, update, subscriptions)
import Redux
import Task exposing (..)
import Process
import Time exposing (..)
import Json.Encode as Json exposing (object, string, int)
import Json.Decode exposing (Value)


port increment : (Value -> msg) -> Sub msg


port asyncIncrement : (Value -> msg) -> Sub msg


port asyncDecrement : (Value -> msg) -> Sub msg


port decrement : (Value -> msg) -> Sub msg



clock : Sub Msg
clock =
    Time.every (second * 1) TickTock


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ decrement <| always Decrement
        , increment <| always Increment
        , asyncIncrement <| always AsyncIncrement
        , asyncDecrement <| always AsyncDecrement
        , clock
        ]



-- MODEL


init : Int -> ( Model, Cmd Msg )
init value =
    ( { value = value, count = 1, tickTock = "TICK" }, Cmd.none )


type alias Model =
    { value : Int
    , count : Int
    , tickTock : String
    }


encodeModel : Model -> Json.Value
encodeModel { value, count, tickTock } =
    object
        [ ( "value", int value )
        , ( "count", int count )
        , ( "tickTock", string tickTock )
        ]


type alias Payload =
    Int



-- ACTIONS


type Msg
    = NoOp
    | TickTock Time
    | Increment
    | Decrement
    | AsyncIncrement
    | AsyncDecrement



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Increment ->
            ( { model | value = model.value + model.count }, Cmd.none )

        Decrement ->
            ( { model | value = model.value - model.count }, Cmd.none )

        AsyncIncrement ->
            ( model, asyncTask Increment )

        AsyncDecrement ->
            ( model, asyncTask Decrement )

        TickTock _ ->
            (case model.tickTock of
                "TICK" ->
                    ( { model | tickTock = "TOCK" }, Cmd.none )

                "TOCK" ->
                    ( { model | tickTock = "TICK" }, Cmd.none )

                _ ->
                    ( model, Cmd.none )
            )

        NoOp ->
            ( model, Cmd.none )


asyncTask : Msg -> Cmd Msg
asyncTask msg =
    Process.sleep (2 * Time.second)
        |> Task.perform (always msg)

main : Program Never Model Msg
main =
    Redux.program
        { init = init 0
        , update = update
        , encode = encodeModel
        , subscriptions = subscriptions
        }
port module Reducer exposing (Model, Msg, init, update, subscriptions)

import Redux
import Task exposing (..)
import Process
import Time exposing (..)
import Json.Encode as Json exposing (object, string, int)
import Json.Decode exposing (..)
import Http

port increment : (Value -> msg) -> Sub msg


port asyncIncrement : (Value -> msg) -> Sub msg


port asyncDecrement : (Value -> msg) -> Sub msg


port decrement : (Value -> msg) -> Sub msg



subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [
        ]


-- MODEL

foo : Value -> Cmd Msg
foo x = getSitemap

init : Int -> ( Model, Cmd Msg )
init value =
    ( { siteMap = [] }, getSitemap )

type alias Page =
  { id : String,
    label: String
  }

encodePage : Page -> Json.Value
encodePage { id, label } = 
    object 
        [ ("Id", Json.string id)
        , ("Label", Json.string label)]

type alias Model =
    {
     siteMap : List Page
    }


encodeModel : Model -> Json.Value
encodeModel { siteMap } =
    object
        [ 
         ( "siteMap", Json.list (List.map encodePage siteMap))
        ]


type alias Payload =
    Int



-- ACTIONS


type Msg
    = NoOp
    | NewSitemap (Result Http.Error (List Page))
    | ChangeSitemap Value


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of

        NewSitemap (Ok siteMap) ->
            ({ model | siteMap = siteMap}, Cmd.none)

        NewSitemap (Err _) ->
            (model, Cmd.none)

        ChangeSitemap siteMap ->
            (model, Cmd.none)

        NoOp ->
            ( model, Cmd.none )


-- Http

decodePage : Json.Decode.Decoder Page
decodePage =
    Json.Decode.map2 Page (field "Id" Json.Decode.string)(field "Label" Json.Decode.string)

getSitemap: Cmd Msg
getSitemap = Http.send NewSitemap (getPages)

getPages: Http.Request (List Page)
getPages =
  let
    url ="/Sitemap.json"
  in
    (Http.get url (list decodePage))


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
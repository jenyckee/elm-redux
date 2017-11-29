port module Reducer exposing (Model, Msg, init, update, subscriptions)

import Redux
import Task exposing (..)
import Process
import Time exposing (..)
import Json.Encode as Json exposing (object, string, int)
import Json.Decode exposing (..)
import Http
import Mouse

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [
        ]


-- MODEL

foo : Value -> Cmd Msg
foo x = getSitemap

init : ( Model, Cmd Msg )
init =
    ( { siteMap = [] }, getSitemap )

type Page = Page {
    id : String,
    label: String,
    terms: List Page,
    friendlyUrl: String
  }

encodePage : Page -> Json.Value
encodePage (Page { id, label, terms, friendlyUrl }) = 
    object 
        [ ("Id", Json.string id)
        , ("Label", Json.string label)
        , ("FriendlyUrl", Json.string friendlyUrl)
        , ("Terms", Json.list (List.map encodePage terms))]

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
    List Page



-- ACTIONS


type Msg
    = NoOp
    | NewSitemap (Result Http.Error (List Page))


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of

        NewSitemap (Ok siteMap) ->
            ({ model | siteMap = siteMap}, Cmd.none)

        NewSitemap (Err _) ->
            (model, Cmd.none)

        NoOp ->
            ( model, Cmd.none )


-- Http

page : Json.Decode.Decoder Page
page =
    Json.Decode.map4 (\id label terms friendlyUrl -> Page { id = id, label = label, terms = terms, friendlyUrl = friendlyUrl})
        (field "Id" Json.Decode.string)
        (field "Label" Json.Decode.string)
        (field "Terms" (Json.Decode.list (Json.Decode.lazy (\_ -> page))))
        (field "FriendlyUrl" Json.Decode.string)

getSitemap: Cmd Msg
getSitemap = Http.send NewSitemap getPages

getPages: Http.Request (List Page)
getPages =
  let
    url ="/Sitemap.json"
  in
    Http.get url (list page)


asyncTask : Msg -> Cmd Msg
asyncTask msg =
    Process.sleep (2 * Time.second)
        |> Task.perform (always msg)

main : Program Never Model Msg
main =
    Redux.program
        { init = init
        , update = update
        , encode = encodeModel
        , subscriptions = subscriptions
        }
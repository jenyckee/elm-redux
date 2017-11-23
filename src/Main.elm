import Html exposing (..)
import Http
import Json.Decode exposing (..)
import Model exposing(Model, Msg, Page)
import View

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = View.view
    , update = update
    , subscriptions = subscriptions
    }

update : Msg -> Model.Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Model.MorePlease ->
      (model, getSitemap)

    Model.NewSitemap (Ok siteMap) ->
      (Model siteMap "", Cmd.none)

    Model.NewSitemap (Err _) ->
      (model, Cmd.none)
    
    Model.NewFilter f ->
      ({ model | filterString = f }, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- INIT

init : (Model, Cmd Msg)
init =
  ( Model [] ""
  , getSitemap 
  )

-- Http

decodePage : Json.Decode.Decoder Page
decodePage =
    Json.Decode.map2 Page (field "Id" Json.Decode.string)(field "Label" Json.Decode.string)

getSitemap: Cmd Msg
getSitemap = Http.send Model.NewSitemap (getPages)

getPages: Http.Request (List Page)
getPages =
  let
    url ="/Sitemap.json"
  in
    (Http.get url (list decodePage))

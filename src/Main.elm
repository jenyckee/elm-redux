port module Main exposing (main)

import Html exposing (..)
import Http
import Json.Decode exposing (..)
import Model exposing(Model, Msg, Page)
import View

main : Program String Model Msg
main =
  Html.programWithFlags
    { init = init
    , view = View.view
    , update = update
    , subscriptions = subscriptions
    }

port myPort : (String -> msg) -> Sub msg
port myOut : (Maybe (List Model.Page)) -> Cmd msg
port reduce : Model -> Cmd msg

update : Msg -> Model.Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Model.MorePlease ->
      (model, getSitemap)

    Model.NewSitemap (Ok siteMap) ->
      (Model siteMap "", myOut (Just siteMap))

    Model.NewSitemap (Err _) ->
      (model, Cmd.none)
    
    Model.NewFilter f ->
      ({ model | filterString = f }, reduce model)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ myPort Model.NewFilter
        ]


-- INIT

init : String -> (Model, Cmd Msg)
init server =
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

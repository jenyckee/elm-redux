import Html exposing (text)
import Http
import Json.Decode exposing (..)

main =
  text getPages

pageDecoder: Decoder String
pageDecoder = Json.Decode.string

getPages: Http.Request String
getPages =
  let
    url ="/Sitemap.json"
  in
    (Http.get url pageDecoder)
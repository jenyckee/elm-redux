import Html exposing (..)
import Http
import Json.Decode exposing (..)
import Html.Events exposing (..)

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Page =
    { id : String
    }

type alias Model =
  { siteMap : (List Page)
  }

type Msg
  = MorePlease
  | NewSitemap (Result Http.Error (List Page))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      (model, getSitemap)

    NewSitemap (Ok siteMap) ->
      (Model siteMap, Cmd.none)

    NewSitemap (Err _) ->
      (model, Cmd.none)

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text (toString model.siteMap)], 
      button [ onClick MorePlease ] [ text "More Please!" ]
    ]

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

init : (Model, Cmd Msg)
init =
  ( Model []
  , getSitemap 
  )

decodePage : Json.Decode.Decoder Page
decodePage =
    Json.Decode.map Page (field "Id" Json.Decode.string)

getSitemap: Cmd Msg
getSitemap = Http.send NewSitemap (getPages)

getPages: Http.Request (List Page)
getPages =
  let
    url ="/Sitemap.json"
  in
    (Http.get url (list decodePage))
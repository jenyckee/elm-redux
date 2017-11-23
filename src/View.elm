module View exposing (..)
import Model exposing (Page, Msg)
import Html exposing (..)
import Html.Events exposing (onInput)
import String exposing (contains)

view : Model.Model -> Html Model.Msg
view model = div [] [
    filterInput,
    ul [] (List.map pageView (List.filter 
    (\page -> contains model.filterString page.id) model.siteMap))
  ]

filterInput : Html Model.Msg
filterInput = input [onInput Model.NewFilter] []

pageView : Page -> Html Model.Msg
pageView page = li [] [text (toString page.label)]
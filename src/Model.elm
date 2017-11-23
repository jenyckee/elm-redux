module Model exposing (..)
import Http

type alias Page =
  { id : String,
    label: String
  }

type alias Model =
  { siteMap : (List Page),
    filterString : String
  }

type Msg
  = MorePlease
  | NewSitemap (Result Http.Error (List Page))
  | NewFilter String

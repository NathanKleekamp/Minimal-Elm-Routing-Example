module SiteNav exposing (view)

import Html exposing (Html, div, nav, ul, li, a, text)
import Html.Attributes exposing (href)

view : Html msg
view =
  div
    []
    [ nav
      []
      [ ul
        []
        [ li
          []
          [ a
            [ href "/#/"]
            [ text "Home" ]
          ]
        , li
          []
          [ a
            [ href "/#/blog"]
            [ text "Blog" ]
          ]
        ]
      ]
    ]

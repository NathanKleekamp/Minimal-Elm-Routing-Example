import Html exposing (Html, div, h1, text)

import UrlParser as Url exposing (..)
import Navigation exposing (Location)

import SiteNav as Nav

type Route
  = Home
  | Blog
  | NotFoundRoute


type Msg
  = OnLocationChange Location


type alias Model =
  { route : Route }


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


init : Location -> (Model, Cmd Msg)
init location =
  let
    currentRoute =
      parseLocation location
  in
    (initialModel currentRoute, Cmd.none)


initialModel : Route -> Model
initialModel route =
  { route = route }


matchers : Parser (Route -> a) a
matchers =
  oneOf
    [ Url.map Home top
    , Url.map Blog (s "blog")
    ]


parseLocation : Location -> Route
parseLocation location =
  case (parseHash matchers location) of
    Just route ->
      route

    Nothing ->
      NotFoundRoute


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    OnLocationChange location ->
      let
        newRoute =
          parseLocation location
      in
        ( { model | route = newRoute }, Cmd.none )


notFoundView : Html msg
notFoundView =
  div
    []
    [ h1
      []
      [ text "404 - Page Not Found" ]
    ]


homeView : Html msg
homeView =
  div
    []
    [ Nav.view
    , h1
      []
      [ text "Hello World" ]
    ]


blogView : Html msg
blogView =
  div
    []
    [ Nav.view
    , h1
      []
      [ text "Hello Blog" ]
    ]


view : Model -> Html Msg
view model =
  case model.route of
    Home ->
      homeView
    Blog ->
      blogView
    NotFoundRoute ->
      notFoundView

main : Program Never Model Msg
main =
  Navigation.program OnLocationChange
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

module RESTClient exposing (..)

import Http exposing (get, post, send, emptyBody)
import Html exposing (Html, div, button, text, h2)
import Html.Events exposing (onClick, onInput)
import Json.Decode exposing (Decoder, int, at)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup

main : Program Never Model Msg
main = Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

-- MODEL

type alias Model = { counter : Int }

initialModel : Model
initialModel = Model 0

init : (Model, Cmd Msg)
init = (initialModel, fetchCount)

-- VIEW

type Msg = Get
         | Set
         | FetchCount (Result Http.Error Int)
         | ResetCount (Result Http.Error Int)

view : Model -> Html Msg
view model =
  Grid.container []
    [ CDN.stylesheet,
      Grid.row [ Row.centerMd ]
        [ Grid.col [ Col.xs12, Col.mdAuto ]
          [ ButtonGroup.buttonGroup []
            [ ButtonGroup.button [ Button.primary, Button.attrs [ onClick Get ]] [ text "Get" ]
            , ButtonGroup.button [ Button.secondary, Button.attrs [ onClick Set]] [ text "Set" ]
            ]
          ]
        ],
      Grid.row [ Row.centerMd ]
        [ Grid.col [ Col.xs12, Col.mdAuto ]
          [ h2 [] [text (toString model.counter)] ]
        ]
    ]

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Get ->
      (model, fetchCount)
    Set ->
      (model, resetCount)
    FetchCount result ->
      case result of
        Ok val ->
          ({ model | counter = val}, Cmd.none)
        Err _ ->
          (model, Cmd.none)
    ResetCount result ->
      case result of
        Ok val ->
          ({ model | counter = val }, Cmd.none)
        Err _ ->
          (model, Cmd.none)

-- HTTP

fetchCount : Cmd Msg
fetchCount =
  let
    url = "http://localhost:8080/elm_REST_server_test/api/counter"
    request = Http.get url countDecoder
  in
    Http.send FetchCount request

resetCount : Cmd Msg
resetCount =
  let
    url = "http://localhost:8080/elm_REST_server_test/api/counter/1"
    request = Http.post url Http.emptyBody int
  in
    Http.send ResetCount request

-- DECODER

countDecoder : Decoder Int
countDecoder = at ["counter"] int

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

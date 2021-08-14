module Main exposing (..)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)



---- MODEL ----


type alias Model =
    { todoList : List String
    , currentTodo : String
    }


init : ( Model, Cmd Msg )
init =
    ( { todoList = []
      , currentTodo = ""
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = WriteTodo String
    | SaveTodo


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WriteTodo todo ->
            ( { model | currentTodo = todo }
            , Cmd.none
            )

        SaveTodo ->
            ( { currentTodo = ""
              , todoList = model.todoList ++ [ model.currentTodo ]
              }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }

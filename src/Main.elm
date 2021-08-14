port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (name, type_, value)
import Html.Events exposing (onInput, onSubmit)



---- PORTS ----


port saveChanges : List String -> Cmd msg



---- MODEL ----


type alias Model =
    { todoList : List String
    , currentTodo : String
    }


type alias Flags =
    List String


init : Flags -> ( Model, Cmd Msg )
init todoList =
    ( { todoList = todoList
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
            let
                newTodoList =
                    model.todoList ++ [ model.currentTodo ]
            in
            ( { currentTodo = ""
              , todoList = newTodoList
              }
            , saveChanges newTodoList
            )



---- VIEW ----


view : Model -> Html Msg
view { todoList, currentTodo } =
    div []
        [ ul []
            (List.map
                (\todo -> li [] [ text todo ])
                todoList
            )
        , form [ onSubmit SaveTodo ]
            [ input
                [ type_ "text"
                , name "todo"
                , value currentTodo
                , onInput WriteTodo
                ]
                []
            , input
                [ type_ "submit"
                , value "Add Todo"
                ]
                []
            ]
        ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }

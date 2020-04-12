module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { input : String
    , todos : List String
    }


init : Model
init =
    { input = ""
    , todos = []
    }


type Msg
    = Input String
    | Add
    | Delete Int



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model
                | input = input
            }

        Add ->
            { model
                | input = ""
                , todos = model.input :: model.todos
            }

        Delete num ->
            { model
                | todos = List.take num model.todos ++ List.drop (num + 1) model.todos
            }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.form [ onSubmit Add ]
            [ input [ value model.input, onInput Input ] []
            , button
                [ disabled (String.length model.input < 1) ]
                [ text "Add" ]
            ]
        , ul [] (List.indexedMap viewTodo model.todos)
        ]


viewTodo : Int -> String -> Html Msg
viewTodo i todo =
    li [ onClick (Delete i) ] [ text todo ]

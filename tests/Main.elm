module Main exposing (..)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import CommonMark
import Test.View


main : Program Never Model Msg
main =
    Html.program
        { init = init ! []
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { textarea : String
    }


init : Model
init =
    { textarea = ""
    }


type Msg
    = TextAreaInput String
    | Markdown


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TextAreaInput str ->
            { model | textarea = str } ! []

        Markdown ->
            model ! []


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Pure Elm Markdown" ]
        , textarea
            [ onInput TextAreaInput
            , defaultValue model.textarea ] []
        , br [] []
        , p []
            [ text
                <| toString
                <| CommonMark.toBlocks model.textarea
            ]
        , Html.map (always Markdown)
            <| div []
            <| CommonMark.toHtml model.textarea
        , Html.map (always Markdown) Test.View.view
        ]


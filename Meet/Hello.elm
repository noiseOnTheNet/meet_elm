module Meet.Hello exposing (..)

import Html exposing (div, text, h1)


main : Html.Html Never
main =
    div [] [ h1 [] [ text "Hello World" ] ]

module Meet.Form exposing (..)

import Html exposing (Html, div, text, button, input, hr, label)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (type_, value, for, id, style)


-- MODEL


type alias Model =
    { counter : Int
    , pass1 : String
    , pass2 : String
    , passMatching : Bool
    , passSecurity : PassSecurity
    }


init : ( Model, Cmd Msg )
init =
    ( { counter = 1
      , pass1 = ""
      , pass2 = ""
      , passMatching = False
      , passSecurity = Weak
      }
    , Cmd.none
    )


type PassSecurity
    = Weak
    | Minimal
    | Good



-- MESSAGES


type Msg
    = Increase
    | Decrease
    | UpdatePass1 String
    | UpdatePass2 String



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Increase ->
            ( { model | counter = model.counter + 1 }, Cmd.none )

        Decrease ->
            ( { model | counter = model.counter + 1 }, Cmd.none )

        UpdatePass1 value ->
            let
                passLength =
                    String.length value

                security =
                    if passLength < 4 then
                        Weak
                    else
                        (if passLength < 6 then
                            Minimal
                         else
                            Good
                        )
            in
                ( { model
                    | pass1 = value
                    , passSecurity = security
                  }
                , Cmd.none
                )

        UpdatePass2 value ->
            let
                match =
                    value == model.pass1
            in
                ( { model
                    | pass2 = value
                    , passMatching = match
                  }
                , Cmd.none
                )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increase ] [ text "Add 1" ]
        , div [] [ text <| toString model.counter ]
        , button [ onClick Decrease ] [ text "Remove 1" ]
        , hr [] []
        , div []
            [ label [ for "pass1" ] [ text "type your pasaword" ]
            , input
                [ id "pass1"
                , onInput UpdatePass1
                , type_ "password"
                , value model.pass1
                ]
                []
            , text <| "Security " ++ (toString model.passSecurity)
            ]
        , hr [] []
        , div []
            [ label [ for "pass2" ] [ text "retype your password" ]
            , input
                [ id "pass2"
                , onInput UpdatePass2
                , type_ "password"
                , value model.pass2
                ]
                []
            , let
                ( message, color ) =
                    if model.passMatching then
                        ( "Matching", "green" )
                    else
                        ( "Not Matching", "red" )
              in
                div [ style [ ( "color", color ) ] ] [ text message ]
            ]
        ]



-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }

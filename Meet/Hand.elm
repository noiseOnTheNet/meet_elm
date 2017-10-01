module Meet.Hand exposing (..)

import Html exposing (Html, div, img, text)
import Html.Attributes exposing (src)
import Mouse exposing (Position)


-- MODEL


type alias Model =
    { position : Position
    , direction : Direction
    }


type Direction
    = Left
    | Right


init : ( Model, Cmd Msg )
init =
    ( { position = { x = 0, y = 0 }
      , direction = Right
      }
    , Cmd.none
    )



-- MESSAGES


type Msg
    = Move Position



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves Move



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Move newPosition ->
            let
                newDirection =
                    if newPosition.x > 400 then
                        Right
                    else
                        Left
            in
                ( { position = newPosition
                  , direction = newDirection
                  }
                , Cmd.none
                )



-- VIEW


view : Model -> Html Msg
view model =
    let
        imageSource =
            case model.direction of
                Right ->
                    "images/RightPointingHand.svg"

                Left ->
                    "images/LeftPointingHand.svg"
    in
        div []
            [ div [] [ text <| toString model.position.x ]
            , div [] [ img [ src imageSource ] [] ]
            ]



-- ]
-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }

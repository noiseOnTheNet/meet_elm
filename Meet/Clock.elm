module Meet.Clock exposing (..)

import Html exposing (Html, div, text)
import Time
import Svg exposing (svg, circle, line)
import Svg.Attributes
    exposing
        ( width
        , height
        , viewBox
        , cx
        , cy
        , r
        , fill
        , stroke
        , strokeWidth
        , x1
        , y1
        , x2
        , y2
        )


-- MODEL


type alias Model =
    { time : Time.Time }


init : ( Model, Cmd Msg )
init =
    ( { time = 0 }, Cmd.none )



-- MESSAGES


type Msg
    = Nop
    | Tick Time.Time



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (1 * Time.second) Tick



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Nop ->
            ( model, Cmd.none )

        Tick time ->
            ( { model | time = time }, Cmd.none )



-- VIEW


hand radius s =
    let
        angle =
            ((2.0 * (s / 60.0)) - 0.5) * pi

        sy =
            radius * sin angle

        sx =
            radius * cos angle
    in
        { x = sx, y = sy }


drawHand center h =
    line
        [ x1 <| toString center.x
        , y1 <| toString center.y
        , x2 <| toString (center.x + h.x)
        , y2 <| toString (center.y + h.y)
        , stroke "red"
        , strokeWidth <| toString 4
        ]
        []


view : Model -> Html Msg
view model =
    let
        hours =
            model.time
                |> Time.inHours
                |> round
                |> flip rem 12

        minutes =
            model.time
                |> Time.inMinutes
                |> round
                |> flip rem 60

        seconds =
            model.time
                |> Time.inSeconds
                |> round
                |> flip rem 60

        wd =
            toString 800

        ht =
            toString 600

        center =
            { x = 400.0, y = 300.0 }

        radius =
            200.0

        secHand =
            hand radius <| toFloat seconds

        minHand =
            hand (0.8 * radius) <| toFloat minutes

        hourHand =
            hand (0.5 * radius) <| toFloat (5 * hours)
    in
        div []
            [ div [] [ text <| toString hours ]
            , div [] [ text <| toString minutes ]
            , div [] [ text <| toString seconds ]
            , div []
                [ svg
                    [ width wd, height ht, viewBox <| "0 0 " ++ wd ++ " " ++ ht ]
                    [ circle
                        [ cx <| toString center.x
                        , cy <| toString center.y
                        , r <| toString radius
                        , fill "white"
                        , stroke "#AAAA00"
                        , strokeWidth <| toString 4
                        ]
                        []
                    , drawHand center secHand
                    , drawHand center minHand
                    , drawHand center hourHand
                    ]
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

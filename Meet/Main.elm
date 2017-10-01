module Meet.Main exposing (..)

import Html exposing (Html, div, text)
import Meet.Clock as Clock
import Meet.Form as Form
import Meet.Hand as Hand


-- MODEL


type alias Model =
    { hand : Hand.Model
    , clock : Clock.Model
    , form : Form.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        ( handM, handC ) =
            Hand.init

        ( clockM, clockC ) =
            Clock.init

        ( formM, formC ) =
            Form.init
    in
        ( { hand = handM
          , clock = clockM
          , form = formM
          }
        , Cmd.batch
            [ Cmd.map HandMsg handC
            , Cmd.map ClockMsg clockC
            , Cmd.map FormMsg formC
            ]
        )



-- MESSAGES


type Msg
    = HandMsg Hand.Msg
    | ClockMsg Clock.Msg
    | FormMsg Form.Msg



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        clockS =
            Sub.map ClockMsg <| Clock.subscriptions model.clock

        formS =
            Sub.map FormMsg <| Form.subscriptions model.form

        handS =
            Sub.map HandMsg <| Hand.subscriptions model.hand
    in
        Sub.batch [ clockS, formS, handS ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        ClockMsg msg ->
            let
                ( clockNewM, clockNewC ) =
                    Clock.update msg model.clock
            in
                ( { model | clock = clockNewM }, Cmd.map ClockMsg clockNewC )

        FormMsg msg ->
            let
                ( formNewM, formNewC ) =
                    Form.update msg model.form
            in
                ( { model | form = formNewM }, Cmd.map FormMsg formNewC )

        HandMsg msg ->
            let
                ( handNewM, handNewC ) =
                    Hand.update msg model.hand
            in
                ( { model | hand = handNewM }, Cmd.map HandMsg handNewC )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map ClockMsg <| Clock.view model.clock
        , Html.map HandMsg <| Hand.view model.hand
        , Html.map FormMsg <| Form.view model.form
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

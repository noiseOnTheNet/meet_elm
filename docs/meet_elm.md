

# Hello World


## Simplest Program

let's begin with the most easy program

    main = div [] [text "Hello World"]

when we save it the formatter changes a little the spaces: it is useful for

-   reading consistently stuff
-   verify trivial sintax errors (as it parse the code in order to
    format it)

The formatter nicely integrates all programmer' editors (no notepad)


### Import and Export

It also added a new line with the module declaration: we change it a little

    module Hello exposing (..)

now let's add some import that define the html functions

    import Html exposing (div, text, h1)


## Install Packages

Before compiling we need to install some packages: you can find a
complete list at <http://package.elm-lang.org>

    elm-package install elm-lang/html

this will install the html package and its dependencies

elm creates a file `elm-package.json` with all ours specifications and
a directory `elm-stuff` where all packages will be downloaded


## Compile

To compile the package we can use

    elm-make Hello.elm --output index.html

this will create an html file with the compiled program


## Add Types

We can add some warning to the compiler

    elm-make --warn Hello.elm --output index.html

this gives us a hint about the type of our value: we can write a type
declaration like this

    main : Html.Html Never

immediately before the code

Never is a type with no values: this means that our HTML is not dynamic


## Generate Json Lib

We can also generate a json library which can help us integrating with
other HTML

    elm-make --warn Hello.elm --output main.js

we just need to add this in the body

    <body>
      <H1>This is the external HTML<H1>
      <script type="text/javascript" src="main.js"></script>
      <div id="main"></div>
      <script type="text/javascript">
        var d = document.getElementById('main');
        Elm.Hello.embed(d);
      </script>
    </body>


## Takeaways

-   Compiler infer types
    -   this helps us a lot in debugging and development
    -   a lot of effort has been put since the beginning to get useful
        error messages
    -   the language support parametric polymorphism
-   Semantic packaging and modules
    -   modules are the mean to provide encapsulation
    -   published module are enforced to change major version if the
        exposed signatures change
    -   this means that module upgrades don't hurt


# Simple Form


## Elm Architecture: A Simple Form

From version 0.17 of Elm, the previous language has been greatly
simplified removing the whole "reactive" infrastructure for a less
powerful but efficient and clear pattern

We start this journey with two buttons which can increase or decrease
an integer value


### The Main Function

the main function accepts a record containing 4 functions: we will go
through each one

    main : Program Never Model Msg
    main =
        Html.program
    	{ init = init
    	, subscriptions = subscriptions
    	, update = update
    	, view = view
    	}

The type means: this is a `Program` that has no startup input and an
inner state of type `Model` which is modified by event of type `Msg`


### The Model

this type represents the state of the application

    type alias Model = Int

Alias are useful to read the code and the error messages

We start simple this time, but we will refactor later


### The Init

we need to set up the initial state at the beginning of the application

    init : ( Model, Cmd Msg )
    init = ( 0, Cmd.none )

init returns a pair whose first element is the status and the second
is an "effect" value or a command to execute something (e.g. send a message to a server).

We start with 0 and no effect.

Cmd is a PARAMETRIC type which accepts another type as parameter


### Messages

this data type should represent the asynchronous signals coming from
the application

    type Msg = Increment | Decrement

this is called a UNION type; in this case it has exactly 2 values


### Update

this function will change the state of the application according to
signals

    update : Msg -> Model -> ( Model, Cmd Msg )
    update message model = 
        case message of
    	Increase ->
    	    ( model + 1, Cmd.none )
    
    	Decrease ->
    	    ( model - 1, Cmd.none )

the type tells that this function expect the event as first input, the
old status as second and gives out the modified status paired with a
command (or "effect")


### View

this function shows the page starting from the model

    view : Model -> Html Msg
    view model =
        div []
    	[ button [ onClick Increase ] [ text "Add 1" ]
    	, div [] [ text <| "Buy " ++ (toString model) ++ " bananas" ]
    	, button [ onClick Decrease ] [ text "Remove 1" ]
    	]


### update Index.html

a little change is needed in the html call to find the module

    <script type="text/javascript">
      var d = document.getElementById('main');
      Elm.Form.embed(d);
    </script>


## Extending The Form


### Adding more Widget


### Adding more Messages


### Extending the State


### Extending the Update


## Debugger


### Compiling with debugger option


### Time Travelling


## Takeaways


### The Type System support refactoring


### The Purity support debug


# Clock


## Elm Architecture (Again): Getting The Time


### Subscriptions


### SVN


## Takeaways


### Asynchronous events are all created equal


### Dynamic DOM Update


### Effects are accessible: type system aids checking


# Hand


## Asynchronous Events (Again): The Mouse


## Transform events into types


## Takeaways


### Asynchronous events are all created equal (Again)


### Games anyone?


# All Together


## Import and Export


## Model


## Init


## Update


## Subscriptions


## Takeaways


### The Elm architecture is scalable


### There is more behind Map than your eyes see now


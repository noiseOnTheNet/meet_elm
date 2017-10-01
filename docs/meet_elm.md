

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

    module Meet.Hello exposing (..)

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
        Elm.Meet.Hello.embed(d);
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


### Model


### Messages


### Update


### View


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


# Sync CSS Transition and State Change

This example covers one approach to synchronizing changes in your UI with
changes to your application's state.

For example, if you're building a quiz in which each question has its own
screen and you'd like to use a CSS transition when moving between the screens
(change background color, opacity, etc.), you'll need to somehow synchronize
the model change with the CSS transition. If you do not, the state change will
cause the view to be updated immediately and the user will (probably) not see
the CSS transition.

The solution presented in this example uses Process/Task to delay the state
change, so it's in time with the CSS transition. If you're using elm-css (or
defining the transition inline), this works especially well because you can
define one value which both the CSS transition and the model delay share. This
approach will also work if you're using an external stylesheet, but you'll need
to ensure the delay/transition are kept in sync.

TODO

## Demo
- https://ellie-app.com/3wTR8tFFjL3a1

## Running the example:
- `npm install --global elm elm-live` (if you haven't already)
- `elm-live src/Main.elm`

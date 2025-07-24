# Normalized user input

This example covers how and why you might want to maintain two versions of a
piece of state (a raw variant and a normalized variant).

1) The user's raw input, which has not been normalized by the application. This
variant is useful for a variety of reasons, but two that jump out are:
- the expected form UX holds and value in the bound form field won't be changed
out from under the user
- it might be desireable to use the raw variant in the application's UI (e.g.
as a stylized handle, like xXaoh3llhaxorzXx)

2) A normalized variant of the user's raw input which has been processed by
the application. The exact procedure(s) applied to the raw input and what it
will be used for will vary depending on the needs of the application. However,
this example shows how you'd transform the raw input string to lowercase,
replace spaces with underscores and trim leading/trailing spaces. The sanitized
value could then be used as a Dict key or an HTML element's ID.

## Demo
- https://ellie-app.com/3sTMvVDBKYRa1

## Running the example:
- `npm install --global elm elm-live` (if you haven't already)
- `elm-live src/Main.elm --output=elm.js --open`

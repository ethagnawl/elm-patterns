# Decaying Class Name

This is an example which shows how you'd add a class name to an element upon
some event (e.g. mousemove) and then have that class decay over N seconds.
Additionally, subsequent events which occur before N seconds have passed will
reset the timer.

## Demo
- https://pdoherty-demos.s3.us-east-1.amazonaws.com/decaying-class-name/gren/index.html

## Running the example from this directory:
- `npm install --global gren` (if you haven't already)
- `make` or `gren make Main --output=./output/gren.js`
- `python3 -m http.server $PORT`

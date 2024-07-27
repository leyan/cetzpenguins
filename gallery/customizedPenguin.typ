#import "@preview/cetz:0.2.2"
#import "../src/penguins.typ" :penguin,penguinInternal,anchor-coords

#set page(width: 3cm, height: 4cm)
#set align(center+horizon)

#penguin(
  width:2cm,
  body-color:blue,
  head-color:aqua,
  left-eye:(color:red,
    shape:"shiny"),
  right-eye:(
    color:green,
    shape:"wink")
)
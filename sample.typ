#import "@preview/cetz:0.2.2"
#import "src/penguins.typ" :penguin,penguinInternal


#cetz.canvas({
   import cetz.draw: *
   circle(radius:1,())
   translate(x:3cm)
   penguinInternal()
   translate(x:5cm)
   penguinInternal()
})

#penguin()
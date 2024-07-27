#import "@preview/cetz:0.2.2"
#import "src/penguins.typ" :penguin,penguinInternal


#cetz.canvas(length:1cm,{
   import cetz.draw: *
   penguinInternal() 
   translate(x:3,y:1)
   penguinInternal()
   translate(x:2.5,y:-0.5)
   penguinInternal()
   translate(x:2.5,y:0.2)
   penguinInternal()
})


#penguin()

#penguin(
  width:1.5cm,
  color:aqua,
  eyes:(
    shape:"wink"
  )
)

#penguin(
  width:2cm,
  body-color:blue,
  head-color:red,
  left-eye:(color:red,
    shape:"shiny"),
  right-eye:(
    color:green,
    shape:"wink")
)


#penguin(
  width:3cm,
  left-eye:(color:green),
  right-eye:(shape:"none")
)
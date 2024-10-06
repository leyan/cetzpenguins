#import "@preview/cetz:0.2.2"
#import cetz.draw: *


#let anchor-coords(anchor-name) = {
  get-ctx(ctx => {
    let round(a) = a.map(v => calc.round(v,digits:4))
    let (ctx,a) = cetz.coordinate.resolve(ctx,anchor-name)
    let(x,y,z)=a
    circle((x,y),fill:red,stroke:none,radius:0.02)
    line(stroke:0.1pt+red,anchor-name,(rel:(-0.1,0.1),to:anchor-name))
    content((rel:(0.1,0.1),to:anchor-name), text(1pt,[#anchor-name: #round(a)]))
  })
}


#let penguinInternal(color:none,body-color:none,head-color:none,eyes:none,left-eye:none,right-eye:none)= {

  let penguin-blue = rgb(3,14,29)
  let penguin-black = rgb(23,19,19)
  let penguin-yellow = rgb(252,187,21)
  let penguin-white = rgb(248,248,248)

  //default colors
  let body-color-value = penguin-blue
  let head-color-value = penguin-blue
  let right-wing-color-value = penguin-blue
  let left-wing-color-value = penguin-blue
  let belly-color-value = penguin-white
  let hair-color-values = (penguin-blue,penguin-blue,penguin-blue,penguin-blue,penguin-blue)
  let left-foot-color-value = penguin-yellow
  let right-foot-color-value = penguin-yellow
  let bill-color-value = penguin-yellow


  let eyes-color-value = penguin-black
  let left-eye-color-value =  eyes-color-value
  let right-eye-color-value =  eyes-color-value
  let eyes-secondary-color-value = penguin-white
  let left-eye-secondary-color-value = eyes-secondary-color-value
  let right-eye-secondary-color-value = eyes-secondary-color-value
  let eyes-shape-value = "normal"
  let left-eye-shape-value = eyes-shape-value
  let right-eye-shape-value = eyes-shape-value

  //Customization parameters
  if color != none {
    body-color-value = color
    head-color-value = color
    right-wing-color-value = color
    left-wing-color-value = color
    hair-color-values = (color,color,color,color,color)
  } 
  if body-color != none {
    body-color-value = body-color
  }
  if head-color != none {
    head-color-value = head-color
  }

  if eyes != none {
    eyes-color-value = eyes.at("color",default:eyes-color-value)
    left-eye-color-value =  eyes-color-value
    right-eye-color-value =  eyes-color-value
    eyes-shape-value = eyes.at("shape",default:eyes-shape-value)
    left-eye-shape-value = eyes-shape-value
    right-eye-shape-value = eyes-shape-value
  }
  if left-eye != none {
    left-eye-color-value =  left-eye.at("color",default:left-eye-color-value)
    left-eye-shape-value = left-eye.at("shape",default:left-eye-shape-value)
  }
  if right-eye != none {
    right-eye-color-value =  right-eye.at("color",default:right-eye-color-value)
    right-eye-shape-value = right-eye.at("shape",default:right-eye-shape-value)
  }

  


  let penguin-half-width = 0.9375 //\pingu@w@half
  let penguin-half-height = 1.275 // \pingu@side@h@half
  let penguin-head-half-height = 0.9 * penguin-half-width // \pingu@head@h@half
  let penguin-bend = 0.125 //\pingu@bend
  let penguin-white-offset = 0.1
  let penguin-lower-offset = 0.25 //\pingu@lower@off
  let penguin-outer-offset = 0.25 //\pingu@outer@off
  let penguin-foot-outer-width = 0.45 //\pingu@foot@outer@w
  let penguin-foot-outer-height = 0.25 //\pingu@foot@outer@h
  let penguin-foot-inner-width = 0.55 //\pingu@foot@inner@w
  let penguin-foot-inner-height = 0.115//\pingu@foot@inner@h
  let penguin-foot-single-width = 0.105 //\pingu@foot@single@w
  let penguin-foot-single-height = 0.2 //\pingu@foot@single@h
  let penguin-basic-feet-bend = 45deg
  
  let penguin-side-half-size = 1.275 //\\pingu@side@h@half
  let penguin-head-connection-x-offset = 0.39375 // .75*.525 \pingu@headcon@x
  let penguin-head-connection-y-offset = 0.46735 // .719*.65 \pingu@headcon@y
  let penguin-angle-head-left = 7deg
  let penguin-angle-head-right = 93deg
  let penguin-eye-shift = 0.08//\pingu@eye@shift

  let eye-base-angle = 38.5deg

group(name:"body",{

  // BODY OUTLINE

   merge-path(fill:body-color-value,stroke:none, {
  arc-through((0,penguin-outer-offset),(rel:(-0.0283,-penguin-outer-offset -0.5125),update:false),(0,- penguin-side-half-size ),    name:"right")
  arc((),start: 180deg, stop: 270deg,radius:(penguin-foot-outer-width,penguin-foot-outer-height),name:"waist-to-foot-rigth")
  arc((),start: 270deg, stop: 332deg,radius:(penguin-foot-inner-width,penguin-foot-inner-height),name:"foot-inner-rigth")
  arc((),start: 208deg, stop: 270deg,radius:(penguin-foot-inner-width,penguin-foot-inner-height),name:"foot-inner-left")
  arc((),start: 270deg, stop: 360deg,radius:(penguin-foot-outer-width,penguin-foot-outer-height),name:"waist-to-foot-left")
  arc-through((),(rel:(0.0283,penguin-outer-offset+0.5125),update:false),(rel:(0,penguin-side-half-size + penguin-outer-offset)),    name:"left")
  line((),(0,penguin-outer-offset),name:"center-horizontal")
   })
    anchor("wings-side-right","right.start")
    anchor("wings-side-left","left.end")
    anchor("waist-right","right.77.5%")
    anchor("waist-right-middle","right.50%")
    anchor("waist-left-middle","left.50%")
    anchor("foot-right","waist-to-foot-rigth.end")
    anchor("bottom-center","foot-inner-rigth.end")
    anchor("foot-left","foot-inner-left.end")
    anchor("head-center","center-horizontal.mid")

  // HEAD

  //line("head-center",(rel:(0,penguin-head-half-height)),name:"head-middle")
  circle(fill:head-color-value,stroke:none,"head-center",radius:(penguin-half-width,penguin-head-half-height),name: "head")
  //arc((),start: 90deg, stop: 450deg,radius:(penguin-half-width,penguin-head-half-height))
    anchor("head-top","head.north")
    anchor("head-topleft","head.7.3%")
    anchor("head-topright","head.92.7%")

  // BELLY

   merge-path(fill:belly-color-value,stroke:none, {
  line(stroke:yellow,(penguin-half-width,-1),(rel:(-penguin-half-width+0.1,penguin-lower-offset)),name:"start-belly")
  line((),(rel:(0,1.05 - penguin-side-half-size - penguin-outer-offset)),name:"belly-left")
  //arc-through((),(rel:(-0.01,(1.05 - penguin-side-half-size - penguin-outer-offset)/2),update:false),(rel:(0,1.05 - penguin-side-half-size - penguin-outer-offset)),name:"belly-left")
  arc((),start: 180deg, stop: 270deg,radius:(0.4,0.2))
  arc((),start: 270deg, stop: 331deg,radius:(0.5,0.085))
  arc((),start: 207deg, stop: 270deg,radius:(0.5,0.085))
  arc((),start: 270deg, stop: 360deg,radius:(0.4,0.2))
  line((),(rel:(0,-1.05 + penguin-side-half-size + penguin-outer-offset)))
  arc((),start:0deg,stop:180deg,radius:(penguin-half-width - 0.096,penguin-half-width - 0.1))
   })
    anchor("belly-back","start-belly.start")
    anchor("belly-test","start-belly.end")
    anchor("belly-left","belly-left.end")
    anchor("eye-back-left",(rel:(0.275,0.25 - penguin-outer-offset),to:"head-center"))
    anchor("eye-back-right",(rel:(-0.275,0.25 - penguin-outer-offset),to:"head-center"))
    anchor("head-back-con-left",(rel:(penguin-head-connection-x-offset, -penguin-head-connection-y-offset),to:"eye-back-left"))
    anchor("head-back-con-right",(rel:(-penguin-head-connection-x-offset, -penguin-head-connection-y-offset),to:"eye-back-right"))

//FACE SHAPE

circle(fill:belly-color-value,stroke:none,(rel:(0, - 0.025),to:"eye-back-right"),radius:(0.525,0.625),name:"face-right")
circle(fill:belly-color-value,stroke:none,(rel:(0, - 0.025),to:"eye-back-left"),radius:(0.525,0.625),name:"face-left")

})
let draw-eye-shiny(origin) = {
  
}

let eye-left-position  = (rel:( penguin-eye-shift,0.075),to:"body.eye-back-left")
let eye-right-position = (rel:(-penguin-eye-shift,0.075),to:"body.eye-back-right")
//EYES

group(name:"left-eye",{
anchor("eye-left","body.eye-back-left")
if left-eye-shape-value=="normal" {
  circle(fill:left-eye-color-value,stroke:none,eye-left-position,radius:(0.1225,0.1365))
} else if left-eye-shape-value=="shiny" {
  circle(fill:left-eye-color-value,stroke:none,eye-left-position,radius:(0.22,0.26),name: "eye-shape")
  circle(fill:left-eye-secondary-color-value,stroke:none,radius:(0.08,0.1),(rel:(angle:eye-base-angle,radius:(0.085,0.1)),to:"eye-shape.center"))
  circle(fill:left-eye-secondary-color-value,stroke:none,radius:(0.025,0.035),(rel:(angle:eye-base-angle+180deg,radius:(0.12,0.14)),to:"eye-shape.center"))
} else if left-eye-shape-value=="wink" {
    group(name:"left-inner-eye",{
      rotate(-4deg,origin:eye-left-position)
      line(stroke:none,
        eye-left-position,
        (rel:(angle:174deg,radius:0.14),to:()),
        (rel:(0,-0.065),to:()),name:"start-line")
     merge-path(fill:left-eye-color-value,stroke:none, {
      arc((),start:174deg,stop:6deg,radius:(0.14,0.14))
      arc((),start:-6deg,stop:-174deg,radius:(0.01,0.008))
      arc((),start:6deg,stop:174deg,radius:(0.12,0.065))
      arc((),start:-6deg,stop:-174deg,radius:(0.01,0.008))
     })
    })
} else if left-eye-shape-value=="none" {

}else {
  panic("Unknown left-eye shape: ",left-eye-shape-value)
}
})

group(name:"right-eye",{
if right-eye-shape-value=="normal" {
  circle(fill:right-eye-color-value,stroke:none,eye-right-position,radius:(0.1225,0.1365))
} else if right-eye-shape-value=="shiny" {
  circle(fill:right-eye-color-value,stroke:none,eye-right-position,radius:(0.22,0.26),name: "eye-shape")
  circle(fill:right-eye-secondary-color-value,stroke:none,radius:(0.08,0.1),(rel:(angle:eye-base-angle,radius:(0.085,0.1)),to:"eye-shape.center"))
  circle(fill:right-eye-secondary-color-value,stroke:none,radius:(0.025,0.035),(rel:(angle:eye-base-angle+180deg,radius:(0.12,0.14)),to:"eye-shape.center"))
} else if right-eye-shape-value=="wink" {
    rotate(4deg,origin:eye-right-position)
    line(stroke:none,
      eye-right-position,
      (rel:(angle:174deg,radius:0.14),to:()),
      (rel:(0,-0.065),to:()))
   merge-path(fill:right-eye-color-value,stroke:none, {
    arc((),start:174deg,stop:6deg,radius:(0.14,0.14))
    arc((),start:-6deg,stop:-174deg,radius:(0.01,0.008))
    arc((),start:6deg,stop:174deg,radius:(0.12,0.065))
    arc((),start:-6deg,stop:-174deg,radius:(0.01,0.008))
   })
} else if right-eye-shape-value=="none" {

}else {
  panic("Unknown right-eye shape: ",right-eye-shape-value)
}
})
//WINGS

on-layer(-1,{
  group(name:"wings",{
  anchor("left-start",(rel:(0,-0.65),to:"body.wings-side-left"))
  anchor("right-start",(rel:(0,-0.65),to:"body.wings-side-right"))

  rotate(15deg,origin:"right-start")
  circle(fill:left-wing-color-value,stroke:none,radius:(0.195,0.9),"left-start",name:"left-wing")
  circle(fill:none,stroke:none,radius:(0.145,0.75),"left-start",name:"left-wing-internal")
  anchor("left-wing-tip","left-wing.south")
  anchor("left-wing","left-wing-internal.south")
  rotate(-15deg,origin:"right-start")

  rotate(-15deg,origin:"right-start")
  circle(fill:right-wing-color-value,stroke:none,radius:(0.195,0.9),"right-start",name:"right-wing")
  circle(fill:none,stroke:none,radius:(0.145,0.75),"right-start",name:"right-wing-internal")
  anchor("right-wing-tip","right-wing.south")
  anchor("right-wing","right-wing-internal.south")
  rotate(15deg,origin:"right-start")
})
})

//HAIR


on-layer(-1,{
   merge-path(fill:hair-color-values.at(0),stroke:none, {
line((rel:(0,-0.1),to:"body.head-top"),(rel:(0.015,0)))
arc((),start:0deg,stop:90deg,radius:(0.125,0.135))
arc((),start:90deg,stop:0deg,radius:(0.035,0.075))
   })
   merge-path(fill:hair-color-values.at(1),stroke:none, {
line((rel:(0,-0.1),to:"body.head-top"),(rel:(0.033,0)))
arc((),start:0deg,stop:90deg,radius:(0.125,0.175))
arc((),start:90deg,stop:0deg,radius:(0.035,0.1))
   })
   merge-path(fill:hair-color-values.at(2),stroke:none, {
line((rel:(0,-0.1),to:"body.head-top"),(rel:(-0.033,0)))
arc((),start:180deg,stop:90deg,radius:(0.17,0.215))
arc((),start:90deg,stop:180deg,radius:(0.075,0.18))
   })
   merge-path(fill:hair-color-values.at(3),stroke:none, {
line((rel:(0,-0.1),to:"body.head-top"),(rel:(0.025,0)))
arc((),start:180deg,stop:90deg,radius:(0.125,0.175))
arc((),start:90deg,stop:180deg,radius:(0.035,0.125))
   })
   merge-path(fill:hair-color-values.at(4),stroke:none, {
line((rel:(0,-0.1),to:"body.head-top"),(rel:(0.044,0)))
arc((),start:180deg,stop:90deg,radius:(0.125,0.135))
arc((),start:90deg,stop:180deg,radius:(0.035,0.075))
   })
})

//FEET

on-layer(-1,{
  group(name:"left-foot",{
   group(name:"first-toe",{
      anchor("left-foot-first",(rel:(-0.5*penguin-foot-single-height,0),to:"body.foot-left",))
      rotate( 19deg,origin:"left-foot-first")
      circle(fill:left-foot-color-value,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"left-foot-first")
    })
   group(name:"second-toe",{
      rotate(penguin-basic-feet-bend,origin:"body.foot-left")
      circle(fill:left-foot-color-value,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"body.foot-left")
    })
   group(name:"third-toe",{
      anchor("left-foot-third",(rel:(0.5*penguin-foot-single-height,0),to:"body.foot-left",))
      rotate(penguin-basic-feet-bend + 25deg,origin:"left-foot-third")
      circle(fill:left-foot-color-value,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"left-foot-third")
    })
  })
  group(name:"right-foot",{
   group(name:"first-toe",{
      anchor("right-foot-first",(rel:(-0.5*penguin-foot-single-height,0),to:"body.foot-right",))
      rotate(- penguin-basic-feet-bend - 25deg,origin:"right-foot-first")
      circle(fill:right-foot-color-value,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"right-foot-first")
    })
   group(name:"second-toe",{
      rotate(- penguin-basic-feet-bend,origin:"body.foot-right")
      circle(fill:right-foot-color-value,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"body.foot-right")
    })
   group(name:"third-toe",{
      anchor("right-foot-third",(rel:(0.5*penguin-foot-single-height,0),to:"body.foot-right",))
      rotate(- penguin-basic-feet-bend + 25deg,origin:"right-foot-third")
      circle(fill:right-foot-color-value,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"right-foot-third")
    })
  })
})

//BILL

  group(name:"bill",{
   merge-path(fill:bill-color-value,stroke:none, {
   anchor("base",(rel:(0,- penguin-outer-offset -0.005),to: "body.head-center"))
   line("base",(rel:(-0.19,0)))
   arc((),start:180deg,stop:360deg,radius:(0.19,0.225),name:"bill-bottom")
   line((),(rel:(-0.02,0.005)))
   arc-through((),(rel:(0,0.02),to:"base"),(rel:(-0.17,0.005),to:"base"))
   line((),(rel:(-0.19,0),to:"base"))
   anchor("bottom","bill-bottom.mid")
   })
  })




  // anchor-coords("wings.right-start")
  // anchor-coords("wings.right-wing-tip")
  // anchor-coords("wings.right-wing")
  // anchor-coords("wings.left-start")
  // anchor-coords("wings.left-wing-tip")
  // anchor-coords("wings.left-wing")
  // anchor-coords("body.wings-side-left")
  // anchor-coords("body.wings-side-right")
  // anchor-coords("body.right.end")
  // anchor-coords("body.waist-right-middle")
  // anchor-coords("body.waist-right")
  // anchor-coords("body.foot-right")
  // anchor-coords("body.bottom-center")
  // anchor-coords("body.foot-left")
  // anchor-coords("body.left.start")
  // anchor-coords("body.left.end")
  // anchor-coords("body.head-center")
  // anchor-coords("bill.base")
  // anchor-coords("bill.bottom")
  // anchor-coords("body.head-top")
  // anchor-coords("body.head-topright")
  // anchor-coords("body.head-topleft")
  // anchor-coords("body.belly-back")
  // anchor-coords("body.belly-test")
  // anchor-coords("body.belly-left")
  // anchor-coords("body.eye-back-left")
  // anchor-coords("left-eye.eye-left")
  // anchor-coords("body.eye-back-right")
  // anchor-coords("body.head-back-con-left")
  // anchor-coords("body.head-back-con-right")

}

#let penguin(width:2.4702cm,..style)= {
  let unit-width = width/2.4702 //The total width of the base penguin
cetz.canvas(length:unit-width,{
   penguinInternal(..style)
})
}
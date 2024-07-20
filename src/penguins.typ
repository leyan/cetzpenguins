#import "@preview/cetz:0.2.2"
#import cetz.draw: *

#let test="test PAU"

#let round(a) = a.map(v => calc.round(v,digits:4))

#let anchor-coords(anchor-name) = {
  get-ctx(ctx => {
    let (ctx,a) = cetz.coordinate.resolve(ctx,anchor-name)
    let(x,y,z)=a
    circle((x,y),fill:red,stroke:none,radius:0.2mm)
    line(stroke:0.2pt+red,anchor-name,(rel:(-0.1,0.1),to:anchor-name))
    content((rel:(0.1,0.1),to:anchor-name), text(2pt,[#anchor-name: #round(a)]))
  })
}


#let penguinInternal()= {

  let penguin-blue = rgb(3,14,29)
  let penguin-yellow = rgb(252,187,21)
  let penguin-white = rgb(248,248,248)

  let body-color = penguin-blue
  let head-color = penguin-blue
  let left-eye-color = penguin-blue
  let right-eye-color = penguin-blue
  let right-wing-color = penguin-blue
  let left-wing-color = penguin-blue
  let belly-color = penguin-white
  let hair-color = (penguin-blue,penguin-blue,penguin-blue,penguin-blue,penguin-blue)
  let left-foot-color = penguin-yellow
  let right-foot-color = penguin-yellow
  let bill-color = penguin-yellow

  let penguin-half-width = 0.9375cm //\pingu@w@half
  let penguin-half-height = 1.275cm // \pingu@side@h@half
  let penguin-head-half-height = 0.9 * penguin-half-width // \pingu@head@h@half
  let penguin-bend = 0.125cm //\pingu@bend
  let penguin-white-offset = 0.1cm
  let penguin-lower-offset = 0.25cm //\pingu@lower@off
  let penguin-outer-offset = 0.25cm //\pingu@outer@off
  let penguin-foot-outer-width = 4.5mm //\pingu@foot@outer@w
  let penguin-foot-outer-height = 0.25cm //\pingu@foot@outer@h
  let penguin-foot-inner-width = 0.55cm //\pingu@foot@inner@w
  let penguin-foot-inner-height = 0.115cm //\pingu@foot@inner@h
  let penguin-foot-single-width = 0.105cm //\pingu@foot@single@w
  let penguin-foot-single-height = 2mm //\pingu@foot@single@h
  let penguin-basic-feet-bend = 45deg
  
  let penguin-side-half-size = 1.275cm //\\pingu@side@h@half
  let penguin-head-connection-x-offset = 0.39375cm // .75*.525cm \pingu@headcon@x
  let penguin-head-connection-y-offset = 0.46735cm // .719*.65cm \pingu@headcon@y
  let penguin-angle-head-left = 7deg
  let penguin-angle-head-right = 93deg
  let penguin-eye-shift = 0.8mm//\pingu@eye@shift


group(name:"body",{

  // BODY OUTLINE
//  arc-through((0,penguin-outer-offset),(rel:(-0.0277,(- penguin-half-height - penguin-outer-offset)/2)),(rel:(0.0277, (- penguin-half-height - penguin-outer-offset)/2 )),    name:"right")
   merge-path(fill:body-color,stroke:none, {
  arc-through((0,penguin-outer-offset),(rel:(-0.0283cm,-penguin-outer-offset -0.5125cm),update:false),(0,- penguin-side-half-size ),    name:"right")
  arc((),start: 180deg, stop: 270deg,radius:(penguin-foot-outer-width,penguin-foot-outer-height),name:"waist-to-foot-rigth")
  arc((),start: 270deg, stop: 332deg,radius:(penguin-foot-inner-width,penguin-foot-inner-height),name:"foot-inner-rigth")
  arc((),start: 208deg, stop: 270deg,radius:(penguin-foot-inner-width,penguin-foot-inner-height),name:"foot-inner-left")
  arc((),start: 270deg, stop: 360deg,radius:(penguin-foot-outer-width,penguin-foot-outer-height),name:"waist-to-foot-left")
  arc-through((),(rel:(0.0283cm,penguin-outer-offset+0.5125cm),update:false),(rel:(0,penguin-side-half-size + penguin-outer-offset)),    name:"left")
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
  circle(fill:head-color,stroke:none,"head-center",radius:(penguin-half-width,penguin-head-half-height),name: "head")
  //arc((),start: 90deg, stop: 450deg,radius:(penguin-half-width,penguin-head-half-height))
    anchor("head-top","head.north")
    anchor("head-topleft","head.7.3%")
    anchor("head-topright","head.92.7%")

  // BELLY

   merge-path(fill:belly-color,stroke:none, {
  line(stroke:yellow,(penguin-half-width,-1),(rel:(-penguin-half-width+1mm,penguin-lower-offset)),name:"start-belly")
  line((),(rel:(0,1.05cm - penguin-side-half-size - penguin-outer-offset)),name:"belly-left")
  //arc-through((),(rel:(-0.01,(1.05cm - penguin-side-half-size - penguin-outer-offset)/2),update:false),(rel:(0,1.05cm - penguin-side-half-size - penguin-outer-offset)),name:"belly-left")
  arc((),start: 180deg, stop: 270deg,radius:(4mm,2mm))
  arc((),start: 270deg, stop: 331deg,radius:(5mm,0.85mm))
  arc((),start: 207deg, stop: 270deg,radius:(5mm,0.85mm))
  arc((),start: 270deg, stop: 360deg,radius:(4mm,2mm))
  line((),(rel:(0,-1.05cm + penguin-side-half-size + penguin-outer-offset)))
  arc((),start:0deg,stop:180deg,radius:(penguin-half-width - 0.96mm,penguin-half-width - 1mm))
   })
    anchor("belly-back","start-belly.start")
    anchor("belly-test","start-belly.end")
    anchor("belly-left","belly-left.end")
    anchor("eye-back-left",(rel:(0.275cm,0.25cm - penguin-outer-offset),to:"head-center"))
    anchor("eye-back-right",(rel:(-0.275cm,0.25cm - penguin-outer-offset),to:"head-center"))
    anchor("head-back-con-left",(rel:(penguin-head-connection-x-offset, -penguin-head-connection-y-offset),to:"eye-back-left"))
    anchor("head-back-con-right",(rel:(-penguin-head-connection-x-offset, -penguin-head-connection-y-offset),to:"eye-back-right"))

//FACE SHAPE

circle(fill:belly-color,stroke:none,(rel:(0, - 0.25mm),to:"eye-back-right"),radius:(0.525cm,0.625cm),name:"face-right")
circle(fill:belly-color,stroke:none,(rel:(0, - 0.25mm),to:"eye-back-left"),radius:(0.525cm,0.625cm),name:"face-left")

})

//EYES

group(name:"eyes",{
circle(fill:left-eye-color,stroke:none,(rel:(penguin-eye-shift,0.75mm),to:"body.eye-back-left"),radius:(0.1225cm,0.1365cm))
circle(fill:right-eye-color,stroke:none,(rel:(-penguin-eye-shift,0.75mm),to:"body.eye-back-right"),radius:(0.1225cm,0.1365cm))

})

//WINGS

on-layer(-1,{
  group(name:"wings",{
  anchor("left-start",(rel:(0,-6.5mm),to:"body.wings-side-left"))
  anchor("right-start",(rel:(0,-6.5mm),to:"body.wings-side-right"))

  rotate(15deg,origin:"right-start")
  circle(fill:left-wing-color,stroke:none,radius:(0.195cm,9mm),"left-start",name:"left-wing")
  circle(fill:none,stroke:none,radius:(0.145cm,7.5mm),"left-start",name:"left-wing-internal")
  anchor("left-wing-tip","left-wing.south")
  anchor("left-wing","left-wing-internal.south")
  rotate(-15deg,origin:"right-start")

  rotate(-15deg,origin:"right-start")
  circle(fill:right-wing-color,stroke:none,radius:(0.195cm,9mm),"right-start",name:"right-wing")
  circle(fill:none,stroke:none,radius:(0.145cm,7.5mm),"right-start",name:"right-wing-internal")
  anchor("right-wing-tip","right-wing.south")
  anchor("right-wing","right-wing-internal.south")
  rotate(15deg,origin:"right-start")
})
})

//HAIR


on-layer(-1,{
   merge-path(fill:hair-color.at(0),stroke:none, {
line((rel:(0,-1mm),to:"body.head-top"),(rel:(0.15mm,0)))
arc((),start:0deg,stop:90deg,radius:(0.125cm,0.135cm))
arc((),start:90deg,stop:0deg,radius:(0.35mm,0.75mm))
   })
   merge-path(fill:hair-color.at(1),stroke:none, {
line((rel:(0,-1mm),to:"body.head-top"),(rel:(0.33mm,0)))
arc((),start:0deg,stop:90deg,radius:(0.125cm,0.175cm))
arc((),start:90deg,stop:0deg,radius:(0.35mm,1mm))
   })
   merge-path(fill:hair-color.at(2),stroke:none, {
line((rel:(0,-1mm),to:"body.head-top"),(rel:(-0.33mm,0)))
arc((),start:180deg,stop:90deg,radius:(0.17cm,0.215cm))
arc((),start:90deg,stop:180deg,radius:(0.75mm,0.18cm))
   })
   merge-path(fill:hair-color.at(3),stroke:none, {
line((rel:(0,-1mm),to:"body.head-top"),(rel:(0.25mm,0)))
arc((),start:180deg,stop:90deg,radius:(0.125cm,0.175cm))
arc((),start:90deg,stop:180deg,radius:(0.35mm,0.125cm))
   })
   merge-path(fill:hair-color.at(4),stroke:none, {
line((rel:(0,-1mm),to:"body.head-top"),(rel:(0.44mm,0)))
arc((),start:180deg,stop:90deg,radius:(0.125cm,0.135cm))
arc((),start:90deg,stop:180deg,radius:(0.35mm,0.75mm))
   })
})

//FEET

on-layer(-1,{
  group(name:"left-foot",{
   group(name:"first-toe",{
      anchor("left-foot-first",(rel:(-0.5*penguin-foot-single-height,0),to:"body.foot-left",))
      rotate(penguin-basic-feet-bend - 25deg,origin:"left-foot-first")
      circle(fill:left-foot-color,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"left-foot-first")
    })
   group(name:"second-toe",{
      rotate(penguin-basic-feet-bend,origin:"body.foot-left")
      circle(fill:left-foot-color,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"body.foot-left")
    })
   group(name:"third-toe",{
      anchor("left-foot-third",(rel:(0.5*penguin-foot-single-height,0),to:"body.foot-left",))
      rotate(penguin-basic-feet-bend + 25deg,origin:"left-foot-third")
      circle(fill:left-foot-color,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"left-foot-third")
    })
  })
  group(name:"right-foot",{
   group(name:"first-toe",{
      anchor("right-foot-first",(rel:(-0.5*penguin-foot-single-height,0),to:"body.foot-right",))
      rotate(- penguin-basic-feet-bend - 25deg,origin:"right-foot-first")
      circle(fill:right-foot-color,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"right-foot-first")
    })
   group(name:"second-toe",{
      rotate(- penguin-basic-feet-bend,origin:"body.foot-right")
      circle(fill:right-foot-color,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"body.foot-right")
    })
   group(name:"third-toe",{
      anchor("right-foot-third",(rel:(0.5*penguin-foot-single-height,0),to:"body.foot-right",))
      rotate(- penguin-basic-feet-bend + 25deg,origin:"right-foot-third")
      circle(fill:right-foot-color,stroke:none,radius:(penguin-foot-single-width,penguin-foot-single-height),"right-foot-third")
    })
  })
})

//BILL

  group(name:"bill",{
   merge-path(fill:bill-color,stroke:none, {
   anchor("base",(rel:(0,- penguin-outer-offset -0.05mm),to: "body.head-center"))
   line("base",(rel:(-0.19cm,0)))
   arc((),start:180deg,stop:360deg,radius:(0.19cm,0.225cm),name:"bill-bottom")
   line((),(rel:(-0.2mm,0.05mm)))
   //line((),(rel:(-0.17cm,0.05mm),to:"base"))
   arc-through((),(rel:(0,0.2mm),to:"base"),(rel:(-0.17cm,0.05mm),to:"base"))
   line((),(rel:(-0.19cm,0),to:"base"))
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
//   anchor-coords("body.right.end")
//   anchor-coords("body.waist-right-middle")
//   anchor-coords("body.waist-right")
//   anchor-coords("body.foot-right")
//   anchor-coords("body.bottom-center")
//   anchor-coords("body.foot-left")
//   //anchor-coords("body.left.start")
//   //anchor-coords("body.left.end")
//  anchor-coords("body.head-center")
//  anchor-coords("bill.base")
//  anchor-coords("bill.bottom")
//   anchor-coords("body.head-top")
//   anchor-coords("body.head-topright")
//   anchor-coords("body.head-topleft")
//   anchor-coords("body.belly-back")
//   anchor-coords("body.belly-test")
//   anchor-coords("body.belly-left")
//   anchor-coords("body.eye-back-left")
// //  anchor-coords("body.eye-back-right")
//   anchor-coords("body.head-back-con-left")
//   anchor-coords("body.head-back-con-right")

}

#let penguin()= {
cetz.canvas({
   penguinInternal()
})
}
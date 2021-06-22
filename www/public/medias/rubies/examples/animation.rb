# animation example

b = box()
b.y(300)
b.x(400)
text({content: "touch the box or the circle!!", x: 450, y: 250, color: :lightgray, width: :auto})
b.touch do
  animate({
            start: { smooth: 0, blur: 0, rotate: 0, color: { red: 1, green: 1, blue: 1 } },
            end: { smooth: 25, rotate: 180, blur: 20, color: { red: 1, green: 0, blue: 0 } },
            duration: 1000,
            loop: 1,
            curve: :easing,
            target: b.atome_id
          })
end
animate({
          start: { x: 0, y: 0, smooth: 0, rotate: 20 },
          end: { x: 400, y: 70, smooth: 25, rotate: 180 },
          duration: 2000,
          loop: 3,
          curve: :easing,
          target: b.atome_id
        })


c=circle({color: :black, center: true})
moto=image({content: :moto, size: 96, y: 96, x: 96, drag: true})


c.touch do
  size=96
  animate({
            start: {  shadow: { x: 0, y: size / 15, thickness: 0, blur: size / 3, color: { red: 0, green: 0, blue: 0, alpha: 0.3 } }},
            end: {  shadow: { x: 10, y: -size / 15, thickness: 3, blur: size / 3, color: { red: 1, green: 0, blue: 0, alpha: 0.7 } }},
            duration: 1000,
            loop: 1,
            curve: :easing,
            target: c.atome_id
          })

  animate({
            start: {  shadow: { x: 0, y: size / 15, thickness: 0, blur: size / 3, color: { red: 0, green: 0, blue: 0, alpha: 0.3 } }},
            end: {  shadow: { x: 10, y: -size / 15, thickness: 3, blur: size / 3, color: { red: 1, green: 1, blue: 1, alpha: 1 } }},
            duration: 1000,
            loop: 1,
            curve: :easing,
            target: moto.atome_id
          })


end

# animation example

b = box()
b.y(300)
b.x(400)
text({ content: "touch the box!!", x: 450, y: 250, size: 16, color: :lightgray })
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

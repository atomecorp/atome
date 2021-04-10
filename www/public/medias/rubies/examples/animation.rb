b=box()
b.y(300)
b.x(400)
text({content: "touch the box!!", x: 450, y: 250, size: 16, color: :lightgray})
b.touch do
  anim({
           start: { smooth: 0, blur: 0,  rotate: 0, color: "rgb(255,255,255)"},
           end: { smooth: 25, rotate: 180, blur: 20, color: "rgb(255,10,10)"},
           duration: 1000,
           loop: 1,
           curve: :easing,
           target: b.id
       })
end
anim({
         start: {x: 0, y: 0, smooth: 0, rotate: 20},
         end: {x: 400, y: 70, smooth: 25, rotate: 180},
         duration: 2000,
         loop: 3,
         curve: :easing,
         target: b.id
     })

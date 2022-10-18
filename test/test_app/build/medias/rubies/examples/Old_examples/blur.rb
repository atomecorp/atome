# blur example

t=text({content: "drag the circle over elements on screen"})
i=image({content: :boat, x:96, y:96})
box({smooth: 6, x:133,y: 133, color: :orange, blur: 3, drag: true})
circle({blur: {value: 9, invert: true}, size: 96,x:96,y: 33, color: {alpha: 0.1, red: 1, green:1, blue: 1}, drag: true, shadow: {color: :black, thickness: 2, x: 0, y: 0, blur: 15}})
i.drag do |evt|
  i.blur(evt.offset_x/66)
end

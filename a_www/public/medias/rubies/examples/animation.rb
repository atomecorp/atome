# animation example
wait 1 do
  i = image({ color: { green: 1, alpha: 0.3 }, content: :boat, atome_id: :the_boat })
  i.color({ red: 1, alpha: 0.3 })
  i.noise({ opacity: 0.6 })

  wait 2 do
    i.animation({
                  start: { smooth: 0, blur: 0, rotate: 33, color: { red: 0, green: 1, blue: 0, alpha: 0.2 } },
                  end: { smooth: 25, rotate: 180, blur: 20, color: { red: 1, green: 0, blue: 0 } },
                  duration: 1000,
                  loop: 15,
                  curve: :easing,
                  target: i.atome_id
                })
  end

  b = box()
  b.y(300)
  b.x(400)
  text({ content: "touch the box or the circle!!", x: 450, y: 250, color: :lightgray, width: :auto })
  b.touch do
    animation({
                start: { smooth: 0, blur: 0, rotate: 0, color: { red: 1, green: 1, blue: 1 } },
                end: { smooth: 25, rotate: 180, blur: 20, color: { red: 1, green: 0, blue: 0 } },
                duration: 1000,
                loop: 1,
                curve: :easing,
                target: b.atome_id
              })
  end
  animation({
              start: { x: 0, y: 0, smooth: 0, rotate: 20 },
              end: { x: 400, y: 70, smooth: 25, rotate: 180 },
              duration: 2000,
              loop: 3,
              curve: :easing,
              target: b.atome_id
            })

  c = circle({ color: :black, center: true })
  moto = image({ content: :moto, size: 130, y: 130, x: 96, drag: true, color: { green: 1, alpha: 0.6 } })

  moto.touch do
    animation({
                start: { smooth: 0, blur: 0, rotate: 33, color: { red: 0, green: 1, blue: 0, alpha: 0.2 } },
                end: { smooth: 25, rotate: 180, blur: 20, color: { red: 1, green: 0, blue: 0 } },
                duration: 1000,
                loop: 15,
                curve: :easing,
                target: moto.atome_id
              })
  end

  c.touch do
    size = 96
    animation({
                start: { shadow: { x: 0, y: size / 15, thickness: 0, blur: size / 3, color: { red: 0, green: 0, blue: 0, alpha: 0.3 } } },
                end: { shadow: { x: 10, y: -size / 15, thickness: 3, blur: size / 3, color: { red: 1, green: 0, blue: 0, alpha: 0.7 } } },
                duration: 1000,
                loop: 1,
                curve: :easing,
                target: c.atome_id
              })

    animation({
                start: { shadow: { x: 0, y: size / 15, blur: size / 3, color: { red: 0, green: 0, blue: 0, alpha: 0.3 } } },
                end: { shadow: { x: 10, y: -size / 15, blur: size / 3, color: { red: 1, green: 1, blue: 1, alpha: 1 } } },
                duration: 1000,
                loop: 1,
                curve: :easing,
                target: moto.atome_id
              })

  end

  title = text({ content: "animated gradient", visual: 66 })

  title.animation({
                    # start: {  color: { red: 1, green: 1, blue: 1 } },
                    # end: {  color: { red: 1, green: 0, blue: 0 } },
                    start: { color: [{ red: 1, green: 0.2, blue: 1, alpha: 0.3 }, { red: 0, green: 0.2, blue: 1, alpha: 0.3 }] },
                    end: { color: [{ red: 1, green: 0, blue: 0, alpha: 1 }, { red: 0, green: 1, blue: 0, alpha: 1 }] },
                    duration: 1000,
                    loop: 10,
                    curve: :easing,
                    target: title.atome_id
                  })

end

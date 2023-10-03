# fill example

back_try = box()
back_try.x(350)
back_try.size(490)
back_try.scale(true)
moto_text = back_try.image(:moto)
moto_text.visual(70)
back_try.color(:transparent)
moto_text.fill({ target: back_try, number: 7 })

# frozen_string_literal: true

b=circle({left: 333})
b.blur(6)

image(:red_planet)
b2=box({color: {alpha: 0.1, red: 1, green: 0, blue: 0.2}, left: 99, top: 99, width: 99, height: 99})
b2.drag(true)
b2.border({ thickness: 0.3, color: :gray, pattern: :solid })
b2.smooth(12)
b2.shadow({
            invert: true,
            id: :s4,
            left: 2, top: 2, blur: 9,
            # option: :natural,
            red: 0, green: 0, blue: 0, alpha: 0.3
          })

b2.shadow({
            # invert: true,
            id: :s5,
            left: 2, top: 2, blur: 9,
            # option: :natural,
            red: 0, green: 0, blue: 0, alpha: 0.6
          })
b2.blur({affect: :back, value: 15})

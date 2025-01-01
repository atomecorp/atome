# #  frozen_string_literal: true
#
matrix_zone = box({ width: 333, height: 333, drag: true, id: :the_box, color: {alpha: 0.4} })
#
# # matrix creation
main_matrix = matrix_zone.matrix({ id: :vie_0, rows: 8, columns: 8, spacing: 6, size: '100%' })
main_matrix.smooth(10)
main_matrix.color(:red)



# #######################################################@
matrix_to_treat = main_matrix.cells
matrix_to_treat.color(:blue)
matrix_to_treat.smooth(6)
matrix_to_treat.shadow({
                         id: :s1,
                         left: 3, top: 3, blur: 6,
                         invert: false,
                         red: 0, green: 0, blue: 0, alpha: 0.6
                       })
# ###################
col_1 = color(:yellow)
col_2 = color({ red: 1, id: :red_col })

wait 3 do
  matrix_to_treat.paint({ gradient: [col_1.id, col_2.id], direction: :top })
end
#
# ###################

test_cell = grab(:vie_0_2_3)
wait 1 do
  test_cell.color(:red)
  test_cell.text('touch')
  grab(:vie_0_background).color(:red)
end


c= circle({left: 399})
test_cell.touch(true) do
  test_cell.alternate({ width: 33, color: :red }, { width: 66, color: :orange })
  matrix_to_treat.paint({ gradient: [col_1.id, col_1.id], direction: :top })
  other_col=test_cell.color(:green)
  c.paint({ gradient: [col_1.id, col_2.id], direction: :left })
  test_cell.paint({ gradient: [col_1.id, other_col.id], direction: :left })
end

wait 1 do
  matrix_to_treat.width(33)
end
matrix_to_treat.drag(true)
# alert matrix_to_treat.id
wait 2 do
  grab(:vie_0_background).left(250)
  grab(:vie_0_background).drag(true)
end
matrix_to_treat.touch(:down) do |event|
  # alert el.inspect
  current_cell= grab(event[:target][:id].to_s)
  current_cell.color(:blue)
  current_cell.selected(true)
end
matrix_to_treat.smooth(9)
main_matrix.color(:red)
matrix_to_treat.color(:yellow)
wait 5 do
  main_matrix.resize_matrix({width: 555, height: 555})
end

wait 7 do
main_matrix.display(false)
  wait 1 do
    main_matrix.display(true)
    wait 1 do
      main_matrix.delete(true)
      wait 1 do
        main_matrix = matrix_zone.matrix({ id: :vie_0, rows: 8, columns: 8, spacing: 6, size: '100%' })
      end
    end
  #   main_matrix.color(:red)
  end
end

# b=box
# b.circle
# b.delete(true)


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "4",
    "6",
    "alternate",
    "cells",
    "circle",
    "color",
    "delete",
    "display",
    "drag",
    "id",
    "inspect",
    "matrix",
    "paint",
    "resize_matrix",
    "selected",
    "shadow",
    "smooth",
    "text",
    "touch",
    "width"
  ],
  "4": {
    "aim": "The `4` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `4`."
  },
  "6": {
    "aim": "The `6` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `6`."
  },
  "alternate": {
    "aim": "The `alternate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `alternate`."
  },
  "cells": {
    "aim": "The `cells` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `cells`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "display": {
    "aim": "The `display` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `display`."
  },
  "drag": {
    "aim": "The `drag` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `drag`."
  },
  "id": {
    "aim": "The `id` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `id`."
  },
  "inspect": {
    "aim": "The `inspect` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `inspect`."
  },
  "matrix": {
    "aim": "The `matrix` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `matrix`."
  },
  "paint": {
    "aim": "The `paint` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `paint`."
  },
  "resize_matrix": {
    "aim": "The `resize_matrix` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `resize_matrix`."
  },
  "selected": {
    "aim": "The `selected` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `selected`."
  },
  "shadow": {
    "aim": "The `shadow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shadow`."
  },
  "smooth": {
    "aim": "Applies smooth transitions or rounded edges to an object.",
    "usage": "Use `smooth(20)` to apply a smooth transition or corner rounding of 20 pixels."
  },
  "text": {
    "aim": "The `text` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `text`."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end

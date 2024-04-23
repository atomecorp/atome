#  frozen_string_literal: true

matrix_zone=box({width: 333, height: 333, drag: true, id: :the_box})

# matrix creation
main_matrix = matrix_zone.matrix({ id: :vie_0, rows: 8, columns: 8, spacing: 6, size: '100%' })
main_matrix.smooth(3)
main_matrix.color(:red)

# on resize
def resize_matrix(current_matrix, new_width, new_height, spacing, size)
  parent_found = current_matrix
  if size.instance_of? String
    size_coefficient = size.end_with?('%') ? (size.to_f / 100) : size.to_f / parent_found.to_px(:width)
    matrix_back = grab(:vie_0_background)
    spacing = spacing * size_coefficient
    total_spacing_x = spacing * (current_matrix.collect.length ** (0.5) + 1)
    total_spacing_y = spacing * (current_matrix.collect.length ** (0.5) + 1)

    if new_width > new_height
      full_size = new_height * size_coefficient
      available_width = full_size - total_spacing_x
      available_height = full_size - total_spacing_y
      matrix_back.width(full_size)
      matrix_back.height(full_size)
    else
      full_size = new_width * size_coefficient
      available_width = full_size - total_spacing_x
      available_height = full_size - total_spacing_y
      matrix_back.width(full_size)
      matrix_back.height(full_size)
    end

    box_width = available_width / current_matrix.collect.length ** (0.5)
    box_height = available_height / current_matrix.collect.length ** (0.5)
    current_matrix.collect.each_with_index do |box_id, index|
      box = grab(box_id)
      box.width(box_width)
      box.height(box_height)
      box.left((box_width + spacing) * (index % current_matrix.collect.length ** (0.5)) + spacing)
      box.top((box_height + spacing) * (index / current_matrix.collect.length ** (0.5)).floor + spacing)
    end
  else
    # dunno if we have to resize if size is specified in px
    # size.to_f / parent_found.to_px(:width)
  end

end

grab(:view).on(:resize) do
  matrix_parent = grab(:view)
  new_width = matrix_parent.width
  new_height = matrix_parent.height
  unless new_width.instance_of?(Numeric)
    new_width = matrix_parent.to_px(:width)
  end
  unless new_height.instance_of?(Numeric)
    new_height = matrix_parent.to_px(:height)
  end
  new_size = if new_height > new_width
               new_width
             else
               new_height
             end
  ratio = new_size / grab(:vie_0_background).width.to_f
  main_matrix.data[:spacing] = main_matrix.data[:spacing] * ratio
  matrix_spacing = main_matrix.data[:spacing]
  matrix_size = main_matrix.data[:size]
  resize_matrix(main_matrix, new_width, new_height, matrix_spacing, matrix_size)
end

matrix_to_treat=main_matrix

#######################################################@
matrix_to_treat.color(:blue)
matrix_to_treat.smooth(6)
matrix_to_treat.shadow({
                         id: :s1,
                         left: 3, top: 3, blur: 6,
                         invert: false,
                         red: 0, green: 0, blue: 0, alpha: 0.6
                       })
###################
col_1 = color(:yellow)
col_2 = color({ red: 1, id: :red_col })

wait 3 do
matrix_to_treat.paint({ gradient: [col_1.id, col_2.id], direction: :top })
end

###################

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

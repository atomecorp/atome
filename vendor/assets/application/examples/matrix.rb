#  frozen_string_literal: true

# current_matrix = ""

# id=params[:id]
# rows=params[:rows]
# columns=params[:columns]
# spacing=params[:spacing]
# size=params[:size]
b=box({width: 333, height: 333, drag: true, id: :the_box})
matrix_to_treat=b.matrix({id: :vie_0, rows: 8, columns: 8, spacing: 9, size: '70%', left: 123 })

def resize_matrix(current_matrix, new_width, new_height, spacing, size)
  # matrix_group = grab(matrix_id)
  total_spacing_x = spacing * (current_matrix.collect.length ** (0.5) + 1)
  total_spacing_y = spacing * (current_matrix.collect.length ** (0.5) + 1)
  size_coefficient = size.end_with?('%') ? (size.to_f / 100) : size.to_f / new_width

  if new_width > new_height
    available_width = (new_height * size_coefficient) - total_spacing_x
    available_height = (new_height * size_coefficient) - total_spacing_y
  else
    available_width = (new_width * size_coefficient) - total_spacing_x
    available_height = (new_width * size_coefficient) - total_spacing_y
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
end

grab(:view).on(:resize) do |event|
  new_event = Native(event)
  new_width = new_event[:width].to_f
  new_height = new_event[:height].to_f
  matrix_spacing = matrix_to_treat.data[:spacing]
  matrix_size = matrix_to_treat.data[:size]
  resize_matrix(matrix_to_treat, new_width, new_height, matrix_spacing, matrix_size)
end
# alert grab(:vie_0).data
# wait 2 do

matrix_to_treat.color(:blue)
matrix_to_treat.smooth(6)
matrix_to_treat.shadow({
                         id: :s1,
                         # affect: [:the_circle],
                         left: 3, top: 3, blur: 6,
                         invert: false,
                         red: 0, green: 0, blue: 0, alpha: 0.6
                       })
###################
col_1 = color(:yellow)
col_2 = color({ red: 1, id: :red_col })


# matrix_to_treat.paint({ gradient: [col_1.id, col_2.id], direction: :left })
matrix_to_treat.paint({ gradient: [col_1.id, col_2.id], direction: :top })


###################


test_cell = grab(:vie_0_2_3)
wait 1 do
  test_cell.color(:red)
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

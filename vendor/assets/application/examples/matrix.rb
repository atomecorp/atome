#  frozen_string_literal: true

@current_matrix = ""

def matrix(id, horizontal_nb, vertical_nb, spacing, size)
  view = grab(:view)
  @current_matrix = group({ id: id })
  @current_matrix.data({ spacing: spacing, size: size })
  matrix_cells = []
  total_spacing_x = spacing * (horizontal_nb + 1)
  total_spacing_y = spacing * (vertical_nb + 1)
  size_coefficient = size.end_with?('%') ? (size.to_f / 100) : size.to_f / view.to_px(:width)

  view_width = view.to_px(:width)
  view_height = view.to_px(:height)
  if view_width > view_height
    available_width = (view_height * size_coefficient) - total_spacing_x
    available_height = (view_height * size_coefficient) - total_spacing_y
  else
    available_width = (view_width * size_coefficient) - total_spacing_x
    available_height = (view_width * size_coefficient) - total_spacing_y
  end
  box_width = available_width / horizontal_nb
  box_height = available_height / vertical_nb
  background=box({id: :background, width: 666, height: 666, color:{alpha: 0}})
  vertical_nb.times do |y|
    horizontal_nb.times do |x|
      id_generated = "#{id}_#{x}_#{y}"
      matrix_cells << id_generated
      new_box = background.box({ id: id_generated })
      new_box.width(box_width)
      new_box.height(box_height)
      new_box.left((box_width + spacing) * x + spacing)
      new_box.top((box_height + spacing) * y + spacing)
    end
  end
  @current_matrix.collect(matrix_cells)
end

matrix(:vie_0, 8, 8, 9, '69%')

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
  matrix_spacing = @current_matrix.data[:spacing]
  matrix_size = @current_matrix.data[:size]
  resize_matrix(@current_matrix, new_width, new_height, matrix_spacing, matrix_size)
end
# alert grab(:vie_0).data
# wait 2 do

@current_matrix.color(:blue)
@current_matrix.smooth(6)
@current_matrix.shadow({
                         id: :s1,
                         # affect: [:the_circle],
                         left: 3, top: 3, blur: 6,
                         invert: false,
                         red: 0, green: 0, blue: 0, alpha: 0.6
                       })
###################
col_1 = color(:yellow)
col_2 = color({ red: 1, id: :red_col })


# @current_matrix.paint({ gradient: [col_1.id, col_2.id], direction: :left })
@current_matrix.paint({ gradient: [col_1.id, col_2.id], direction: :top })


###################


test_cell = grab(:vie_0_2_3)
wait 1 do
  test_cell.color(:red)
end


module Molecule

  def states(val = nil)
    if val
    else
    end

  end


  def alternate(states = nil)
    if states

    else
      @alternate
    end

  end
end
c= circle({left: 399})
test_cell.touch(true) do
  test_cell.alternate([{ width: 33, color: :red }, { width: 66, color: :orange }])
  # puts "=> #{Universe.atomes.length}"
  # puts test_cell.color
  # if test_cell.data==true
  #   test_cell.data(false)
  # col_1 = color(:black)

  @current_matrix.paint({ gradient: [col_1.id, col_1.id], direction: :top })
  other_col=test_cell.color(:white)
  c.paint({ gradient: [col_1, col_2], direction: :left })
  test_cell.paint({ gradient: [col_1, other_col], direction: :left })
  # test_cell
  # grab(:red_col).delete(true)
  # test_cell.color(:green)
  # else
  #   test_cell.data(true)
  #   test_cell.color(:blue)
  # end

end
wait 1 do
  @current_matrix.width(33)
end
@current_matrix.drag(true)
wait 2 do
  grab(:background).left(666)
  grab(:background).drag(true)
end

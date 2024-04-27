# #  frozen_string_literal: true
#
matrix_zone = box({ width: 333, height: 333, drag: true, id: :the_box })
#
# # matrix creation
main_matrix = matrix_zone.matrix({ id: :vie_0, rows: 8, columns: 8, spacing: 6, size: '100%' })
main_matrix.smooth(3)
main_matrix.color(:red)

grab(:view).on(:resize) do

end
#
# matrix_to_treat=main_matrix
#
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
main_matrix.cells.smooth(9)
main_matrix.color(:red)
main_matrix.cells.color(:yellow)
wait 5 do
  main_matrix.resize_matrix({width: 555, height: 555})
end





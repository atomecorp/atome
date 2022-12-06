# frozen_string_literal: true

a = Matrix.new({ col: 1, row: 8, width: 120, height: 333, id: :vie_playground, name: :matrix_2, margin: 9,
                 matrix_style: { color: { red: 0.3, green: 0.3, blue: 0.6, alpha: 1 }, smooth: 20 },
                 cell_style: { color: { red: 0.333, green: 0.333, blue: 0.6, alpha: 1 }, smooth: 300, shadow: { blur: 6 }
                               #border: { color: :black, thickness: 0, pattern: :solid }
                 }
               })

######## tests

a.assign(2) do
  curent_cell = self
  curent_cell.image({ path: "./medias/images/moto.png", width: 33, height: 33})
  curent_cell.active(:inactive)
  touch(:long) do
    if curent_cell.active.value ==:inactive
      curent_cell.color(:yellow)
      curent_cell.active(:active)
    else
      curent_cell.color(:red)
      curent_cell.active(:inactive)
    end
  end
end

a.assign(3) do
  color({ red: 0.6, green: 0.333, blue: 0.6, alpha: 1 })
  grab(:vie_playground_3).shadow({ blur: 12 })
end


wait 2 do
  a.add({ columns: 3 })
end

# add row
# wait 4 do
#   a.add({ rows: 2 })
# end

# examples:

# add columns
#  a.add({ columns: 3 })

# add row
#   a.add({ rows: 2 })

# reformat
# a.reformat({rows: 4, cols: 2})

# resize matrix
# a.resize_matrix({ width: 666, height: 333 })

# crop matrix
# a.matrix.height(150)


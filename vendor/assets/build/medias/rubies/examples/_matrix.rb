# frozen_string_literal: true

a = Matrix.new({ col: 2, row: 8, width: 120, height: 333, id: :vie_playground, name: :matrix_2, margin: 9,
                 matrix_style: { color: { red: 0.3, green: 0.3, blue: 0.6, alpha: 1 }, smooth: 20 },
                 cell_style: { color: { red: 0.333, green: 0.333, blue: 0.6, alpha: 1 }, smooth: 20, shadow: { blur: 6 }
                               #border: { color: :black, thickness: 0, pattern: :solid }
                 }

               })
wait 2 do
  grab(:vie_playground_3).color({ red: 0.6, green: 0.333, blue: 0.6, alpha: 1 })
  grab(:vie_playground_3).shadow({ blur: 12 })
  a.width(222)
  puts a.name
  # a.delete
  wait 2 do
    a.resize_matrix({ width: 666, height: 333 })
  end
end

class Matrix
  def add(what)
    alert @cols
    # if what == :column
    # alert @matrix
    #   elsif what == :row
    # end
  end
end

a.add({column: 3})

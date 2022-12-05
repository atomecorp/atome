# frozen_string_literal: true

generator = Genesis.generator
generator.build_particle(:name)


class Matrix < Atome
  def initialize(params)
    default = { col: 4,row: 4, size: 666, margin: 99, name: nil, parent: :view }
    params = default.merge(params)
    nb_of_rows = params[:row]
    nb_of_cols = params[:col]
    matrix_size = params[:size]
    @matrix_margin = params[:margin]
    params[:name] = :matrix unless params[:name]
    params[:id] = :matrix unless params[:id]
    @matrix_id = params[:id]

    # Colors
    Atome.new({ color: { renderers: [:browser], id: :matrix_color, type: :color, parents: [], children: [],
                        red: 0, green: 1, blue: 1, alpha: 1 } })

    Atome.new({ color: { renderers: [:browser], id: :cell_color, type: :color, parents: [], children: [],
                         red: 1, green: 0.15, blue: 0.7, alpha: 1 } })

    # now we create the background
    @matrix= Atome.new(
      shape: { type: :shape, renderers: [:browser], id: @matrix_id, parents: [:view], children: [:matrix_color],
      }
    )

    @matrix_name = params[:name]
    @nb_of_rows = nb_of_rows
    @nb_of_cols = nb_of_cols
    @number_of_cells = @nb_of_rows * @nb_of_rows
    @cells =[]
    cell_number = 0
    while cell_number < @number_of_cells
      # now we create the cells
      @cells <<  Atome.new(
        shape: { type: :shape, renderers: [:browser], id: @matrix_id+ "_#{cell_number}", parents: [@matrix_id], children: [:cell_color],
        }
      )
      cell_number += 1
    end
    resize_matrix(matrix_size)

  end


  def width(val)
    # resize_matrix(val)
  end
  def height(val)
    # resize_matrix(val)
  end
  def left(val)
    @matrix.left(val)
  end
  def right(val)
    @matrix.right(val)
  end


  def resize_matrix(matrix_size)

      cell_size = if matrix_size.instance_of? String
                    (@matrix.convert(:width) / @nb_of_rows) - @matrix_margin
                  else
                    (matrix_size / @nb_of_rows) - @matrix_margin
                  end

        @matrix.width = matrix_size + @matrix_margin
        @matrix.height = matrix_size + @matrix_margin

      row = -1
    @cells.each_with_index do |cell, index|
        cell.height = cell_size
        cell.width = cell_size
        # below we resize background too
        if index.modulo(@nb_of_rows) == 0
          row += 1
        end
        cell.left(index % @nb_of_rows * (cell_size + @matrix_margin) + @matrix_margin)
        cell.top((row) * (cell_size + @matrix_margin) + @matrix_margin)
      end
  end

  def get_cell(id)
    grab(@matrix_name + "_" + id.to_s)
  end

  def delete
    @matrix.delete(true)
  end

  def cells
    @cells
  end


end

a=Matrix.new({ col: 2,row: 8, size: 333, background: nil,id: :vie_playground, name: :matrix_2, margin: 9, style: { color: { red: 1, green: 1, blue: 0, alpha: 0.3 }, smooth: 3, border: { color: :black, thickness: 0, pattern: :solid } } })
wait 2 do
  grab(:vie_playground_3).smooth(6).color(:black).red(0.3)
  # a.left(588)
  # a.width(222)
  # a.resize_matrix(122)
  # alert a.width.class
end

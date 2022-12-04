# frozen_string_literal: true

generator = Genesis.generator
# generator.build_particle(:cursor)
# generator.build_render_method(:browser_cursor) do |value|
#   @browser_object.style[:cursor] = value
# end

:crosshair
:pointer
b=box

b.cursor(:crosshair)

class Matrix < Atome
  def initialize(params)
    default = { nb: 4, size: 666, style: { color: :gray }, background: nil, margin: 99, name: nil, parent: :view }
    params = default.merge(params)
    nb_of_rows = params[:nb]
    matrix_size = params[:size]
    background = params[:background]
    matrix_parent = params[:parent]
    @matrix_margin = params[:margin]
    style = params[:style]
    params[:name] = :matrix unless params[:name]
    params[:id] = :matrix unless params[:id]
    background_color = params[:background_color]
    @matrix_id = params[:atome_id]
    @matrix = grab(matrix_parent).box({cursor: :default, overflow: :auto, color: background_color, atome_id: @matrix_id, name: params[:name] })
    @matrix_name = params[:name]
    @nb_of_rows = nb_of_rows
    @number_of_cells = @nb_of_rows * @nb_of_rows
    @cell_width = params[:cell_width]
    @cell_height = params[:cell_height]
    @matrix_background = background
    cell_number = 0
    while cell_number < @number_of_cells
      @matrix.box({cursor: :pointer, color: :red, atome_id: @matrix_name + "_#{cell_number}", overflow: :hidden }.merge(style))
      cell_number += 1
    end
    if background
      @matrix.child.each_with_index do |child, index|
        child.image({ content: background + "_#{index}" })
      end
    end
    resize_matrix(matrix_size)
  end


  def resize_matrix(matrix_size, only_content = false)
    if @cell_width || @cell_height
      @matrix.width = (@cell_width + @matrix_margin) * @nb_of_rows - @matrix_margin
      @matrix.height = (@cell_height + @matrix_margin) * @nb_of_rows - @matrix_margin
      row = -1
      @matrix.child.each_with_index do |cell, index|
        if index.modulo(@nb_of_rows) == 0
          row += 1
        end
        cell.width = @cell_width
        cell.height = @cell_height
        cell.x(index % @nb_of_rows * (@cell_width + @matrix_margin))
        cell.y((row) * (@cell_height + @matrix_margin))
      end
    else
      cell_size = if matrix_size.instance_of? String
                    (@matrix.convert(:width) / @nb_of_rows) - @matrix_margin
                  else
                    (matrix_size / @nb_of_rows) - @matrix_margin
                  end
      if only_content

      else
        @matrix.width = matrix_size + @matrix_margin
        @matrix.height = matrix_size + @matrix_margin
      end

      row = -1
      @matrix.child.each_with_index do |cell, index|
        cell.height = cell_size
        cell.width = cell_size
        #below we resize background too
        if @matrix_background
          cell.child.each do |background|
            if background
              background.x = background.y = 0
              background.width = background.height = cell_size
            end
          end
        end
        if index.modulo(@nb_of_rows) == 0
          row += 1
        end
        cell.x(index % @nb_of_rows * (cell_size + @matrix_margin) + @matrix_margin)
        cell.y((row) * (cell_size + @matrix_margin) + @matrix_margin)
      end

    end

  end


  def get_cell(atome_id)
    grab(@matrix_name + "_" + atome_id.to_s)
  end
  def delete
    @matrix.delete(true)
  end
  def cells
    @matrix.child
  end
end


#  Matrix.new({ nb: 4, size: 333,background: nil, name: :matrix_2, margin: 33, style: { color: { red: 1, green: 1, blue: 0, alpha: 0.3 }, smooth: 3,border: { color: :black, thickness: 0, pattern: :solid }} })

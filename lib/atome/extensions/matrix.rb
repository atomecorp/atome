# frozen_string_literal: true

# powerful and simple to use table and list generator
# class Matrix
#   def initialize(params)
#     default = { col: 4, row: 4, size: 333, margin: 12, name: :matrix, parent: :view }
#     params = default.merge(params)
#     nb_of_rows = params[:row]
#     nb_of_cols = params[:col]
#     matrix_width = params[:width]
#     matrix_height = params[:height]
#     @matrix_margin = params[:margin]
#     params[:id] = :matrix unless params[:id]
#     @matrix_id = params[:id]
#     @matrix_name = params[:name]
#     # Colors
#     Atome.new({ color: { renderers: [:browser], id: :matrix_color, type: :color, parents: [], children: [],
#                          red: 0, green: 1, blue: 1, alpha: 1 } })
#
#     Atome.new({ color: { renderers: [:browser], id: :cell_color, type: :color, parents: [], children: [],
#                          red: 1, green: 0.15, blue: 0.7, alpha: 1 } })
#
#     # now we create the background
#     @matrix = Atome.new(
#       shape: { type: :shape, renderers: [:browser], id: @matrix_id, parents: [:view], children: [:matrix_color],
#                name: @matrix_name }
#     )
#     @matrix.style(params[:matrix_style])
#
#     @nb_of_rows = nb_of_rows.to_i
#     @nb_of_cols = nb_of_cols.to_i
#     number_of_cells = @nb_of_rows * @nb_of_cols
#     @cells = []
#     cell_number = 0
#     while cell_number < number_of_cells
#       # now we create the cells
#       @cells << a = Atome.new(
#         shape: { type: :shape, renderers: [:browser], id: @matrix_id + "_#{cell_number}", parents: [@matrix_id],
#                  children: [:cell_color] }
#       )
#       a.style(params[:cell_style])
#       cell_number += 1
#     end
#     resize_matrix({ width: matrix_width, height: matrix_height })
#   end
#
#   def width(val = nil)
#     if val
#       resize_matrix({ height: height, width: val })
#     else
#       @matrix.width.value
#     end
#
#   end
#
#   def height(val = nil)
#     if val
#       resize_matrix({ width: width, height: val })
#     else
#       @matrix.height.value
#     end
#   end
#
#   def left(val)
#     @matrix.left(val)
#   end
#
#   def right(val)
#     @matrix.right(val)
#   end
#
#   def resize_matrix(params)
#     matrix_width = params[:width]
#     matrix_height = params[:height]
#     cell_width = (matrix_width / @nb_of_cols) - @matrix_margin
#     cell_height = (matrix_height / @nb_of_rows) - @matrix_margin
#     row = -1
#     @cells.each_with_index do |cell, index|
#       cell.height = cell_height
#       cell.width = cell_width
#       row += 1 if index.modulo(@nb_of_cols).zero?
#       cell.left(index % @nb_of_cols * (cell_width + @matrix_margin) + @matrix_margin)
#       cell.top(row * (cell_height + @matrix_margin) + @matrix_margin)
#     end
#
#     @matrix.width = matrix_width + @matrix_margin
#     @matrix.height = matrix_height + @matrix_margin
#   end
#
#   def get_cell(id)
#     grab("#{@matrix_id}_#{id}")
#   end
#
#   def delete
#     @matrix.delete(true)
#   end
#
#   attr_reader :cells
#
#   def name
#     @matrix.name
#   end
# end

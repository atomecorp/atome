# # frozen_string_literal: true
#
# # powerful and simple to use table and list generator
# class Matrix
#   attr_accessor :matrix
#
#   def create_matrix_back( id, style)
#     @matrix = Atome.new(
#       shape: { type: :shape, renderers: [:browser], id: id, parents: [:view], children: [:matrix_color],
#                overflow: :auto }
#     )
#     @matrix.style(style)
#   end
#
#   def create_matrix_colors
#     Atome.new({ color: { renderers: [:browser], id: :matrix_color, type: :color, parents: [], children: [],
#                          red: 0, green: 1, blue: 1, alpha: 1 } })
#
#     Atome.new({ color: { renderers: [:browser], id: :cell_color, type: :color, parents: [], children: [],
#                          red: 1, green: 0.15, blue: 0.7, alpha: 1 } })
#   end
#
#   def create_cells(id, cell_number, number_of_cells, style)
#     while cell_number < number_of_cells
#       @matrix_dataset[cell_number] = []
#       @cells << a = Atome.new(
#         shape: { type: :shape, renderers: [:browser], id: id + "_#{cell_number}", parents: [id],
#                  children: [:cell_color] }
#       )
#       a.style(style)
#       cell_number += 1
#     end
#   end
#
#   def initialize(params)
#     default = { col: 4, row: 4, size: 333, margin: 12, name: :matrix, parent: :view }
#     params = default.merge(params)
#     nb_of_rows = params[:row]
#     nb_of_cols = params[:col]
#     matrix_width = params[:width]
#     matrix_height = params[:height]
#
#     @matrix_dataset = []
#     @matrix_margin = params[:margin]
#     params[:id] = :matrix unless params[:id]
#     @matrix_id = params[:id]
#     # styles
#     @matrix_style = params[:matrix_style]
#     @cell_style = params[:cell_style]
#     # Colors
#     create_matrix_colors
#     # now we create the background
#     create_matrix_back( @matrix_id, @matrix_style)
#
#     @nb_of_rows = nb_of_rows.to_i
#     @nb_of_cols = nb_of_cols.to_i
#     number_of_cells = @nb_of_rows * @nb_of_cols
#     @cells = []
#     cell_number = 0
#     create_cells(@matrix_id, cell_number, number_of_cells, @cell_style)
#
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
#   def delete(val = true)
#     @matrix.delete(true) if val
#   end
#
#   attr_reader :cells
#
#   def name
#     @matrix.name
#   end
#
#   def get_cell_data(codes, cell_nb)
#     codes.each do |proc|
#       if proc.is_a? Proc
#         assign(cell_nb, &proc)
#       end
#     end
#   end
#
#   def add(params)
#     nb_of_cols = @nb_of_cols + params[:columns].to_i
#     nb_of_rows = @nb_of_rows + params[:rows].to_i
#     current_id = @matrix.atome[:id]
#     # we delete all children to unbind any event
#     @cells.each do |cell|
#       cell.delete(true)
#       cell.unbind(:all)
#     end
#     temp_id = "#{current_id}_temporary"
#     @matrix.id = temp_id
#     old_matrix=grab(temp_id)
#
#     old_matrix.delete(true)
#
#
#     Matrix.new({ col: nb_of_cols, row: nb_of_rows, width: 300, height: 300, id: current_id,  margin: @matrix_margin,
#                  matrix_style: @matrix_style,
#                  cell_style: @cell_style
#                })
#
#     @matrix_dataset.each_with_index do |cell_data, index|
#       get_cell_data(cell_data, index)
#     end
#   end
#
#   def assign(cell_nb = nil, &proc)
#     current_cell = grab("#{@matrix_id}_#{cell_nb}")
#     if proc
#       @matrix_dataset[cell_nb] << proc
#       current_cell.instance_exec(&proc) if proc.is_a? Proc
#     else
#       @matrix_dataset[cell_nb]
#     end
#   end
#
#   def reformat(params)
#     @nb_of_rows = params[:rows]
#     @nb_of_cols = params[:cols]
#     resize_matrix({ height: height, width: width })
#   end
# end

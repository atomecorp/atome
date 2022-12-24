# # frozen_string_literal: true
#
# tt = text({ data: :hello, id: :the_text, drag: true })
#
# box({ id: :the_box })
# circle({ top: 300, id: :circle098 })

generator = Genesis.generator
generator.build_atome(:template)
generator.build_atome(:matrix)

class Atome
  def matrix(params)
    parent_found = found_parents_and_renderers[:parent]
    render_found = found_parents_and_renderers[:renderers]
    default_params = { renderers: render_found, id: "matrix_#{Universe.atomes.length}", type: :matrix,
                       parents: parent_found }

    params[:renderer] = []
    params[:children] = []
    params[:parents] = [:view]

    template_needed = params[:template]
    found_margin = params[:margin] ||= 9

    matrix_id = params[:id] ||= "matrix_display_nb"
    matrix_width = params[:width] ||= 333
    matrix_height = params[:height] ||= 333
    matrix_left = params[:left ] ||= 33
    matrix_top = params[:top] ||= 33
    matrix_smooth = params[:smooth] ||= 3
    template_grab = grab(template_needed)
    # puts "template to get #{template_needed}"
    matrix_color = create_matrix_colors('matrix_color_back', 0.3, 0.3, 0.6, 1)
    cell_back_color = create_matrix_colors('cell_color_back', 0.333, 0.333, 0.7, 1)
    matrix = create_matrix({ id: matrix_id, width: matrix_width,height: matrix_height,
                                       left: matrix_left,top: matrix_top, smooth: matrix_smooth })
    matrix_color.attach([matrix_id])
    cells = create_matrix_cells(matrix_id, cell_back_color, 33, { width: 33, height: 33,
                                                                       smooth: 9, shadow: { blur: 6 } })
    resize_matrix({ matrix: matrix, width: matrix_width, height: matrix_height, cells: cells, columns: 3, rows: 8, margin: found_margin })
    params
    default_params.merge!(params)
    matrix
  end
end

generator.build_particle(:cells)
generator.build_particle(:rows)
generator.build_particle(:columns)
generator.build_sanitizer(:template) do |params|
  default_params = { renderers: [], id: "template_#{Universe.atomes.length}", type: :template }
  default_params.merge!(params)
end

def resize_matrix(params)
  matrix = params[:matrix]
  matrix_width = params[:width]
  matrix_height = params[:height]
  cells = params[:cells]
  nb_of_cols = params[:columns]
  nb_of_rows = params[:rows]
  margin = params[:margin]
  if matrix_width.instance_of? String
    parent_found  = grab(params[:matrix].parents.value.last)
    parent_width=  parent_found.width.to_px
    matrix_width = matrix_width.sub('%', '').to_i
    new_width= (parent_width*  matrix_width)/100
    matrix_width= new_width
  end
  if matrix_height.instance_of? String
    parent_found  = grab(params[:matrix].parents.value.last)
    parent_height=  parent_found.height.to_px
    matrix_height = matrix_height.sub('%', '').to_i
    new_height= (parent_height*  matrix_height)/100
    matrix_height= new_height
  end
  cell_width = (matrix_width / nb_of_cols) - margin
  cell_height = (matrix_height / nb_of_rows) - margin
  row = -1
  cells.each_with_index do |cell, index|
    cell.height = cell_height
    cell.width = cell_width
    row += 1 if index.modulo(nb_of_cols).zero?
    cell.left(index % nb_of_cols * (cell_width + margin) + margin)
    cell.top(row * (cell_height + margin) + margin)
  end

  matrix.width = matrix_width + margin
  matrix.height = matrix_height + margin
end

generator.build_particle(:display) do |params|

  template_needed = params[:template]
  targeted_atomes = params[:elements] ||= []
  # get params
  sort_by = params[:sort]
  found_width = params[:width]
  found_height = params[:height]
  found_left = params[:left]
  found_right = params[:right]
  found_margin = params[:margin] ||= 9

  matrix(params)

  # matrix_back_id = params[:id] ||= "matrix_back_display_nb"
  # template_grab = grab(template_needed)
  #
  # puts "template to get #{template_needed}"
  # matrix_back_color = create_matrix_colors('matrix_color_back', 0.3, 0.3, 0.6, 1)
  # cell_back_color = create_matrix_colors('cell_color_back', 0.333, 0.333, 0.7, 1)
  # matrix_back = create_matrix_back(matrix_back_id, { width: 33, smooth: 9 })
  # matrix_back_color.attach([matrix_back_id])
  # cells = create_matrix_cells(matrix_back_id, cell_back_color, 33, { width: 33, height: 33,
  #                                                                    smooth: 9, shadow: { blur: 6 } })
  # resize_matrix({ matrix: matrix_back, width: 333, height: 333, cells: cells, columns: 2, rows: 8, margin: found_margin })

  # We sort, clone and put the target in the matrix
  # sorted = {}
  # targeted_atomes.each_with_index do |atome_id, index|
  #   atome_found = grab(atome_id)
  #   clone = atome_found.clones([{ left: 33 }])
  #   selected_id = "#{matrix_back_id}_#{index}"
  #   clone.parents([selected_id])
  #   cell_height = grab(selected_id).height.value - 9
  #
  #   clone.left(3)
  #   clone.top(3)
  #   clone.width(cell_height)
  #   clone.height(cell_height)
  #   sorted[atome_id] = atome_found.atome[sort_by]
  #
  # end
  # sorted = sorted.sort_by { |_key, value| value }.to_h
  # selected = params[:select] ||= []
  # selected.each do |select|
  #   selected_id = "#{matrix_back_id}_#{select}"
  #   grab(selected_id).color(:red)
  # end
end

def create_matrix_colors(name, red, green, blue, alpha)
  Atome.new({ color: { renderers: [:browser], id: name, type: :color, parents: [], children: [],
                       red: red, green: green, blue: blue, alpha: alpha } })
end

def create_matrix( style)
  matrix = Atome.new(
    shape: { type: :shape, renderers: [:browser], id: style[:id], parents: [:view], width: 333, height: 333, left: 33,top: 33,
             overflow: :hidden, children: [] }
  )
  matrix.style(style)
  matrix
end

def create_matrix_cells(id, cell_back_color, number_of_cells, style)
  counter = 0
  cells = []
  while counter < number_of_cells
    id_generated = id + "_#{counter}"
    cells << a = Atome.new(
      shape: { type: :shape, renderers: [:browser], id: id_generated, parents: [id],
               children: [:cell_color]

      }
    )
    cell_back_color.attach([id_generated])
    a.style(style)
    counter += 1
  end

  cells
end

# template({ id: :child_in_table, code: [], cells: 16, columns: 4, rows: 4 })
# the_view = grab(:view)
#
# tt.display(template: :child_in_table, sort: :id, elements: [:the_box,:the_text , :circle098], select: [1, 3, 7],
#                  id: :my_matrix, left: 33, top: 63, width: 633, height: 333, margin: 9,
#                  background: {color: :red, smooth: 3}, cells: {color: :orange, smooth: 9})
#

# matrix(template: :child_in_table, sort: :id, elements: [:the_box, :circle098], select: [1, 3, 7],
#            id: :my_matrix, left: 33, top: 63, width: 633, height: 333, margin: 9,
#            background: {color: :red, smooth: 3}, cells: {color: :orange, smooth: 9})
# class Atome
#   def matrix(params)
#     alert params
#   end
# end
m=matrix({width: '100%', height: '100%', left: 0, top: 0,
          smooth: 12,id: :the_big_amazing_matrix})

class Atome
  def row(nb)
    # alert self

  end
end
# alert m
# m.cell(3).color(:red)
# alert m.cell(3)
puts m.row(3)

########### table Algo
# Define the table as an array
table = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34]

# Define the number of rows and columns in the table
num_rows = 5
num_columns = 7

# Define a method to retrieve the cells in a specified row
def get_row(table, num_columns, row_index)
  # Calculate the start and end indices for the row
  start_index = row_index * num_columns
  end_index = start_index + num_columns - 1

  # Get all the cells in the row using array slicing
  row = table[start_index..end_index]

  # Iterate over the cells in the row and print their values
  row.each do |cell|
    puts cell
  end
end

# Define a method to retrieve the cells in a specified column
def get_column(table, num_rows, num_columns, column_index)
  # Initialize an array to hold the cells in the column
  column = []

  # Iterate over the rows in the table
  num_rows.times do |row_index|
    # Calculate the index of the cell in the column
    cell_index = row_index * num_columns + column_index

    # Get the cell at the calculated index
    cell = table[cell_index]

    # Add the cell to the column array
    column << cell
  end

  # Iterate over the cells in the column and print their values
  column.each do |cell|
    puts cell
  end
end

# Test the methods
puts "Third row:"
get_row(table, num_columns, 2)

puts "\nSecond column:"
get_column(table, num_rows, num_columns, 1)

# Define the table as an array


# Define a method to retrieve the cells in a specified row

class Atome

  def set params
    params.each do |particle, value|
      send(particle, value)
    end
  end
  def matrix(params, template)
    # puts params
    matrix_id=params[:background][:id]
    background=grab(:view).box({id: matrix_id})
    background.set(params[:background])
    number_of_cells=params[:num_rows]*params[:num_columns]
    (0..number_of_cells).each_with_index  do |cell, index|
      grab(matrix_id).box({id: "#{params[:background][:id]}_#{index}"})
    end
    # puts params
    # cell_width = (params[:table_width] - params[:margin] * (params[:num_columns] + 1)) / params[:num_columns]
    # cell_height = (params[:table_height] - params[:margin] * (params[:num_rows] + 1)) / params[:num_rows]
    # matrix_content = params[:matrix_content]
    # grab(:view).box({id: params[:id]})
    # # Initialize the cells array
    # # cells = []
    # i=0
    # params[:num_rows].times do |row_index|
    #   # row = []
    #   params[:num_columns].times do |col_index|
    #     # Calculate the x and y position of the cell
    #     # x = (col_index + 1) * params[:margin] + col_index * cell_width
    #     # y = (row_index + 1) * params[:margin] + row_index * cell_height
    #     # cell= { x: x, y: y, width: cell_width, height: cell_height, cell_content: matrix_content[i] }
    #     # puts cell
    #     # i+=1
    #     # b=box({})
    #     # b.width = cell_width
    #     # b.height = cell_height
    #     # b.left =  x
    #     # b.top = y
    #     # b.text({data: matrix_content[i] })
    #     # Add the cell to the row
    #     # row << { x: x, y: y, width: cell_width, height: cell_height }
    #   end
    #   # Add the row to the cells array
    #
    #   # cells << row
    # end
    # # puts "=> #{cells.}"

  end

  def get_row(table, num_columns, row_index)
    # Calculate the start and end indices for the row
    start_index = row_index * num_columns
    end_index = start_index + num_columns - 1

    # Get all the cells in the row using array slicing
    row = table[start_index..end_index]

    # Iterate over the cells in the row and print their values
    cells = []
    row.each do |cell|
      cells << cell
    end
    cells
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
    cells = []
    column.each do |cell|
      cells << cell
    end
    cells
  end
end




######################
data = [0, 1, 2, 3, 4, 5, 6, 7, "ok", 9, 10, 11, 12, 13, 14, "my_data", 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34]

# Define the number of rows and columns in the table
params = { num_rows: 8,
           num_columns: 7,
           background: {width: 700, height: 800,  id: :my_table, smooth: 8, color: :red },
           item: {margin: 9, padding: 3, color: :green, smooth: 6},
           matrix_content: data,
          }

template= {
  cell_fusion: [[3,4], [12, 13], [9,23]],
  column_equisize: [3,5],
  row_equisize: [1,6],
}
m = Atome.new
m.matrix(params, template)

# Test the methods

# puts "first row:"
# puts get_row(table_content, num_columns, 0)
#
# puts "Second row:"
# puts get_row(table_content, num_columns, 1)
#
# puts "Third row:"
# get_row(table_content, num_columns, 2)
#
# puts "\nSecond column:"
# puts get_column(table_content, num_rows, num_columns, 1)

# Table.new({
#             table_width: 700,
# table_height: 600,
# num_rows: 8,
# num_columns: 8,
# margin: 9,
#             exeptions: {columns: {
#               column3: {nb_of_cells: 3},
#                         column5: {fusion: [{cell3: :cell4, cell6: :cell7}]}
#             },
#             rows: {
#
#               row2: {nb_of_cells: 4},
#               row6: {fusion: [{cell1: :cell2, cell4: :cell5,cell6: :cel75}]}
#             }
#
#             }
#
#           })

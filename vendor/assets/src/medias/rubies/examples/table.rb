# Define the table as an array

# Define a method to retrieve the cells in a specified row
generator = Genesis.generator

generator.build_atome(:collection)

# generator.build_particle(:proto)
class Atome

  def each(&proc)
      value.each do |val|
        instance_exec(val, &proc) if proc.is_a?(Proc)
      end
  end

  def [](range)
     value[range]
  end

  def set(params)
    params.each do |particle, value|
      send(particle, value)
    end
  end

  def cells(cell_nb)
    
    cell_nb.each do |cell_found|

    end

  end

  def columns(column_requested, &proc)
    number_of_cells=@columns*@rows
    column_content=get_column_or_row(number_of_cells, @columns, column_requested, true)
    cells_found=[]
     column_content.each do |cell_nb|
       atome_found=grab("#{id}_#{cell_nb}")
       instance_exec(atome_found, &proc) if proc.is_a?(Proc)
       cells_found <<  grab("#{id}_#{cell_nb}")
     end
    element({data: cells_found})
  end

  def rows(row_requested, &proc)
    number_of_cells=@columns*@rows
    column_content=get_column_or_row(number_of_cells, @columns, row_requested, false)
    cells_found=[]
    column_content.each do |cell_nb|
      atome_found=grab("#{id}_#{cell_nb}")
      instance_exec(atome_found, &proc) if proc.is_a?(Proc)
      cells_found <<  grab("#{id}_#{cell_nb}")
    end
    element({data: cells_found})
  end

  def format_matrix(matrix_id, matrix_width, matrix_height, nb_of_rows, nb_of_cols, margin, exceptions = {})
    cell_width = (matrix_width - margin * (nb_of_cols + 1)) / nb_of_cols
    cell_height = (matrix_height - margin * (nb_of_rows + 1)) / nb_of_rows
    i = 0
    # rows = []
    # cols = []
    nb_of_rows.times do |row_index|
      nb_of_cols.times do |col_index|
        # Calculate the x and y position of the cell
        x = (col_index + 1) * margin + col_index * cell_width
        y = (row_index + 1) * margin + row_index * cell_height

        current_cell = grab("#{matrix_id}_#{i}")
        current_cell.width = cell_width
        current_cell.height = cell_height
        current_cell.left(x)
        current_cell.top(y)
        i += 1
      end
    end

    # exceptions management

    number_of_cells = nb_of_rows * nb_of_cols
    # columns exceptions
    exceptions[:columns_fusion].each do |column_to_alter, value|
      cells_in_column = get_column_or_row(number_of_cells, nb_of_cols, column_to_alter, true)
      cells_to_alter = cells_in_column[value[0]..value[1]]

      cells_to_alter.each_with_index do |cell_nb, index|
        current_cell = grab("#{matrix_id}_#{cell_nb}")
        if index == 0
          current_cell.height(cell_height * cells_to_alter.length + margin * (cells_to_alter.length - 1))
        else
          current_cell.hide(true)
        end
      end
    end if exceptions[:columns_fusion]

    exceptions[:columns_divided].each do |column_to_alter, value|
      cells_in_column = get_column_or_row(number_of_cells, nb_of_cols, column_to_alter, true)
      #  we get the nth first element
      cells_to_alter = cells_in_column.take(value)
      cells_in_column.each_with_index do |cell_nb, index|
        current_cell = grab("#{matrix_id}_#{cell_nb}")
        if cells_to_alter.include?(cell_nb)
          current_cell.height(matrix_height / value - (margin + value))
          current_cell.top(current_cell.height.value * index + margin * (index + 1))
        else
          current_cell.hide(true)
        end
      end
    end if exceptions[:columns_divided]

    ###### rows exceptions

    exceptions[:rows_fusion].each do |row_to_alter, value|
      cells_in_column = get_column_or_row(number_of_cells, nb_of_cols, row_to_alter, false)
      cells_to_alter = cells_in_column[value[0]..value[1]]

      cells_to_alter.each_with_index do |cell_nb, index|
        current_cell = grab("#{matrix_id}_#{cell_nb}")
        if index == 0
          current_cell.width(cell_width * cells_to_alter.length + margin * (cells_to_alter.length - 1))
        else
          current_cell.hide(true)
        end
      end
    end if exceptions[:rows_fusion]

    exceptions[:rows_divided].each do |row_to_alter, value|
      cells_in_row = get_column_or_row(number_of_cells, nb_of_cols, row_to_alter, false)
      #  we get the nth first element
      cells_to_alter = cells_in_row.take(value)
      cells_in_row.each_with_index do |cell_nb, index|
        current_cell = grab("#{matrix_id}_#{cell_nb}")
        if cells_to_alter.include?(cell_nb)
          current_cell.width(matrix_width /  value-margin-(margin/value) )
          current_cell.left(current_cell.width.value * index + margin * (index + 1))
        else
          current_cell.hide(true)
        end
      end
    end if exceptions[:rows_divided]

  end

  def apply_style(current_cell, style)
    current_cell.set(style)
  end

  def matrix(params)
    # get necessary params
    matrix_id = params[:matrix][:particles][:id]
    self.id = matrix_id
    @rows = params[:rows][:count]
    @columns = params[:columns][:count]
    margin = params[:cells][:particles].delete(:margin)
    matrix_width = params[:matrix][:particles][:width]
    matrix_height = params[:matrix][:particles][:height]

    # exceptions reorganisation
    if params[:exceptions]
      columns_exceptions = params[:exceptions][:columns]
      columns_fusion_exceptions = columns_exceptions[:fusion] if columns_exceptions
      columns_divided_exceptions = columns_exceptions[:divided] if columns_exceptions
      rows_exceptions = params[:exceptions][:rows]
      rows_fusion_exceptions = rows_exceptions[:fusion] if rows_exceptions
      rows_divided_exceptions = rows_exceptions[:divided] if rows_exceptions
      exceptions = {
        columns_fusion: columns_fusion_exceptions,
        columns_divided: columns_divided_exceptions,
        rows_fusion: rows_fusion_exceptions,
        rows_divided: rows_divided_exceptions,
      }
    else
      exceptions = {}
    end

    # let's create the matrix background
    current_matrix = grab(:view).box({ id: matrix_id })
    current_matrix.set(params[:matrix][:particles])
    number_of_cells = @rows * @columns
    number_of_cells.times do |index|
      current_cell = grab(matrix_id).box({ id: "#{matrix_id}_#{index}" })
      apply_style(current_cell, params[:cells][:particles])
    end
    # lets create the columns and rows
    format_matrix(matrix_id, matrix_width, matrix_height, @rows, @columns, margin, exceptions)
  end

  def get_column_or_row(length, num_columns, index, is_column)
    # Calculer le nombre de lignes du tableau
    num_rows = length / num_columns

    if is_column
      # Vérifier que l'index de colonne est valide
      if index < 0 || index >= num_columns
        puts "L'index de colonne spécifié est hors limites"
        return
      end

      # Renvoyer le contenu de la colonne d'index 'index'
      result = []
      (0...num_rows).each do |row|
        result << (index + row * num_columns)
      end
      return result
    else
      # Vérifier que l'index de ligne est valide
      if index < 0 || index >= num_rows
        puts "L'index de ligne spécifié est hors limites"
        return
      end

      # Renvoyer le contenu du ligne d'index 'index'
      start_index = index * num_columns
      end_index = start_index + num_columns - 1
      return (start_index..end_index).to_a
    end
  end

  # def get_column_or_row(array, total_num_columns, index, is_column)
  #   if is_column
  #     result = []
  #     array.each_with_index do |elem, i|
  #       if i % total_num_columns == index
  #         result << elem
  #       end
  #     end
  #     result
  #   else
  #     start_index = index * total_num_columns
  #     end_index = start_index + total_num_columns - 1
  #     array[start_index..end_index]
  #   end
  # end
end

######################
# data = [:hello, 1, 2, 3, super, 5, 6, 7, "ok", 9, 10, 11, 12, 13, 14, "my_data", 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34]
#
# # Define the number of rows and columns in the table
# params = { num_rows: 8,
#            num_columns: 7,
#            background: {width: 700, height: 800,  id: :my_table, smooth: 8, color: :yellow },
#            item: {margin: 9, padding: 3, color: :green, smooth: 6},
#            matrix_content: data,
#           }
#
# demo_template= {
#   columns: 6,
#   rows: 4,
#   cell_fusion: [[3,4], [12, 13], [9,23]],
#   column_equisize: [3,5],
#   row_equisize: [1,6],
# }

params = {
  matrix: {
    particles: { id: :my_table, left: 33, top: 33, width: 500, height: 399, smooth: 8, color: :yellowgreen }
  },
  columns: { count: 8,
             titles: { 1 => :col1, 3 => :mycol },
             data: { 3 => :col_content },
             actions: { 2 => { touch: :the_action } },
             particles: { color: :blue }
  },
  rows: { count: 6,
          titles: { 1 => :my_first_row, 5 => :other_row },
          data: {},
          actions: {},
          particles: { shadows: :black }
  },
  cells: {
    data: { 2 => "hello", 4 => :hi, 5 => :good, 7 => :super },
    actions: { 2 => { touch: :my_lambda } },
    particles: { margin: 9, color: :green, smooth: 9, shadow: { blur: 9, left: 3, top: 3 } }
  },
  exceptions: {
    columns: {
      # divided: { 2 => 3 },
      fusion: { 1 => [3, 5], 7 => [2, 5] }
    },
    rows: {
      divided: { 1 => 3 },
      fusion: { 2 => [0, 3], 3 => [2, 5] }
    }
  }
}
m = element({})
m.matrix(params)
alert m.columns(5)[2]
found=m.columns(5) do |el|
    el.color(:yellow)
end

m.rows(3) do |el|
  el.color(:orange)
end
m.rows(1) do |el|
  el.color(:lightgray)
end

# puts found.data.each
 found.data.each do |el|
   el.color(:red)
 end
 found.data[0..2].each do |el|
   puts el.id
   el.color(:cyan)
 end


grab(:my_table_23).color(:purple)
grab(:my_table_26).color(:purple)
 m.cells[23, 26].color(:blue)


# cc =element(data: [:poi, :sdfre, :jhfg])
#  cc.data.each do |p|
#    puts p
#  end
# m.apply_template(demo_template)
# alert m.get_row()

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




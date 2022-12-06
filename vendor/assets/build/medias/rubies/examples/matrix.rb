# frozen_string_literal: true
class Matrix
  attr_accessor :matrix

  def create_matrix_back(name, id, style)
    @matrix = Atome.new(
      shape: { type: :shape, renderers: [:browser], id: id, parents: [:view], children: [:matrix_color],
               name: name, overflow: :auto }
    )
    @matrix.style(style)
  end

  def create_matrix_colors
    Atome.new({ color: { renderers: [:browser], id: :matrix_color, type: :color, parents: [], children: [],
                         red: 0, green: 1, blue: 1, alpha: 1 } })

    Atome.new({ color: { renderers: [:browser], id: :cell_color, type: :color, parents: [], children: [],
                         red: 1, green: 0.15, blue: 0.7, alpha: 1 } })
  end

  def create_cells(id, cell_number, number_of_cells, style)
    while cell_number < number_of_cells
      @matrix_dataset[cell_number] = []
      @cells << a = Atome.new(
        shape: { type: :shape, renderers: [:browser], id: id + "_#{cell_number}", parents: [id],
                 children: [:cell_color] }
      )
      a.style(style)
      cell_number += 1
    end
  end

  def initialize(params)
    default = { col: 4, row: 4, size: 333, margin: 12, name: :matrix, parent: :view }
    params = default.merge(params)
    nb_of_rows = params[:row]
    nb_of_cols = params[:col]
    matrix_width = params[:width]
    matrix_height = params[:height]

    @matrix_dataset = []
    @matrix_margin = params[:margin]
    params[:id] = :matrix unless params[:id]
    @matrix_id = params[:id]
    @matrix_name = params[:name]
    # styles
    @matrix_style = params[:matrix_style]
    @cell_style=  params[:cell_style]
    # Colors
    create_matrix_colors
    # now we create the background
    create_matrix_back(@matrix_name, @matrix_id, @matrix_style)

    @nb_of_rows = nb_of_rows.to_i
    @nb_of_cols = nb_of_cols.to_i
    number_of_cells = @nb_of_rows * @nb_of_cols
    @cells = []
    cell_number = 0
    create_cells(@matrix_id, cell_number, number_of_cells, @cell_style)

    resize_matrix({ width: matrix_width, height: matrix_height })
  end

  def width(val = nil)
    if val
      resize_matrix({ height: height, width: val })
    else
      @matrix.width.value
    end

  end

  def height(val = nil)
    if val
      resize_matrix({ width: width, height: val })
    else
      @matrix.height.value
    end
  end

  def left(val)
    @matrix.left(val)
  end

  def right(val)
    @matrix.right(val)
  end

  def resize_matrix(params)
    matrix_width = params[:width]
    matrix_height = params[:height]
    cell_width = (matrix_width / @nb_of_cols) - @matrix_margin
    cell_height = (matrix_height / @nb_of_rows) - @matrix_margin
    row = -1
    @cells.each_with_index do |cell, index|
      cell.height = cell_height
      cell.width = cell_width
      row += 1 if index.modulo(@nb_of_cols).zero?
      cell.left(index % @nb_of_cols * (cell_width + @matrix_margin) + @matrix_margin)
      cell.top(row * (cell_height + @matrix_margin) + @matrix_margin)
    end

    @matrix.width = matrix_width + @matrix_margin
    @matrix.height = matrix_height + @matrix_margin
  end

  def get_cell(id)
    grab("#{@matrix_id}_#{id}")
  end

  def delete
    @matrix.delete(true)
  end

  attr_reader :cells

  def name
    @matrix.name
  end

  def add(params)
    nb_of_cols=@nb_of_cols+params[:columns].to_i
    nb_of_rows=@nb_of_rows+params[:rows].to_i
    current_id=@matrix.atome[:id]
    temp_id= "#{current_id}_temporary"
    Matrix.new({ col: nb_of_cols, row: nb_of_rows, width: 300, height: 300, id:  temp_id, name: @matrix_name, margin: @matrix_margin,
                 matrix_style: @matrix_style,
                 cell_style: @cell_style
               })
      self.delete
    upgraded_matrix=grab(temp_id)
    upgraded_matrix.id(current_id)
    @matrix_dataset.each do |proc|
      puts proc
      upgraded_matrix.instance_exec(&proc) if proc.is_a? Proc
    end

  end

  def get(val = nil, &proc)
    if proc
      @matrix_dataset[val] << proc
      instance_exec(&proc) if proc.is_a? Proc
    else
      @matrix_dataset[val]
    end
  end

  def reformat(params)
    @nb_of_rows=params[:rows]
    @nb_of_cols=params[:cols]
    resize_matrix({ height: height, width: width })
  end
end

a = Matrix.new({ col: 1, row: 8, width: 120, height: 333, id: :vie_playground, name: :matrix_2, margin: 9,
                 matrix_style: { color: { red: 0.3, green: 0.3, blue: 0.6, alpha: 1 }, smooth: 20 },
                 cell_style: { color: { red: 0.333, green: 0.333, blue: 0.6, alpha: 1 }, smooth: 300, shadow: { blur: 6 }
                               #border: { color: :black, thickness: 0, pattern: :solid }
                 }
               })

######## tests

  a.get(3) do
    grab(:vie_playground_3).color({ red: 0.6, green: 0.333, blue: 0.6, alpha: 1 })
    grab(:vie_playground_3).shadow({ blur: 12 })
  end

  # a.width(222)
  # puts a.name
wait 2 do
  a.add({ columns: 3 })
end
  # a.delete
  # wait 2 do
    # a.reformat({rows: 4, cols: 2})
    # alert a.matrix.height(150)
    # a.resize_matrix({ width: 666, height: 333 })
    # alert  a.get(3)
  # end



# get cell
# a.get(3) do
#   grab(:vie_playground_3).color({ red: 0.6, green: 0.333, blue: 0.6, alpha: 1 })
#   grab(:vie_playground_3).shadow({ blur: 12 })
# end

# add column
# a.add({ column: 3 })

# add row
# a.add({ row: 2 })

# reformat
# a.reformat({rows: 4, cols: 2})

# resize matrix
# a.resize_matrix({ width: 666, height: 333 })

# crop matrix
# a.matrix.height(150)

################ deprecated below #############

# grab(:vie_playground_3).color({ red: 0.6, green: 0.333, blue: 0.6, alpha: 1 })
# grab(:vie_playground_3).shadow({ blur: 12 })


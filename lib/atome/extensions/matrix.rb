# frozen_string_literal: true
#

module Matrix
  def content(items = nil)
    if items.instance_of?(Array)
      items.each do |item|
        content(item)
      end
    elsif items.instance_of?(Atome)
      w_found = items.particles[:width]
      h_found = items.particles[:height]
      l_found = items.particles[:left]
      t_found = items.particles[:top]
      i_found = items.particles[:id]
      current_w_found = width
      current_h_found = height
      current_l_found = left
      current_t_found = top
      @cell_content ||= {}
      @cell_content[i_found] = { width_ratio: 1, height_ratio: 1, top_ratio: 1, left_ratio: 1 }
      # alert @cell_content
      items.parents([id])
    else
      @cell_content
    end
  end

  def cells(cell_nb)
    collector_object = collector({})
    collected_atomes = []
    cell_nb.each do |cell_found|
      atome_found = grab("#{id}_#{cell_found}")
      collected_atomes << atome_found
    end
    collector_object.data(collected_atomes)
    collector_object
  end

  def cell(cell_nb)
    grab("#{id}_#{cell_nb}")
  end

  def columns(column_requested, &proc)
    number_of_cells = @columns * @rows
    column_content = get_column_or_row(number_of_cells, @columns, column_requested, true)
    cells_found = []
    column_content.each do |cell_nb|
      atome_found = grab("#{id}_#{cell_nb}")
      instance_exec(atome_found, &proc) if proc.is_a?(Proc)
      cells_found << grab("#{id}_#{cell_nb}")
    end
    element({ data: cells_found })
  end

  def rows(row_requested, &proc)
    number_of_cells = @columns * @rows
    column_content = get_column_or_row(number_of_cells, @columns, row_requested, false)
    cells_found = []
    column_content.each do |cell_nb|
      atome_found = grab("#{id}_#{cell_nb}")
      instance_exec(atome_found, &proc) if proc.is_a?(Proc)
      cells_found << grab("#{id}_#{cell_nb}")
    end
    element({ data: cells_found })
  end

  # def ratio(val)
  #   puts "ratio must be : #{val}"
  #
  # end

  def fusion(params)
    number_of_cells = @columns * @rows
    if params[:columns]
      @exceptions[:columns_fusion] = params[:columns].merge(@exceptions[:columns_fusion])
      params[:columns].each do |column_to_alter, value|
        cell_height = (@matrix_height - @margin * (@rows + 1)) / @rows
        cells_in_column = get_column_or_row(number_of_cells, @columns, column_to_alter, true)
        cells_to_alter = cells_in_column[value[0]..value[1]]
        cells_to_alter.each_with_index do |cell_nb, index|
          current_cell = grab("#{id.value}_#{cell_nb}")
          if index.zero?
            current_cell.height(cell_height * cells_to_alter.length + @margin * (cells_to_alter.length - 1))
          else
            current_cell.hide(true)
          end
        end
      end
    else
      @exceptions[:rows_fusion] = params[:rows].merge(@exceptions[:rows_fusion])
      params[:rows].each do |row_to_alter, value|
        cell_width = (@matrix_width - @margin * (@columns + 1)) / @columns
        cells_in_column = get_column_or_row(number_of_cells, @columns, row_to_alter, false)
        cells_to_alter = cells_in_column[value[0]..value[1]]

        cells_to_alter.each_with_index do |cell_nb, index|
          current_cell = grab("#{id.value}_#{cell_nb}")
          if index.zero?
            current_cell.width(cell_width * cells_to_alter.length + @margin * (cells_to_alter.length - 1))
          else
            current_cell.hide(true)
          end
        end
      end
    end
  end

  def divide(params)
    number_of_cells = @columns * @rows
    if params[:columns]
      params[:columns].each do |column_to_alter, value|
        cells_in_column = get_column_or_row(number_of_cells, @columns, column_to_alter, true)
        #  we get the nth first element
        cells_to_alter = cells_in_column.take(value)
        cells_in_column.each_with_index do |cell_nb, index|
          current_cell = grab("#{id.value}_#{cell_nb}")
          if cells_to_alter.include?(cell_nb)
            current_cell.height(@matrix_height / value - (@margin + value))
            current_cell.top(current_cell.height.value * index + @margin * (index + 1))
          else
            current_cell.hide(true)
          end
        end
      end
    else
      params[:rows].each do |row_to_alter, value|
        cells_in_row = get_column_or_row(number_of_cells, @columns, row_to_alter, false)
        #  we get the nth first element
        cells_to_alter = cells_in_row.take(value)
        cells_in_row.each_with_index do |cell_nb, index|
          current_cell = grab("#{id.value}_#{cell_nb}")
          if cells_to_alter.include?(cell_nb)
            current_cell.width(@matrix_width / value - @margin - (@margin / value))
            current_cell.left(current_cell.width.value * index + @margin * (index + 1))
          else
            current_cell.hide(true)
          end
        end
      end
    end
  end

  # def override(params)
  #   # TODO : allow fixed height ond fixed width when resizing
  #   puts "should override to allow fixed height or fixed width when resizing #{params}"
  # end

  def first(item, &proc)
    if item[:columns]
      columns(0, &proc)
    else
      rows(0, &proc)
    end
  end

  def last(item, &proc)
    if item[:columns]
      columns(@columns - 1, &proc)
    else
      rows(@rows - 1, &proc)
    end
  end

  def format_matrix(matrix_id, matrix_width, matrix_height, nb_of_rows, nb_of_cols, margin, exceptions = {})
    cell_width = (matrix_width - margin * (nb_of_cols + 1)) / nb_of_cols
    cell_height = (matrix_height - margin * (nb_of_rows + 1)) / nb_of_rows
    ratio = cell_height / cell_width
    i = 0
    nb_of_rows.times do |row_index|
      nb_of_cols.times do |col_index|
        # Calculate the x and y position of the cell
        x = (col_index + 1) * margin + col_index * cell_width
        y = (row_index + 1) * margin + row_index * cell_height
        current_cell = grab("#{matrix_id}_#{i}")
        # puts "===> #{current_cell}"
        current_cell.children.each do |child|
          # puts "=>#{cell_width}"
          grab(child).width(cell_width) if grab(child)
          grab(child).height(cell_width) if grab(child)
        end
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
    return unless exceptions

    fusion({ columns: exceptions[:columns_fusion] }) if exceptions[:columns_fusion]
    fusion({ rows: exceptions[:rows_fusion] }) if exceptions[:rows_fusion]
    divide({ columns: exceptions[:columns_divided] }) if exceptions[:columns_divided]
    divide({ rows: exceptions[:rows_divided] }) if exceptions[:rows_divided]
  end

  def apply_style(current_cell, style)
    current_cell.set(style)
  end
  def matrix_sanitizer(params)
    default_params = {

      id: :my_table, left: 33, top: 33, width: 369, height: 369, smooth: 8, color: :gray,
      columns: { count: 4 },
      rows: { count: 4 },
      cells: { particles: { margin: 9, color: :lightgray, smooth: 9, shadow: { blur: 9, left: 3, top: 3 } }
      }
    }
    default_params.merge(params)
  end
  def matrix(params = {}, &bloc)
    params= matrix_sanitizer(params)
    columns_data = if params[:columns]
                     params.delete(:columns)
                   else
                     { count: 4 }
                   end

    rows_data = if params[:rows]
                  params.delete(:rows)
                else
                  { count: 4 }
                end

    cells_data = if params[:cells]
                   params.delete(:cells)
                 else
                   { particles: { margin: 9, color: :lightgray } }
                 end
    cells_color = cells_data[:particles].delete(:color)
    cells_color_id = color(cells_color).id.value

    cells_shadow = cells_data[:particles].delete(:shadow)
    cells_shadow_id = shadow(cells_shadow).id.value

    exceptions_data = params.delete(:exceptions)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :matrix
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || identity_generator(:matrix)

    generated_parents = params[:parents] || [id.value]
    generated_children = params[:children] || []
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, generated_children, params)
    the_matrix = Atome.new({ atome_type => params }, &bloc)

    # TODO:  use the standard atome creation method (generator.build_atome(:collector)),
    # TODO suite => For now its impossible to make it draggable because it return the created box not the matrix
    # get necessary params
    matrix_id = params[:id]
    matrix_width = params[:width]
    matrix_height = params[:height]
    columns = columns_data[:count]
    rows = rows_data[:count]
    margin = cells_data[:particles].delete(:margin)
    the_matrix.instance_variable_set('@columns', columns)
    the_matrix.instance_variable_set('@rows', rows)
    the_matrix.instance_variable_set('@margin', margin)
    the_matrix.instance_variable_set('@cell_style', cells_data[:particles])
    the_matrix.instance_variable_set('@matrix_width', matrix_width)
    the_matrix.instance_variable_set('@matrix_height', matrix_height)

    rows = rows_data[:count]
    columns = columns_data[:count]
    # @rows = rows_data[:count]
    # @columns = columns_data[:count]
    # @margin = cells_data[:particles].delete(:margin)
    # @cell_style = cells_data[:particles]
    # @matrix_width = params[:width]
    # @matrix_height = params[:height]

    # exceptions reorganisation
    if exceptions_data
      columns_exceptions = exceptions_data[:columns] ||= {}
      columns_fusion_exceptions = columns_exceptions[:fusion] ||= {}
      columns_divided_exceptions = columns_exceptions[:divided] ||= {}
      rows_exceptions = exceptions_data[:rows] ||= {}
      rows_fusion_exceptions = rows_exceptions[:fusion] ||= {}
      rows_divided_exceptions = rows_exceptions[:divided] ||= {}
      exceptions = { columns_fusion: columns_fusion_exceptions,
                     columns_divided: columns_divided_exceptions,
                     rows_fusion: rows_fusion_exceptions,
                     rows_divided: rows_divided_exceptions }
      # @exceptions = {
      #   columns_fusion: columns_fusion_exceptions,
      #   columns_divided: columns_divided_exceptions,
      #   rows_fusion: rows_fusion_exceptions,
      #   rows_divided: rows_divided_exceptions,
      # }
    else
      exceptions = {
        columns_fusion: {},
        columns_divided: {},
        rows_fusion: {},
        rows_divided: {}
      }
      # @exceptions = {
      #   columns_fusion: {},
      #   columns_divided: {},
      #   rows_fusion: {},
      #   rows_divided: {},
      # }
    end
    the_matrix.instance_variable_set('@exceptions', exceptions)

    # let's create the matrix background
    # current_matrix = grab(:view).box({ id: matrix_id })
    # current_matrix.set(params[:matrix][:particles])

    # cells creation below
    number_of_cells = rows * columns
    number_of_cells.times do |index|
      current_cell = grab(matrix_id).box({ id: "#{matrix_id}_#{index}" })
      the_matrix.instance_variable_set('@cell_style', cells_data[:particles])
      current_cell.attached([cells_shadow_id])
      current_cell.attached([cells_color_id])
      apply_style(current_cell, cells_data[:particles])
    end
    # lets create the columns and rows
    the_matrix.format_matrix(matrix_id, matrix_width, matrix_height, rows, columns, margin, exceptions)
    the_matrix
  end

  def add_columns(nb)
    prev_nb_of_cells = @columns * @rows
    nb_of_cells_to_adds = nb * @rows
    new_nb_of_cells = prev_nb_of_cells + nb_of_cells_to_adds
    new_nb_of_cells.times do |index|
      if index < prev_nb_of_cells
        grab("#{id.value}_#{index}").delete(true)
        # puts index
        #
      end
      current_cell = box({ id: "#{id}_#{index}" })
      apply_style(current_cell, @cell_style)
    end
    @columns += nb
    ########## old algo
    # nb_of_cells_to_adds = nb * @rows
    # prev_nb_of_cells = @columns * @rows
    # nb_of_cells_to_adds.times do |index|
    #   current_cell = self.box({ id: "#{id}_#{prev_nb_of_cells + index}" })
    #   apply_style(current_cell, @cell_style)
    # end
    # @columns = @columns + nb
    format_matrix(id, @matrix_width, @matrix_height, @rows, @columns, @margin, @exceptions)
  end

  def add_rows(nb)
    prev_nb_of_cells = @columns * @rows
    nb_of_cells_to_adds = nb * @columns
    new_nb_of_cells = prev_nb_of_cells + nb_of_cells_to_adds
    new_nb_of_cells.times do |index|
      if index < prev_nb_of_cells
        grab("#{id.value}_#{index}").delete(true)
        # puts index
        #
      end
      current_cell = box({ id: "#{id}_#{index}" })
      apply_style(current_cell, @cell_style)
    end
    @rows += nb
    ########## old algo
    # nb_of_cells_to_adds = nb * @columns
    # prev_nb_of_cells = @columns * @rows
    # nb_of_cells_to_adds.times do |index|
    #   current_cell = self.box({ id: "#{id}_#{prev_nb_of_cells + index}" })
    #   apply_style(current_cell, @cell_style)
    # end
    # @rows = @rows + nb
    format_matrix(id, @matrix_width, @matrix_height, @rows, @columns, @margin, @exceptions)
  end

  def resize(width, height)
    @matrix_width = width
    @matrix_height = height
    grab(id.value).width(width)
    grab(id.value).height(height)
    format_matrix(id, @matrix_width, @matrix_height, @rows, @columns, @margin, @exceptions)
  end

  def get_column_or_row(length, num_columns, index, is_column)
    # puts "length: #{length}, #{num_columns} : #{num_columns}, index : #{index}, is_column : #{is_column}"
    # Compute the number of line
    num_rows = length / num_columns
    if is_column
      result = []
      (0...num_rows).each do |row|
        result << (index + row * num_columns)
      end
      result
    else
      start_index = index * num_columns
      end_index = start_index + num_columns - 1
      (start_index..end_index).to_a
    end
  end
end

class Atome
  include Matrix
end

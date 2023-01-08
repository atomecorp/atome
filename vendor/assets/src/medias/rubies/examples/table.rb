# frozen_string_literal: true
generator = Genesis.generator
generator.build_particle(:relations, { type: :hash })
# generator.build_particle(:family,{render: true,store: false})

generator.build_particle(:delete) do |params|
  if params == true
    # the machine delete the current atome
    Universe.delete(@atome[:id])
  elsif params[:id]
    # the machine try to an atome by it's ID and delete it
    grab(params[:id]).delete(true)
  elsif params.instance_of? Hash
    # the machine try to find the sub particle id and remove it eg a.delete(monitor: :my_monitor) remove the monitor
    # with id my_monitor
    params.each do |param, value|
      atome[param][value] = nil
    end
  else
  #   # the machine try to reset the current particle(params), eg a.delete(:left) => left: 0
    send(params,0)
  end
end

def matrix(params = {}, &proc)
  grab(:view).matrix(params, &proc)
end

class Atome
  def content(items = nil)
    if  items.instance_of?(Array)
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
      items.parents([self.id])
    else
       @cell_content
    end

  end

  def cells(cell_nb)
    collector_object = collector({})
    collected_atomes = []
    cell_nb.each do |cell_found|
      atome_found = grab ("#{id}_#{cell_found}")
      collected_atomes << atome_found
    end
    collector_object.data(collected_atomes)
    collector_object
  end

  def cell(cell_nb)
    cell_found = grab ("#{id}_#{cell_nb}")
    cell_found
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
          if index == 0
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
          if index == 0
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

  def override(params)
    # TODO : allow fixed height ond fixed width when resizing
    puts "should override to allow fixed height or fixed width when resizing #{params}"
  end

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
    ratio=cell_height/cell_width
    i = 0
    nb_of_rows.times do |row_index|
      nb_of_cols.times do |col_index|
        # Calculate the x and y position of the cell
        x = (col_index + 1) * margin + col_index * cell_width
        y = (row_index + 1) * margin + row_index * cell_height
        current_cell = grab("#{matrix_id}_#{i}")
        puts current_cell.data
        current_cell.children.each do |child|
          puts "=>#{cell_width}"
          grab(child).width(cell_width)
          grab(child).height(cell_width)

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
    if exceptions
      fusion({ columns: exceptions[:columns_fusion] }) if exceptions[:columns_fusion]
      fusion({ rows: exceptions[:rows_fusion] }) if exceptions[:rows_fusion]
      divide({ columns: exceptions[:columns_divided] }) if exceptions[:columns_divided]
      divide({ rows: exceptions[:rows_divided] }) if exceptions[:rows_divided]
    end

  end

  def apply_style(current_cell, style)
    current_cell.set(style)
  end

  def matrix(params = {}, &bloc)

    if  params[:columns]
      columns_data = params.delete(:columns)
    else
      columns_data= {  count: 4 }
    end

    if  params[:rows]
      rows_data = params.delete(:rows)
    else
      rows_data= {  count: 4 }
    end

    if  params[:cells]
      cells_data = params.delete(:cells)
    else
      cells_data= { particles: { margin: 9, color: :lightgray } }
    end
    cells_color=cells_data[:particles].delete(:color)
    cells_color_id= color(cells_color).id.value

    cells_shadow=cells_data[:particles].delete(:shadow)
    cells_shadow_id= shadow(cells_shadow).id.value

    exceptions_data = params.delete(:exceptions)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :matrix
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
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
    the_matrix.instance_variable_set("@columns", columns)
    the_matrix.instance_variable_set("@rows", rows)
    the_matrix.instance_variable_set("@margin", margin)
    the_matrix.instance_variable_set("@cell_style", cells_data[:particles])
    the_matrix.instance_variable_set("@matrix_width", matrix_width)
    the_matrix.instance_variable_set("@matrix_height", matrix_height)

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
      the_matrix.instance_variable_set("@exceptions", exceptions)
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
        rows_divided: {},
      }
      the_matrix.instance_variable_set("@exceptions", exceptions)
      # @exceptions = {
      #   columns_fusion: {},
      #   columns_divided: {},
      #   rows_fusion: {},
      #   rows_divided: {},
      # }
    end

    # let's create the matrix background
    # current_matrix = grab(:view).box({ id: matrix_id })
    # current_matrix.set(params[:matrix][:particles])

    # cells creation below
    number_of_cells = rows * columns
    number_of_cells.times do |index|
      current_cell = grab(matrix_id).box({ id: "#{matrix_id}_#{index}" })
      the_matrix.instance_variable_set("@cell_style", cells_data[:particles])
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
        puts index
        #
      end
      current_cell = self.box({ id: "#{id}_#{index}" })
      apply_style(current_cell, @cell_style)
    end
    @columns = @columns + nb
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
        puts index
        #
      end
      current_cell = self.box({ id: "#{id}_#{index}" })
      apply_style(current_cell, @cell_style)
    end
    @rows = @rows + nb
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
      return result
    else
      start_index = index * num_columns
      end_index = start_index + num_columns - 1
      return (start_index..end_index).to_a
    end
  end

end

###########################

params = {

  id: :my_table, left: 0, top: 0, width: 500, height: 399, smooth: 8, color: :yellowgreen,
  columns: { count: 8,
             titles: { 1 => :col1, 3 => :mycol },
             data: { 3 => :col_content },
             actions: { 2 => { touch: :the_action } },
             particles: { color: :blue }
  },
  rows: { count: 6,
          titles: { 1 => :my_first_row, 5 => :other_row },
          data: { 0 => :col_content },
          actions: {},
          particles: { shadows: :black }
  },
  cells: {
    # data: { 0 => :here, 2 => "hello", 4 => :hi, 5 => :good, 7 => :super },
    # actions: { 2 => { touch: :my_lambda } },
    particles: { margin: 9, color: :blue, smooth: 9, shadow: { blur: 9, left: 3, top: 3 } }
  },
  exceptions: {
    columns: {
      # divided: { 2 => 3 },
      fusion: { 1 => [3, 5], 7 => [2, 5] }
    },
    rows: {
      divided: { 1 => 3 },
      fusion: { 2 => [0, 3], 5 => [2, 5] }
    }
  }
}
m = matrix(params)





# ############################################################################################################################################################################################################################
# # # ################################# Start table tests
#
# found = m.columns(5) do |el|
#   el.color(:yellow)
# end
# #
# m.rows(3) do |el|
#   el.color(:orange)
# end
# #
# m.rows(1) do |el|
#   el.color(:lightgray)
# end
# #
# found.data.each do |el|
#   el.color(:red)
# end
# #
# # found.data[0..2].each do |el|
# #   el.color(:cyan)
# # end
# #
# # grab(:my_table_21).color(:pink)
# # grab(:my_table_26).color(:purple)
# # m.cells([20, 5]).rotate(15)
# # m.cell(9).color(:black)
# # test = m.cells([23, 26])
# #
# # test.color(:blue)
# # m.columns(6).data[0..3].color(:white)
# #
# # grab(m.id.value).drag({ move: true }) do |e|
# #   puts e
# # end
# # wait 1 do
# #   m.add_columns(3)
# #   m.rows(3) do |el|
# #     el.color(:orange)
# #   end
# #     wait 1 do
# #       m.add_rows(4)
# #       m.rows(1) do |el|
# #         el.color(:lightgray)
# #       end
# #       wait 1 do
# #         found.data.each do |el|
# #           el.color(:red)
# #         end
# #         m.resize(330, 300)
# #
# #         m.fusion(rows: { 2 => [0, 3], 3 => [2, 5] })
# #       end
# #     end
# # end
# #
# #
# # m.fusion(columns: { 3=>  [3, 5], 4 => [2, 5] })
# # m.fusion(rows: { 0 => [0, 3], 3 => [5, 9] })
# # m.override( {
# #              columns: { number: [ 0, 3 ] ,width: 200},
# #              rows: { number: [ 1, 4 ] ,height: 200},
# #            })
# # m.last(:rows) do |el|
# #   el.color(:violet)
# # end
# # m.divide( rows: {1 => 3})
# # m.cell(9).box({left: 0, top: 0, id: :poireau, width: 66, height: 66})
# m.cell(9).content([box({ left: 0, top: 0, id: :poireau, width: 66, height: 66 })])
# puts  m.cell(9).content
# m.relations({ relation_1: {
#   # start: {cell_id => out_nb},
#   # end: {cell_id => in_nb},
#   start: { 9 => 2 },
#   end: { 2 => 3 }
# } })
# m.add({ relations: {
#   # start: {cell_id => out_nb},
#   # end: {cell_id => in_nb},
#   rel_2: { start: { 7 => 3 },
#     end: { 1 => 4 } }
# }
#              })
# m.delete({ relations: :rel_2 })
# # alert m.relations
# # "sourceComponent": 0,
# #   "sourceOutputSlot": 1,
# #   "targetComponent": 1,
# #   "targetInputSlot": 1
# puts m.cell(9)
# m.children.each do |child|
#   puts "#{grab(child).id} : #{grab(child).width}"
# end
#
# # alert(grab("my_table_9"))
# # grab("my_table_9").children .each do |child|
# #   grab(child).color(:white)
# # end
# matrix_ratio=m.height.value/m.width.value
# # alert prev_size
# $window.on :resize do |e|
#   # m.top(0)
#   # m.left(0)
#   # ratio_w=m.width.value/$window.view.width
#   # ratio_h=m.height.value/$window.view.height
#   # puts "=====> :#{ratio_w}"
#   # m.resize(ratio_w*$window.view.width,ratio_h*$window.view.height)
#   m.resize($window.view.width, $window.view.width*matrix_ratio)
# end
# # m.ratio(:fixed)
#
# #TODO :  add cell => style, actions, data, content, relation
# #TODO : mega important => I must have a reflection on .value
#
#
# # TODO : try matrix in a matrix's cell
# # TODO : store data, actions, and titles
# # alert m.cell(0)
# # ############################## end table tests #############
# # TODO : alteration data persistence when resizing color, and other particles are lost
#
# # generator = Genesis.generator
# ############
#
# # generator.build_option(:pre_render_parents) do |parents_ids|
# #   parents_ids.each do |parents_id|
# #     parents_found = grab(parents_id)
# #     parents_found.atome[:children] << id if parents_found
# #   end
# #   family(parents_ids)
# # end
# #
# # generator.build_option(:pre_render_children) do |children_pass|
# #   children_pass.each do |child_found|
# #     atome_found = grab(child_found)
# #     atome_found.parents([@atome[:id]])
# #   end
# # end
# #
# # generator.build_particle(:family)
# #
# # generator.build_option(:pre_render_family) do |parents_ids|
# #
# # end
# #
# # ###### render #####
# #
# # generator.build_render(:browser_family) do |parents_found|
# #   parents_found.each do |parent_found|
# #     BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
# #   end
# # end
# ############################## new attempt
# #
# # generator.build_sanitizer(:color) do |params|
# #   parent_found = found_parents_and_renderers[:parent]
# #   render_found = found_parents_and_renderers[:renderers]
# #   default_params = { renderers: render_found, id: "color_#{Universe.atomes.length}", type: :color,
# #                      parents: parent_found,children: [],
# #                      red: 0, green: 0, blue: 0, alpha: 1 }
# #   params = create_color_hash(params) unless params.instance_of? Hash
# #   new_params = default_params.merge!(params)
# #   atome[:color] = new_params
# #   new_params
# # end
# #
# # generator.build_option(:pre_render_parents) do |parents_ids|
# #   # family(parents_ids)
# # end
# # generator.build_option(:pre_render_children) do |children_pass|
# #   # children_pass.each do |child_found|
# #   #   atome_found = grab(child_found)
# #   #   atome_found.parents([@atome[:id]])
# #   # end
# # end
# # #  render
# # generator.build_render(:browser_parent) do |parents_found|
# #   # parents_found.each do |parent_found|
# #   #   BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
# #   # end
# # end
# #
# # generator.build_render(:browser_children) do |parents_found|
# #   # parents_found.each do |parent_found|
# #   #   BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
# #   # end
# # end
#
# ###########  #########
#
# # module BrowserHelper
# #   def self.browser_document
# #     # Work because of the patched version of opal-browser(0.39)
# #     Browser.window
# #   end
# #
# #   def self.browser_attach_div(parents, html_object, _atome)
# #     html_object.append_to(browser_document[parents])
# #   end
# #
# #   def self.browser_attach_style(parents, _html_object, atome)
# #     browser_document[parents].add_class(atome[:id])
# #   end
# # end
#
# # generator.build_option(:pre_render_parents) do |parents_ids|
# #   parents_ids.each do |parents_id|
# #     if parents_id.instance_of? Atome
# #       parents_id = parents_id.value
# #     end
# #     parents_found = grab(parents_id)
# #     family(parents_id)
# #     parents_found.atome[:children] << atome[:id]
# #   end
# # end
# #
# # generator.build_option(:pre_render_children) do |children_ids|
# #   children_ids.each do |child_id|
# #     if child_id.instance_of? Atome
# #       child_id = child_id.value
# #     end
# #     child_found = grab(child_id)
# #     parents_found=@atome[:id]
# #     child_found.family(parents_found)
# #     child_found.atome[:parents] = [parents_found]
# #   end
# # end
# #
#
# # generator.build_particle(:family, { render: true, store: false })
# # generator.build_render(:browser_family) do |parents_found|
# #   BrowserHelper.send("browser_attach_#{@browser_type}", parents_found, @browser_object, @atome)
# # end
#
# # class Universe
# #   def add_to_atomes(id, atome)
# #     # instance_variable_get('@atomes').merge!(atome)
# #     @atomes[id] = atome
# #   end
# #
# #   def update_atome_id(id, atome, prev_id)
# #     puts :ok
# #     @atomes[id] = atome
# #     @atomes.delete(prev_id)
# #   end
# # end
#
# # generator.build_sanitizer(:id) do |params|
# #   if @atome[:id] != params
# #     Universe.update_atome_id(params, self, @atome[:id])
# #   else
# #     Universe.add_to_atomes(params, self)
# #   end
# #   params
# # end
# #
# # generator.build_render(:browser_id) do |params|
# #   browser_object.id = params if @atome[:id] != params
# # end
#
#
#
# # b = box({ id: :titi })
# # c = color(:orange)
# # c.id(:tutu)
# # b.children([:tutu])
#
#
# # alert b.children
# # alert b
# # b.circle({id: :toto})
# # grab(:box_color).parents([:titi])
# # b.children([:box_color])
# # alert b
#
# # generator.build_render(:browser_parents) do |parents_found|
# #   # p :number_parents
# #   # parents_found.each do |parent_found|
# #   #   BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
# #   # end
# # end
# #
# # generator.build_render(:browser_children) do |children_found|
# #   # p :number_children
# #   # children_found.each do |child_found|
# #   #   BrowserHelper.send("browser_attach_#{@browser_type}", child_found, @browser_object, @atome)
# #   # end
# # end
#
# # b = box({ id: :the_test_box })
# # i = 0
# # while i < 9
# #   # puts :ok
# #   box({ left: i * 30, width: 9 })
# #   i += 1
# # end
# # # c = color({red: 0, green: 1, blue: 0.3, alpha: 1, id: :thcol, children: []})
# # c = color(:red)
# # # alert a
# # # wait 1 do
# # b.children([c.id])
# # # c.parents([b.id])
# # # puts "box is :\n#{b}\n\n color is :\n#{c}"
# #
# # puts '-----'
# # puts "familly content #{b.family}"
# # # end
#
# # generator.build_option(:pre_render_parents) do |parents_ids|
# #   parents_ids.each do |parents_id|
# #     parents_found = grab(parents_id)
# #     parents_found.atome[:children]<< id if parents_found
# #   end
# #   family({parents: parents_ids, children: [] })
# # end
# #
# #
# # #mess below
# # generator.build_option(:pre_render_children) do |children_ids|
# #   children_ids.each do |child_found|
# #     atome_found = grab(child_found)
# #     atome_found.atome[:parents]=[@atome[:id]]
# #   end
# #   # family({children: children_ids, parents: [] })
# # end
# #
# #
# # generator.build_particle(:family)
# #
# #
# # ####################
# # generator.build_render(:browser_family) do |params|
# #   # puts "kool super kool! : #{parents_found} , type : #{@browser_type}, object : #{@browser_object} ,atome : #{@atome}"
# #   # puts "atome : #{@atome[:id]}, parent  : #{parents_found}}"
# #   # puts "atome : #{@atome} : #{params[:parents]}"
# #   puts " #{params[:parents]}"
# #   parents_found=params[:parents]
# #   children_found=params[:children]
# #   parents_found.each do |parent_found|
# #     # atome=
# #     BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
# #   end
# #
# #   children_found.each do |parent_found|
# #     BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
# #   end
# #
# # end
# #
# # generator.build_render(:browser_parents) do |parents_found|
# #   # puts "moinskool super kool! : #{parents_found} "
# #   # puts "moinskool super kool! : #{parents_found} , type : #{@browser_type}, object : #{@browser_object} ,atome : #{@atome}"
# #   # parents_found.each do |parent_found|
# #   #   BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
# #   # end
# # end
#
# ###################
# # class Atome
# #
# #   def store_value(element)
# #     params=instance_variable_get("@#{element}")
# #     @atome[element] = params
# #   end
# #
# #   def build_particle(particle_name,options,&particle_proc)
# #     type = options[:type]
# #     type = :string if options[:type].nil?
# #     store = options[:store]
# #     store = true if options[:store].nil?
# #     render = options[:render]
# #     render = true if options[:render].nil?
# #
# #     # we add the new method to the particle's collection of methods
# #     Universe.add_to_particle_list(particle_name, type)
# #     auto_render_generator(particle_name) if render #  automatise the creation of an empty render method for current particle
# #     new_particle(particle_name,store,render , &particle_proc)
# #     additional_particle_methods(particle_name, &particle_proc) # create alternative methods such as create 'method='
# #   end
# #
# #   def additional_particle_methods(element, &method_proc)
# #     Atome.define_method "#{element}=" do |params = nil, &user_proc|
# #       instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
# #     end
# #   end
# #
# #   def new_particle(element,store,render, &method_proc)
# #     Atome.define_method element do |params = nil, &user_proc|
# #       if params || params == false
# #         # the line below execute the proc created when using the build_particle method
# #         instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
# #         params = sanitize(element, params)
# #         create_particle(element,store,render)
# #         send("set_#{element}", params, &user_proc)
# #       else
# #         get_particle(element, &user_proc)
# #       end
# #     end
# #   end
# #   def run_optional_proc(proc_name, atome = self, element, &user_proc)
# #     params=instance_variable_get("@#{element}")
# #     option_found = Universe.get_optional_method(proc_name)
# #     atome.instance_exec(params, user_proc, atome, &option_found) if option_found.is_a?(Proc)
# #   end
# #
# #   def rendering(element, &user_proc)
# #     params=instance_variable_get("@#{element}")
# #     render_engines = @atome[:renderers]
# #     render_engines.each do |render_engine|
# #       send("#{render_engine}_#{element}", params, &user_proc)
# #     end
# #   end
# #
# #   def broadcasting(element)
# #     params=instance_variable_get("@#{element}")
# #     @broadcast.each_value do |particle_monitored|
# #       if particle_monitored[:particles].include?(element)
# #         code_found=particle_monitored[:code]
# #         instance_exec(self, element, params, &code_found) if code_found.is_a?(Proc)
# #       end
# #     end
# #   end
# #
# #   def particle_creation(element, params,store,render, &user_proc)
# #     return false unless security_pass(element, params)
# #     # we create a proc holder of any new particle if user pass a bloc
# #     store_code_bloc(element, &user_proc) if user_proc
# #     # Params is now an instance variable so it should be passed thru different methods
# #     instance_variable_set("@#{element}", params)
# #     run_optional_proc("pre_render_#{@atome[:type]}".to_sym, self, element, &user_proc)
# #     run_optional_proc("pre_render_#{element}".to_sym, self, element, &user_proc)
# #     rendering(element, &user_proc) if render
# #     run_optional_proc("post_render_#{@atome[:type]}".to_sym, self, element, &user_proc)
# #     run_optional_proc("post_render_#{element}".to_sym, self, element, &user_proc)
# #     broadcasting(element)
# #     store_value(element) if store
# #     self
# #   end
# #
# #   def create_particle(element,store,render)
# #     Atome.define_method "set_#{element}" do |params, &user_proc|
# #       particle_creation(element, params, store,render,&user_proc)
# #     end
# #   end
# #
# # end



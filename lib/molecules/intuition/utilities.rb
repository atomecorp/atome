# frozen_string_literal: true

class Atome
  def reorder_menu
    disposition = data[:inactive][:disposition]
    margin = data[:inactive][:margin]
    spacing = data[:inactive][:spacing]
    inactive_style = data[:inactive]
    keys_to_exclude = [:margin, :spacing, :disposition, :text]
    inactive_style = inactive_style.reject { |key, _| keys_to_exclude.include?(key) }
    fasten.each_with_index do |atome_f, index|
      menu_item = grab(atome_f)
      if disposition == :horizontal
        menu_item.left = margin[:left] + (inactive_style[:width] + spacing) * index
        menu_item.top = margin[:top]
      else
        menu_item.top = margin[:top] + (inactive_style[:height] + spacing) * index
        menu_item.left = margin[:left]
      end
    end
  end

  def reorder_blocs
    @prev_bloc_height = 0
    fasten.each do |bloc_f|
      potential_bloc = grab(bloc_f)
      spacing = potential_bloc.spacing
      if potential_bloc.role && potential_bloc.role.include?(:block)
        potential_bloc.top(spacing + @prev_bloc_height)
        @prev_bloc_height = @prev_bloc_height + potential_bloc.height + spacing
      end
    end
  end

  def remove_menu_item(item_to_remove)
    grab(item_to_remove).delete(recursive: true)
    reorder_menu
  end

  def create_new_button(button_id, position_in_menu, label, code)
    essential_keys = [:inactive, :active]
    buttons_style = data.select { |key, _value| essential_keys.include?(key) }
    menu_item = box({ id: button_id })
    actor({ button_id => :button })
    menu_item.role(:button)
    menu_item.text({ data: label, id: "#{button_id}_label" })
    menu_item.code({ button_code: code })

    inactive_style = buttons_style[:inactive]
    active_style = buttons_style[:active]
    if active_style
      active_state_text = active_style[:text]
      keys_to_exclude = [:margin, :spacing, :disposition, :text]

      active_style = active_style.reject { |key, _| keys_to_exclude.include?(key) }
    end

    if inactive_style
      inactive_state_text = inactive_style[:text]
      margin = inactive_style[:margin]
      spacing = inactive_style[:spacing]
      disposition = inactive_style[:disposition]
      keys_to_exclude = [:margin, :spacing, :disposition, :text]
      inactive_style = inactive_style.reject { |key, _| keys_to_exclude.include?(key) }
      menu_item.set(inactive_style)

      # reorder_menu
      if disposition == :horizontal
        menu_item.left = margin[:left] + (inactive_style[:width] + spacing) * position_in_menu
        menu_item.top = margin[:top]
      else
        menu_item.top = margin[:top] + (inactive_style[:height] + spacing) * position_in_menu
        menu_item.left = margin[:left]
      end

      menu_item.text.each do |text_f|
        grab(text_f).set(inactive_state_text)
      end

    end

    menu_item.touch(:down) do
      unless @active_item == menu_item.id

        menu_item.text.each do |text_f|
          # below we unset any active style
          fasten.each do |item_id|
            unless button_id == item_id
              grab(item_id).remove({ all: :shadow })
              grab(item_id).set(inactive_style)
              grab("#{item_id}_label").remove({ all: :shadow })
              grab("#{item_id}_label").set(inactive_state_text)
            end
            grab(text_f).set(active_state_text)
          end

        end
        menu_item.set(active_style)
        code&.call
        @active_item = menu_item.id
      end

    end

  end

  def add_button(params)
    params.each do |button_id, params|
      label = params[:text]
      code = params[:code]
      index = fasten.length
      create_new_button(button_id, index, label, code)
    end
    false
  end

  def resize_matrix(params)
    width(params[:width])
    height(params[:height])
    current_matrix = self
    real_width = current_matrix.to_px(:width)
    real_height = current_matrix.to_px(:height)
    spacing = current_matrix.data[:spacing]
    matrix_cells = current_matrix.data[:matrix]

    total_spacing_x = spacing * (matrix_cells.collect.length ** (0.5) + 1)
    total_spacing_y = spacing * (matrix_cells.collect.length ** (0.5) + 1)

    if real_width > real_height
      full_size = real_width
      available_width = full_size - total_spacing_x
      available_height = full_size - total_spacing_y
    else
      full_size = real_width
      available_width = full_size - total_spacing_x
      available_height = full_size - total_spacing_y
    end

    box_width = available_width / matrix_cells.collect.length ** (0.5)
    box_height = available_height / matrix_cells.collect.length ** (0.5)

    matrix_cells.collect.each_with_index do |box_id, index|
      box = grab(box_id)
      box.width(box_width)
      box.height(box_height)
      box.left((box_width + spacing) * (index % matrix_cells.collect.length ** (0.5)) + spacing)
      box.top((box_height + spacing) * (index / matrix_cells.collect.length ** (0.5)).floor + spacing)
    end

  end
end

new(molecule: :input) do |params, bloc|
  params[:height] ||= 15
  params[:width] ||= 222
  new_id = params.delete(:id) || identity_generator
  trigger = params.delete(:trigger)
  trigger ||= :return
  limit = params.delete(:limit)
  limit ||= 15
  back_col = params.delete(:back)
  back_col ||= :grey
  text_params = params.delete(:text)
  text_params ||= {}
  default_text = params.delete(:default)
  component = params.delete(:component)
  default_text ||= :input
  default_parent = if self.instance_of?(Atome)
                     id
                   else
                     :view
                   end
  attach_to = params[:attach] || default_parent
  renderer_found = grab(attach_to).renderers
  input_back = Atome.new(
    { renderers: renderer_found, id: new_id, type: :shape, color: back_col,
      left: 0, top: 0, data: '', attach: attach_to,
      smooth: 6, overflow: :hidden,
    })

  text_input = Atome.new(
    { renderers: [:html], type: :text, component: component,
      data: default_text, left: params[:height] * 20 / 100, top: 0, edit: true, attach: input_back.id, height: params[:height],
      position: :absolute
    }.merge(text_params)
  )
  text_input.touch(:down) do
    input_back.tick(:input)
    text_input.edit(true)
  end

  input_back.touch(:up) do
    text_input.component({ selected: true }) if input_back.tick[:input] == 1
  end

  text_input.keyboard(:down) do |native_event|
    event = Native(native_event)
    if event[:keyCode].to_s == '8' || event[:keyCode].to_s == '46'
      # always allow
    elsif event[:keyCode].to_s == '13'
      # we prevent the input
      bloc.call(text_input.data) if trigger == :return
      text_input.edit(false)
      event.preventDefault()
    elsif text_input.data.length > limit
      event.preventDefault()
    end
    bloc.call(text_input.data) if trigger == :down
  end

  text_input.keyboard(:up) do |_native_event|
    input_back.data = text_input.data
    bloc.call(text_input.data) if trigger == :up
  end
  params.each do |part_f, val_f|
    input_back.send(part_f, val_f)
  end
  input_back.holder(text_input)
  input_back
end

new(molecule: :list) do |params, _bloc|
  styles_found = params.delete(:styles)
  element = params.delete(:element)
  listing = params.delete(:listing)
  action = params.delete(:action)
  new_id = params.delete(:id) || identity_generator
  styles_found ||= {
    width: 99,
    height: 33,
    margin: 6,
    shadow: { blur: 9, left: 3, top: 3, id: :cell_shadow, red: 0, green: 0, blue: 0, alpha: 0.6 },
    left: 0,
    color: :yellowgreen
  }
  element ||= { width: 33,
                height: 33,
                left: :center,
                top: :center,
                color: :orange,
                type: :text }
  params[:width] = styles_found[:width] unless params[:width]
  element[:width] = styles_found[width] unless element[:width]
  margin = styles_found[:margin]
  height_found = styles_found[:height]

  # lets create the listing container
  default_parent = if self.instance_of?(Atome)
                     id
                   else
                     :view
                   end
  attach_to = params[:attach] || default_parent
  renderer_found = grab(attach_to).renderers
  list = Atome.new({ renderers: renderer_found, id: new_id, type: :shape, color: { alpha: 0 }, attach: attach_to }.merge(params))

  # now the listing
  listing.each_with_index do |data, index|
    # let's create the container
    new_atome = { renderers: renderer_found, attach: list.id }.merge(styles_found).merge({ type: :shape })

    el = Atome.new(new_atome)
    if action
      el.touch(action[:touch]) do
        send(action[:method], data)
      end
    end
    el.top((height_found + margin) * index)
    # now the content
    Atome.new({ renderers: renderer_found, attach: el.id }.merge(element).merge(data))

  end
  list
end

new({ molecule: :slider }) do |params, bloc|

  default_value = params[:value] ||= 0
  orientation = params.delete(:orientation) || :horizontal
  range_found = params.delete(:range)
  min_value = params.delete(:min) || 0
  max_value = params.delete(:max) || 100
  color_found = params[:color] ||= :gray
  new_id = params.delete(:id) || identity_generator

  default_smooth = 9
  default_slider_particles = { id: new_id, color: color_found, width: 333, height: 33, left: 0, top: 0,
                               smooth: default_smooth, tag: { system: true } }
  default_cursor_particles = { color: color_found, width: 29, height: 29, left: 0, smooth: '100%', tag: { system: true } }
  cursor_found = params.delete(:cursor)
  slider_particle = default_slider_particles.merge(params)
  slider = box(slider_particle)
  slider.remove(:box_color)
  slider_shadow = slider.shadow({
                                  id: :s2,
                                  left: 3, top: 3, blur: 9,
                                  invert: true,
                                  red: 0, green: 0, blue: 0, alpha: 0.7
                                })

  range = slider.box({ id: "#{slider.id}_range", top: :auto, bottom: 0, tag: { system: true } })
  range.remove(:box_color)
  if range_found
    range.apply(slider_shadow.id,)
    range_found.each do |part, val|
      range.send(part, val)
    end
  else
    range.color({ alpha: 0 })
  end
  cursor_particle = default_cursor_particles.merge(cursor_found).merge({ id: "#{slider.id}_cursor" })
  cursor = slider.box(cursor_particle)
  cursor.remove(:box_color)
  cursor_left = (slider_particle[:width] - cursor_particle[:width]) / 2.0
  cursor_top = (slider_particle[:height] - cursor_particle[:height]) / 2.0

  my_behavior = lambda() do |new_value|
    if orientation == :vertical
      if cursor.width < slider.width
        range.width(cursor.width)
        range.left(cursor_left)
      else
        range.width(slider.width)
        range.smooth(default_smooth)
      end
      cursor_top_initial = ((max_value - new_value).to_f / (max_value - min_value)) * (slider_particle[:height] - cursor_particle[:height])
      bloc.call(new_value)
      slider.instance_variable_set('@value', new_value)
      cursor.top(cursor_top_initial)
      cursor.left(cursor_left)
      range.height((slider.height - cursor.top) - cursor.height / 2)
    else
      if cursor.height < slider.height
        range.height(cursor.height)
        range.top(cursor_top)
      else
        range.height(slider.height)
        range.smooth(default_smooth)
      end
      cursor_left_initial = ((new_value - min_value).to_f / (max_value - min_value)) * (slider_particle[:width] - cursor_particle[:width])
      bloc.call(new_value)
      slider.instance_variable_set('@value', new_value)
      cursor.left(cursor_left_initial)
      cursor.top(cursor_top)
      range.width(cursor.left + cursor.width / 2)
    end
  end
  slider.behavior({ value: my_behavior })

  update_value = lambda do |cursor_position, cursor_size, slider_size, orientation|
    effective_slider_size = slider_size - cursor_size
    percentage = if orientation == :vertical
                   1.0 - (cursor_position.to_f / effective_slider_size)
                 else
                   cursor_position.to_f / effective_slider_size
                 end
    value_range = max_value - min_value
    calculated_value = min_value + (value_range * percentage).round
    calculated_value.clamp(min_value, max_value)
  end

  if orientation == :vertical
    if cursor.width < slider.width
      range.width(cursor.width)
      range.left(cursor_left)
    else
      range.width(slider.width)
      range.smooth(default_smooth)
    end

    cursor_top_initial = ((max_value - default_value).to_f / (max_value - min_value)) * (slider_particle[:height] - cursor_particle[:height])
    bloc.call(default_value)
    cursor.top(cursor_top_initial)
    cursor.left(cursor_left)
    range.height((slider.height - cursor.top) - cursor.height / 2)
    # now the event
    cursor.drag({ restrict: { max: { top: slider_particle[:height] - cursor_particle[:height], left: cursor_left }, min: { left: cursor_left } } }) do |event|
      value = update_value.call(cursor.top, cursor_particle[:height], slider_particle[:height], orientation)
      range.height((slider.height - cursor.top) - cursor.height / 2)
      bloc.call(value)
      slider.instance_variable_set('@value', value)
    end

  else

    if cursor.height < slider.height
      range.height(cursor.height)
      range.top(cursor_top)
    else
      range.height(slider.height)
      range.smooth(default_smooth)
    end

    cursor_left_initial = ((default_value - min_value).to_f / (max_value - min_value)) * (slider_particle[:width] - cursor_particle[:width])
    bloc.call(default_value)
    cursor.left(cursor_left_initial)
    cursor.top(cursor_top)
    range.width(cursor.left + cursor.width / 2)

    # now the event
    cursor.drag({ restrict: { max: { left: slider_particle[:width] - cursor_particle[:width], top: cursor_top }, min: { top: cursor_top } } }) do |event|
      value = update_value.call(cursor.left, cursor_particle[:width], slider_particle[:width], orientation)
      range.width(cursor.left + cursor.width / 2)
      bloc.call(value)
      slider.instance_variable_set('@value', value)
    end
  end
  cursor.touch(:double) do
    slider.value(default_value)
  end

  cursor.shadow({
                  id: :s4,
                  left: 1, top: 1, blur: 3,
                  option: :natural,
                  red: 0, green: 0, blue: 0, alpha: 0.6
                })
  slider

end

new({ particle: :cells })

new(molecule: :matrix) do |params, &bloc|
  params ||= {}
  # We test if self is main if so we attach the matrix to the view
  parent_found = if self == self
                   grab(:view)
                 else
                   self
                 end

  id = params[:id] || identity_generator
  rows = params[:rows] || 8
  columns = params[:columns] || 8
  spacing = params[:spacing] || 6
  size = params[:size] || '100%'

  # parent_found = self
  current_matrix = group({ id: id })

  current_matrix.data({ spacing: spacing, size: size })
  matrix_cells = []
  total_spacing_x = spacing * (rows + 1)
  total_spacing_y = spacing * (columns + 1)
  size_coefficient = if size.instance_of? String
                       size.end_with?('%') ? (size.to_f / 100) : size.to_f / parent_found.to_px(:width)
                     else
                       size.to_f / parent_found.to_px(:width)
                     end
  view_width = parent_found.to_px(:width)
  view_height = parent_found.to_px(:height)
  matrix_back = box({ id: "#{id}_background", width: size, height: size, color: { alpha: 0 } })
  matrix_back.remove(:box_color)
  if view_width > view_height
    full_size = view_height * size_coefficient
    available_width = full_size - total_spacing_x
    available_height = full_size - total_spacing_y
    matrix_back.width(full_size)
    matrix_back.height(full_size)
  else
    full_size = view_width * size_coefficient
    available_width = full_size - total_spacing_x
    available_height = full_size - total_spacing_y
    matrix_back.width(full_size)
    matrix_back.height(full_size)
  end
  box_width = available_width / rows
  box_height = available_height / columns

  columns.times do |y|
    rows.times do |x|
      id_generated = "#{id}_#{x}_#{y}"
      matrix_cells << id_generated
      new_box = matrix_back.box({ id: id_generated })
      new_box.width(box_width)
      new_box.height(box_height)
      new_box.left((box_width + spacing) * x + spacing)
      new_box.top((box_height + spacing) * y + spacing)
    end
  end
  current_matrix.collect(matrix_cells)
  matrix_back.cells(current_matrix)
  params = params.merge({ matrix: current_matrix })
  matrix_back.data(params)
  matrix_back
end

new(molecule: :application) do |params, &bloc|
  params ||= {}

  color({ id: :app_color, red: 0.1, green: 0.3, blue: 0.1 })
  # TODO : remove the patch below when possible
  id_f = if params[:id]
           params.delete(:id)
         else
           identity_generator
         end

  main_app = box({ id: id_f, width: :auto, height: :auto, top: 0, bottom: 0, left: 0, right: 0, apply: :app_color,
                   category: :application })
  main_app.remove(:box_color)
  main_app.instance_variable_set('@pages', {})
  main_app.role(:application)

  menu = buttons({
                   id: "#{id_f}_menu",
                   # left: 66,
                   depth: 9999,
                   attach: id_f,
                   inactive: { text: { color: :gray }, width: 66, height: 12, spacing: 3, disposition: :horizontal,
                               color: :orange, margin: { left: 33, top: 12 } },
                   active: { text: { color: :white, shadow: {} }, color: :blue, shadow: {} },
                 })
  main_app.define_singleton_method(:menu) do
    menu
  end
  main_app.define_singleton_method(:pages) do
    @pages
  end

  main_app.define_singleton_method(:insert) do |bloc_to_add|
    bloc_to_add.each do |page_id, params_f|

      params_f.each do |block_id, block_content|
        @pages[page_id][:blocks] ||= {}
        @pages[page_id][:blocks][block_id.to_sym] = block_content
      end
      @blocks ||= {}
      @blocks[page_id] = @pages[page_id][:blocks]
    end

  end
  main_app.define_singleton_method(:extract) do |bloc_to_extract|

      bloc_to_extract.each do |page_id, block_id|
        grab(block_id).delete({ recursive: true })
        @blocks[page_id].delete(block_id)
        grab(page_id).reorder_blocs
    end

  end

  main_app.define_singleton_method(:blocks) do
    @blocks
  end
  main_app.define_singleton_method(:margin) do
    @margin = params[:margin]
  end
  main_app.define_singleton_method(:spacing) do
    @spacing = params[:spacing]
  end

  main_app
end

new(molecule: :page) do |params = nil, &bloc|
  allow_menu = params.delete(:menu)
  if params[:id]
    id_f = params.delete(:id)
    page_name = params.delete(:name)
    @pages[id_f.to_sym] = params
  else
    puts "must send an id"
  end
  page_name = page_name || id_f
  item_code = lambda do
    show(id_f)
  end
  unless allow_menu == false
    menu_f = grab("#{@id}_menu")
    menu_f.add_button({ "#{@id}_menu_item_#{page_name}" => {
      text: page_name,
      code: item_code
    } })
    actor({ "#{@id}_menu_item_#{page_name}" => :buttons })
  end
end

new(molecule: :show) do |page_id, &bloc|

  params = @pages[page_id.to_sym]
  params ||= {}
  footer = params.delete(:footer)
  header = params.delete(:header)
  left_side_bar = params.delete(:left_side_bar)
  right_side_bar = params.delete(:right_side_bar)
  basic_size = 30
  fasten.each do |page_id_found|
    page_found = grab(page_id_found)
    page_found.delete({ recursive: true }) if page_found&.category&.include?(:page)
  end
  color({ id: :page_color, red: 0.1, green: 0.1, blue: 0.1 })

  id_f = "#{id}_content"
  main_page = box({ width: :auto, depth: -1, height: :auto, id: id_f, top: 0, bottom: 0, left: 0, right: 0, apply: :page_color, category: :page })
  main_page.remove(:box_color)

  new_page = main_page.box({ width: '100%', height: '100%', top: 0, left: 0, id: page_id })

  # now looking for associated blocks
  blocks_found = params[:blocks]
  @prev_bloc_height = 0
  blocks_found&.each do |bloc_id, bloc_content|
    new_bloc = new_page.box({ id: bloc_id, role: :block, width: '100%', height: 99, top: spacing + @prev_bloc_height, bottom: 0, left: 0, right: 0, spacing: spacing })
    new_bloc.define_singleton_method(:subs) do |sub_params|
      new_bloc.sub_block(sub_params)
    end
    new_bloc.set(bloc_content)
    @prev_bloc_height = @prev_bloc_height + new_bloc.height + spacing
  end

  keys_to_exclude = [:blocks]
  particles_to_apply = params.reject { |key, _| keys_to_exclude.include?(key) }

  new_page.set(particles_to_apply)
  if footer
    new_footer = box({ left: 0, depth: 999, right: 0, width: :auto, top: :auto, bottom: 0, height: basic_size, category: :footer, id: "#{id_f}_footer" })
    new_footer.remove(:box_color)
    new_footer.set(footer)
  end

  if header
    new_header = box({ left: 0, right: 0, depth: 999, width: :auto, top: 0, height: basic_size, category: :header, id: "#{id_f}_header" })
    new_header.remove(:box_color)
    new_header.set(header)
  end

  if right_side_bar
    new_right_side_bar = box({ left: :auto, depth: 999, right: 0, width: basic_size, top: 0, bottom: 0, height: :auto, category: :right_side_bar, id: "#{id_f}_right_side_bar" })
    new_right_side_bar.remove(:box_color)
    new_right_side_bar.set(right_side_bar)
  end

  if left_side_bar
    new_left_side_bar = box({ left: 0, right: :auto, depth: 999, width: basic_size, top: 0, bottom: 0, height: :auto, category: :left_side_bar, id: "#{id_f}_left_side_bar" })
    new_left_side_bar.remove(:box_color)
    new_left_side_bar.set(left_side_bar)
  end

  fasten.each do |item_id_found|
    item_found = grab(item_id_found)
    if item_found&.category&.include?(:footer)
      main_page.height(:auto)
      main_page.bottom(item_found.height)
    end
    if item_found&.category&.include?(:header)
      main_page.height(:auto)
      main_page.top(item_found.height)
    end

    if item_found&.category&.include?(:right_side_bar)
      main_page.width(:auto)
      main_page.left(item_found.width)
      grab("#{id_f}_footer").right(basic_size) if footer
      grab("#{id_f}_header").right(basic_size) if header
    end

    if item_found&.category&.include?(:left_side_bar)
      main_page.width(:auto)
      main_page.right(item_found.width)
      grab("#{id_f}_footer").left(basic_size) if footer
      grab("#{id_f}_header").left(basic_size) if header
    end
  end
  main_page
end



new(molecule: :buttons) do |params, &bloc|

  keys_to_keep = [:inactive, :active]
  remaining_params = remove_key_pair_but(params, keys_to_keep)
  params = filter_keys_to_keep(params, keys_to_keep)

  role_f = params.delete(:role)
  actor_f = params.delete(:actor)
  params_saf = deep_copy(params)
  context = remaining_params.delete(:attach) || :view
  id_f = remaining_params.delete(:id) || identity_generator
  main = grab(context).box({ id: id_f })
  main.set(remaining_params)

  main.role(role_f) || main.role(:buttons)
  main.actor(actor_f) if actor_f
  main.color({ blue: 0.5, red: 1, green: 1, alpha: 0 })
  main.data(params_saf)
  default = params.delete(:inactive) || {}
  main.data[:default] = default
  default_text = default.delete(:text)
  main.data[:default_text] = default_text
  active = params.delete(:active) || {}
  inactive = {}
  active.each_key do |part_f|
    inactive[part_f] = default[part_f]
  end
  inactive_text = {}
  active.each_key do |part_f|
    inactive_text[part_f] = default_text[part_f]
  end
  params.each_with_index do |(item_id, part_f), index|
    label = part_f[:text]
    code = part_f[:code]
    main.create_new_button(item_id, index, label, code)
  end
  main

end
# frozen_string_literal: true

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
  # component ||= {}

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
  # text_input.set()
  text_input.touch(:down) do
    input_back.tick(:input)
    text_input.edit(true)
  end

  input_back.touch(:up) do
    if input_back.tick[:input] == 1
      text_input.component({ selected: true })
    end
  end

  text_input.keyboard(:down) do |native_event|
    # text_input.component({ selected: { color: :red, text: :red } })

    event = Native(native_event)
    if event[:keyCode].to_s == '8' || event[:keyCode].to_s == '46'
      # always allow
    elsif event[:keyCode].to_s == '13'
      # we prevent the input
      if trigger == :return
        bloc.call(text_input.data)
      end
      text_input.edit(false)
      event.preventDefault()
    elsif text_input.data.length > limit
      event.preventDefault()
    end
    if trigger == :down
      bloc.call(text_input.data)
    end
  end

  text_input.keyboard(:up) do |native_event|
    input_back.data = text_input.data
    if trigger == :up
      bloc.call(text_input.data)
    end
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
  unless params[:width]
    params[:width] = styles_found[:width]
  end
  unless element[:width]
    element[:width] = styles_found[width]
  end
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

  range = slider.box({ id: "#{slider.id}_range", top: :auto, bottom: 0,tag: { system: true } })
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
new(molecule: :button) do |params, bloc|
  params[:height] ||= 25
  params[:width] ||= 25
  states = params.delete(:states) || 1
  new_id = params.delete(:id) || identity_generator

  back_col = params.delete(:back)
  back_col ||= :grey

  default_parent = if self.instance_of?(Atome)
                     id
                   else
                     :view
                   end
  attach_to = params[:attach] || default_parent
  renderer_found = grab(attach_to).renderers
  button = box(
    { renderers: renderer_found, id: new_id, type: :shape, color: back_col,
      left: 0, top: 0, data: '', attach: attach_to,
      smooth: 3, overflow: :hidden,tag: { system: true }
    })
  button.remove(:box_color)
  button.touch(:down) do
    button.tick(:button)
    bloc.call((button.tick[:button] - 1) % states)

  end

  params.each do |part_f, val_f|
    button.send(part_f, val_f)
  end

  button
end

new({ particle: :cells })

class Atome
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
  menu = params.delete(:menu)
  main_app.box(menu.merge({ id: "#{id_f}_menu" })) if menu
  params.each do |part_f, val_f|
    main_app.send(part_f, val_f)
  end
  main_app
end

new(molecule: :page) do |params, &bloc|
  if params[:id]
    id_f = params.delete(:id)
    page_name=params.delete(:name)
    @pages[id_f.to_sym] = params
  else
    puts "must send an id"
  end
  page_name= page_name || id_f
  menu_f= grab("#{@id}_menu")
  page_title=menu_f.text({ data: page_name })
  page_title.touch(:down) do
    show(id_f)
  end

end

new(molecule: :show) do |page_id, &bloc|
  params = @pages[page_id.to_sym]
  params ||= {}
  footer = params.delete(:footer)
  header = params.delete(:header)
  left_side_bar = params.delete(:left_side_bar)
  right_side_bar = params.delete(:right_side_bar)
  # modules = params.delete(:modules)
  basic_size = 30
  attached.each do |page_id_found|
    page_found = grab(page_id_found)
    # puts "#{page_id_found} : #{page_found}"
    page_found.delete({ recursive: true }) if page_found && page_found.category.include?(:page)
  end
  color({ id: :page_color, red: 0.1, green: 0.1, blue: 0.1 })
  # TODO : remove the patch below when possible
  id_f = if params[:id]
           params.delete(:id)
         else
           "#{id_f}_#{identity_generator}"
         end
  main_page = box({ width: :auto, depth: -1, height: :auto, id: id_f, top: 0, bottom: 0, left: 0, right: 0, apply: :page_color, category: :page })
  main_page.remove(:box_color)

  main_page.set(params)

  if footer
    new_footer = box({ left: 0, depth: -1, right: 0, width: :auto, top: :auto, bottom: 0, height: basic_size, category: :footer, id: "#{id_f}_footer" })
    new_footer.remove(:box_color)
    new_footer.set(footer)
  end

  if header
    new_header = box({ left: 0, right: 0, depth: -1, width: :auto, top: 0, height: basic_size, category: :header, id: "#{id_f}_header" })
    new_header.remove(:box_color)
    new_header.set(header)
  end

  if right_side_bar
    new_right_side_bar = box({ left: :auto, depth: -1, right: 0, width: basic_size, top: 0, bottom: 0, height: :auto, category: :right_side_bar, id: "#{id_f}_right_side_bar" })
    new_right_side_bar.remove(:box_color)
    new_right_side_bar.set(right_side_bar)
  end

  if left_side_bar
    new_left_side_bar = box({ left: 0, right: :auto, depth: -1, width: basic_size, top: 0, bottom: 0, height: :auto, category: :left_side_bar, id: "#{id_f}_left_side_bar" })
    new_left_side_bar.remove(:box_color)
    new_left_side_bar.set(left_side_bar)
  end

  attached.each do |item_id_found|
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
      if footer
        grab("#{id_f}_footer").right(basic_size)
      end
      if header
        grab("#{id_f}_header").right(basic_size)
      end
    end

    if item_found&.category&.include?(:left_side_bar)
      main_page.width(:auto)
      main_page.right(item_found.width)
      if footer
        grab("#{id_f}_footer").left(basic_size)
      end
      if header
        grab("#{id_f}_header").left(basic_size)
      end
    end
  end
  main_page
end

new(molecule: :buttons) do |params, &bloc|
  parent = params.delete(:attach) || :view
  default = params.delete(:inactive) || {}
  default_text=default.delete(:text)
  active = params.delete(:active) || {}
  active_text=active.delete(:text)
  inactive = {}
  active.each_key do |part_f|
    inactive[part_f] = default[part_f]
  end
  inactive_text = {}
  active.each_key do |part_f|
    inactive_text[part_f] = default_text[part_f]
  end
  disposition = default.delete(:disposition)
  attach_to = grab(parent)

  params.each_with_index do |(item_id, part_f), index|
    code_f = part_f.delete(:code)
    menu_item = attach_to.box({ id: item_id })
    text_found= part_f.delete(:text)
    menu_item.text({ data: text_found, id: "#{item_id}_label" })
    menu_item.set(part_f)
    if disposition == :horizontal
      menu_item.left = (default[:margin][:left] + default[:spacing]) * index
      menu_item.top = default[:margin][:top]
    else
      menu_item.top = (default[:margin][:top] + default[:spacing]) * index
      menu_item.left = default[:margin][:left]
    end
    menu_item.set(default)
    menu_item.text.each do |text_f|
      grab(text_f).set(default_text)
    end

    menu_item.touch(:down) do
      menu_item.set(active)
      menu_item.text.each do |text_f|
        grab(text_f).set(active_text)
      end
      params.each_key do |menu_id|
        unless menu_id == item_id
          grab(menu_id).replace(inactive)
          grab("#{menu_id}_label").replace(inactive_text)
        end
      end
      code_f.call if code_f
    end
  end
end
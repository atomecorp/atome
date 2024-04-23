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
  text_col = params.delete(:text)
  text_col ||= :black
  default_text = params.delete(:default)
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
    { renderers: [:html], type: :text, color: text_col, component: { size: params[:height] },
      data: default_text, left: params[:height] * 20 / 100, top: 0, edit: true, attach: input_back.id, height: params[:height],
      position: :absolute
    }
  )

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
  default_slider_particles = { id: new_id, color: color_found, width: 333, height: 33, left: 0, top: 0, smooth: default_smooth }
  default_cursor_particles = { color: color_found, width: 29, height: 29, left: 0, smooth: '100%' }
  cursor_found = params.delete(:cursor)
  slider_particle = default_slider_particles.merge(params)
  slider = box(slider_particle)

  slider_shadow = slider.shadow({
                                  id: :s2,
                                  left: 3, top: 3, blur: 9,
                                  invert: true,
                                  red: 0, green: 0, blue: 0, alpha: 0.7
                                })

  range = slider.box({ id: "#{slider.id}_range", top: :auto, bottom: 0 })

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
      smooth: 3, overflow: :hidden,
    })

  button.touch(:down) do
    button.tick(:button)
    bloc.call((button.tick[:button] - 1) % states)

  end

  params.each do |part_f, val_f|
    button.send(part_f, val_f)
  end

  button
end

# new(molecule: :matrix) do |id, rows, columns, spacing, size|
new(molecule: :matrix) do |params, &bloc|
  # alert self.id
  id = params[:id]
  rows = params[:rows]
  columns = params[:columns]
  spacing = params[:spacing]
  size = params[:size]

  parent_found = self
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
  if view_width > view_height
    available_width = (view_height * size_coefficient) - total_spacing_x
    available_height = (view_height * size_coefficient) - total_spacing_y
  else
    available_width = (view_width * size_coefficient) - total_spacing_x
    available_height = (view_width * size_coefficient) - total_spacing_y
  end
  box_width = available_width / rows
  box_height = available_height / columns
  background = box({ id: "#{id}_background", width: 666, height: 666, color: { alpha: 0 } })

  columns.times do |y|
    rows.times do |x|
      id_generated = "#{id}_#{x}_#{y}"
      matrix_cells << id_generated
      new_box = background.box({ id: id_generated })
      new_box.width(box_width)
      new_box.height(box_height)
      new_box.left((box_width + spacing) * x + spacing)
      new_box.top((box_height + spacing) * y + spacing)
    end
  end
  current_matrix.collect(matrix_cells)
  current_matrix
  # end
end
new(molecule: :page) do |params, &bloc|

  b = box({ color: :red, left: 99, drag: true })
  b.text(params)
end

new(molecule: :application) do |params, &bloc|

  main_page = box({ drag: true, width: :auto, height: :auto, top: 0, bottom: 0, left: 0, right: 0 })

  main_page

  # def new(params, &bloc)
  #   if params[:page]
  #     site_found = grab(params[:page][:application])
  #     site_found.clear(true)
  #     page_id = params[:page][:name]
  #     site_found.box({ id: page_id })
  #   elsif params[:application]
  #
  #     footer_header_size = 33
  #     footer_header_color = color({ red: 0, green: 0, blue: 0, id: :footer_header_color })
  #
  #     if params[:header]
  #       top = footer_header_size
  #       header = box({ left: 0, right: 0, width: :auto, top: 0, height: top, id: :header })
  #       # header.attach(:footer_header_color)
  #     else
  #       top = 0
  #     end
  #     if params[:footer]
  #       bottom = footer_header_size
  #       box({ left: 0, right: 0, width: :auto, top: :auto, bottom: 0, height: bottom, id: :footer })
  #     else
  #       bottom = 0
  #     end
  #     box({ left: 0, right: 0, width: :auto, top: top, bottom: bottom, height: :auto, id: params[:application] })
  #   elsif params[:module]
  #
  #   end
  #   super if defined?(super)
  # end
end
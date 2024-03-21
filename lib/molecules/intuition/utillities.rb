# frozen_string_literal: true

new(molecule: :input) do |params, bloc|
  params[:height] ||= 15
  params[:width] ||= 222
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
    { renderers: renderer_found, type: :shape, color: back_col,
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
    text_input.edit(true)
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
  list = Atome.new({ renderers: renderer_found, type: :shape,  color: { alpha: 0 }, attach: attach_to }.merge(params))
  # Atome.new(
  #     { renderers: [:html], type: :shape, attach: :view, color: back_col,
  #       left: 0, top: 0, data: '', attach: attach_to,
  #       smooth: 6, overflow: :hidden,
  #     })
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
  default_smooth = 9
  default_slider_particles = { color: color_found, width: 333, height: 33, left: 0, top: 0, smooth: default_smooth }
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
      slider.instance_variable_set('@value',new_value)
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
      slider.instance_variable_set('@value',new_value)
      cursor.left(cursor_left_initial)
      cursor.top(cursor_top)
      range.width(cursor.left + cursor.width / 2)
    end
  end
  slider.behavior({ value: my_behavior })

  update_value = lambda do |cursor_position, cursor_size, slider_size, orientation|
    effective_slider_size = slider_size - cursor_size
    if orientation == :vertical
      percentage = 1.0 - (cursor_position.to_f / effective_slider_size)
    else
      percentage = cursor_position.to_f / effective_slider_size
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
      slider.instance_variable_set('@value',value)
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
      slider.instance_variable_set('@value',value)
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
new({ particle: :behavior })
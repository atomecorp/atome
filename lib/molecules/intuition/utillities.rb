# frozen_string_literal: true

module Molecule
  def slider(params, &bloc)
    attach_to = params[:attach] || :view
    color_found = params[:color] ||= :gray
    default_slider_particles = { color: color_found, width: 333, height: 33, left: 0, top: 0, smooth: 9 }
    default_cursor_particles = { color: color_found, width: 29, height: 29, left: 0, smooth: '100%' }
    cursor_found = params.delete(:cursor)
    cursor_particle = default_cursor_particles.merge(cursor_found)
    slider_particle = default_slider_particles.merge(params)
    slider = grab(attach_to).box(slider_particle)
    slider.shadow({
                    id: :s2,
                    left: 3, top: 3, blur: 9,
                    invert: true,
                    red: 0, green: 0, blue: 0, alpha: 0.7
                  })
    cursor_top = (slider_particle[:height] - cursor_particle[:height]) / 2.0
    cursor = slider.box(cursor_particle)
    bloc.call(cursor_particle[:left])
    cursor.top(cursor_top)
    cursor.shadow({
                    id: :s4,
                    left: 1, top: 1, blur: 3,
                    option: :natural,
                    red: 0, green: 0, blue: 0, alpha: 0.6
                  })
    cursor.drag({ restrict: { max: { left: slider_particle[:width] - cursor_particle[:width], top: cursor_top }, min: { top: cursor_top } } }) do |_event|
      value = cursor.left.to_f / (slider_particle[:width] - cursor_particle[:width]) * 100
      bloc.call(value)
    end
    slider
  end
  def input_box(params = {}, &bloc)
    # height_wanted = params[:height] ||= 15
    # width_wanted = params[:width] ||= 222

    params[:height] ||= 15
    params[:width] ||= 222
    limit = params.delete(:limit)
    limit  ||= 15
    back_col = params.delete(:back)
    back_col  ||= :grey
    text_col = params.delete(:text)
    text_col ||= :black
    # select_col = params[:selection] ||= :blue
    default_text = params.delete(:default)
    default_text ||= :input
    # shadow_found = params[:shadow] ||= false

    input_back = Atome.new(
      { renderers: [:html], id: :input_back, type: :shape, attach: :view, color: back_col,
        left: 0, top: 0, data: '',
        smooth: 6, overflow: :hidden,
      })

    text_input = Atome.new(
      { renderers: [:html], id: :input_text, type: :text, color: text_col, component: { size:    params[:height] },
        data: default_text, left:    params[:height] * 20 / 100, top: 0, edit: true, attach: :input_back, height:    params[:height],
        position: :absolute
      }
    )

    text_input.touch(:down) do
      text_input.edit(true)
    end

    # text_input.touch(true) do
    #   text_input.component({ selected: { color: :red, text: :white } })
    # end

    text_input.keyboard(:down) do |native_event|
      # text_input.component({ selected: { color: :red, text: :red } })
      event = Native(native_event)
      if event[:keyCode].to_s == '8' || event[:keyCode].to_s == '46'
        # always allow
      elsif event[:keyCode].to_s == '13'
        # we prevent the input
        bloc.call(text_input.data)
        text_input.edit(false)
        event.preventDefault()
      elsif text_input.data.length > limit
        event.preventDefault()
      end

    end

    text_input.keyboard(:up) do |native_event|
      input_back.data = text_input.data
    end
     params.each do |part_f, val_f|
       input_back.send(part_f, val_f)
     end
    input_back
  end
  def list(params)
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
    renderer_found = renderers
    # lets create the listing container
    list = box({ attach: id, color: { alpha: 0 } }.merge(params))
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
end

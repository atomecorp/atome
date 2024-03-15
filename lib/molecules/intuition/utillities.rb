# frozen_string_literal: true


module Molecule
  def slider(params,&bloc)
    slider_width=params[:width] || 333
    cursor_width=33
    cursor_height=33
    left_pos=params[:left] || 0
    top_pos=params[:top] || 0
    attach_to= params[:attach] || :view
    cursor_left=0
    cursor_top=0
    slider=grab(attach_to).box({ top: top_pos, left: left_pos,width: slider_width, height: 25,  smooth: 9,  color:{red: 0.3, green: 0.3, blue: 0.3}})
    slider.shadow({
                    id: :s2,
                    left: 3, top: 3, blur: 9,
                    invert: true,
                    red: 0, green: 0, blue: 0, alpha: 0.7
                  })
    cursor= slider.circle({width: cursor_width, height: cursor_height, left: 2, top: 1, color:{red: 0.3, green: 0.3, blue: 0.3}})
    cursor.left(cursor_left)
    cursor.top(cursor_top)
    cursor.shadow({
                    id: :s4,
                    left: 1, top: 1, blur: 3,
                    option: :natural,
                    red: 0, green: 0, blue: 0, alpha: 0.6
                  })
    cursor.drag({ restrict: {max:{ left: slider_width-cursor_width, top: 0}} }) do |_event|
      value = (cursor.left+cursor.width)/slider_width*100
      bloc.call(value)
    end
    slider
  end

  def list(params)

    #   listing: listing
    listing = params[:listing]
    styles_found=params.delete(:styles)
    element=params.delete(:element)
    listing=params.delete(:listing)
    # lets create the listing container
    list = box({ attach: id , color: {alpha: 0}}.merge(params))

    styles_found = styles_found ||= {
      width: 99,
      height: 33,
      margin: 6,
      shadow: { blur: 9, left: 3, top: 3, id: :cell_shadow, red: 0, green: 0, blue: 0, alpha: 0.6 },
      left: 0,
      color: :yellowgreen
    }
    element = element ||= { width: 33,
                            height: 33,
                            left: :center,
                            top: :center,
                            color: :orange,
                            type: :text }

    unless element[:width]
      element[:width] = styles_found[width]
    end
    margin = styles_found[:margin]
    height_found = styles_found[:height]
    renderer_found = renderers
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

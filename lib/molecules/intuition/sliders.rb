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
  end
end

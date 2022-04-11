require "opal-jquery"

# class Element
#   def self.create(tag = 'div', opt = {})
#     `jQuery('<'+tag+'/>',opt.$to_n())`
#   end
# end
#
# def box(params = {})
#   # el = Element.new(:div)
#   el = Element.create(:div, { id: 'some_big_id',
#                               class: 'some-class some-other-class',
#                               title: 'now this div has a title!' })
#   # el.text("kjh")
#   Element.find('#user_view').append(el)
#   el.css(:color, :red).css( "box-shadow": "0px 0px 9px red")
#     .css(:width, 33).css(:height, 33).css(:position, "absolute").css(:left, "33px").css(:top, "33px")
#     .css( 'border-radius', '3px 6px 3px 6px')
#
#   el.on(:click) do
#     el.css("background-color", "yellowgreen")
#     el.text(el.css("background-color"))
#   end
# end

box({ width: 33, height: 33, smooth: 6, shadow: { blur: 6, x: 6, y: 6, invert: false, thickness: 0, bounding: true, color: :black } })

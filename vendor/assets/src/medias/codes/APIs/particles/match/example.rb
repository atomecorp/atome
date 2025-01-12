#  frozen_string_literal: true

# def add_css_to_atomic_style(css)
#   style_element = JS.global[:document].getElementById('atomic_style')
#   text_node = JS.global[:document].createTextNode(css)
#   style_element.appendChild(text_node)
# end
#
# def convert_to_css(data)
#   conditions = data[:condition]
#   apply = data[:alterations]
#
#   # Convert the conditions
#   condition_strings = []
#
#   if conditions[:max]
#     condition_strings << "(max-width: #{conditions[:max][:width]}px)" if conditions[:max][:width]
#     condition_strings << "(max-height: #{conditions[:max][:height]}px)" if conditions[:max][:height]
#   end
#
#   if conditions[:min]
#     condition_strings << "(min-width: #{conditions[:min][:width]}px)" if conditions[:min][:width]
#     condition_strings << "(min-height: #{conditions[:min][:height]}px)" if conditions[:min][:height]
#   end
#
#   operator = conditions[:operator] == :and ? "and" : "or"
#
#   # Convert properties to apply
#   property_strings = []
#   apply.each do |key, values|
#     inner_properties = []
#     values.each do |property, value|
#       if property == :color
#         inner_properties << "background-color: #{value} !important;"
#       else
#         inner_properties << "#{property}: #{value}px !important;" if value.is_a?(Integer)
#         inner_properties << "#{property}: #{value} !important;" if value.is_a?(Symbol)
#       end
#     end
#     # Prefix each key with "#"
#     property_strings << "##{key} {\n#{inner_properties.join("\n")}\n}"
#   end
#
#   # let it build
#   css = "@media #{condition_strings.join(" #{operator} ")} {\n#{property_strings.join("\n")}\n}"
#   add_css_to_atomic_style(css)
#   css
# end
#
# def css_to_data(css)
#   data = {
#     :condition => {},
#     :apply => {}
#   }
#   # Extract conditions
#   media_conditions = css.match(/@media ([^\{]+)/)[1].split(',').map(&:strip)
#   media_conditions.each do |condition|
#     type = condition.match(/(max|min)-/)[1].to_sym
#     property = condition.match(/(width|height)/)[1].to_sym
#     value = condition.match(/(\d+)/)[1].to_i
#
#     data[:condition][type] ||= {}
#     data[:condition][type][property] = value
#   end
#
#   # Extract properties to be applied
#   css.scan(/(\w+) \{([^\}]+)\}/).each do |match|
#     key = match[0].to_sym
#     properties = match[1].split(';').map(&:strip).reject(&:empty?)
#
#     data[:apply][key] ||= {}
#     properties.each do |property|
#       prop, value = property.split(':').map(&:strip)
#       if prop == "background-color"
#         data[:apply][key][:color] = value.to_sym
#       elsif value[-2..] == "px"
#         data[:apply][key][prop.to_sym] = value.to_i
#       else
#         data[:apply][key][prop.to_sym] = value.to_sym
#       end
#     end
#   end
#
#   data
# end



box({ color: :red, width: :auto, left: 120, right: 120, id: :box_1 })
circle({ left: 33, top: 200, id: :circle_1 })
circle({ left: 200, top: 200, id: :circle_2 })
circle({ left: 400, top: 200, id: :circle_3 })
circle({ left: 600, top: 200, id: :circle_4 })
text({ data: "resize the window to it's minimum to activate response", id: :my_text })

A.match({condition:{max: {width: 777}, min: {height: 333}, operator: :and }})  do
{
  circle_1: { color: :red , width: 23},
  circle_2: { color: :orange , width: 23, top: 12},
  box_1: { width: 123, left: 222, color: :blue, rotate: 22}
}
end

# match can work without any condition then the particles are always applied

# A.match({}) do
#   {
#     circle_1: { color: :red, width: 23 },
#     circle_2: { color: :orange, width: 23, top: 12 },
#     box_1: { width: 123, left: 222, color: :blue, rotate: 22 }
#   }
# end




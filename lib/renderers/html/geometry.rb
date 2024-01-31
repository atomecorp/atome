# frozen_string_literal: true

# new({ method: :width, type: :integer, renderer: :html }) do |value, _user_proc|
#   unit_found = metrics[:width]
#   if unit_found
#     html.style(:width, "#{value}#{unit_found}")
#   elsif value.is_a?(Numeric)
#     html.style(:width, "#{value}px")
#   else
#     html.style(:width, value)
#   end
# end
#
# new({ method: :height, renderer: :html, type: :string }) do |value, _user_proc|
#   unit_found = metrics,
#     [:height]
#   if unit_found
#     html.style(:height, "#{value}#{unit_found}")
#   elsif value.is_a?(Numeric)
#     html.style(:height, "#{value}px")
#   else
#     html.style(:height, value)
#   end
# end

new({ method: :width, renderer: :html, type: :int }) do |params, _user_proc|
  unit = @unit[:width] || :px if params.is_a? Numeric
  js[:style][:width] = "#{params}#{unit}"
end

new({ method: :height, renderer: :html, type: :int }) do |params, _user_proc|
  unit = @unit[:height] || :px if params.is_a? Numeric
  js[:style][:height] = "#{params}#{unit}"
end


# new({ method: :size, type: :hash, renderer: :html }) do |value, _user_proc|
#   # html.style('fontSize',"#{value}px")
# end
#
#
# new({ method: :size, type: :int, renderer: :html }) do |value, _user_proc|
#   # html.style('fontSize', "#{value}px")
# end


new({ method: :size, type: :int, renderer: :html, specific: :text }) do |value, _user_proc|
  html.style('fontSize', "#{value}px")
end

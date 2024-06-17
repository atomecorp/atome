# frozen_string_literal: true


new({ method: :width, renderer: :html, type: :int }) do |params, _user_proc|
  unit = @unit[:width] || :px if params.is_a? Numeric
  js[:style][:width] = "#{params}#{unit}"
end

new({ method: :height, renderer: :html, type: :int }) do |params, _user_proc|
  unit = @unit[:height] || :px if params.is_a? Numeric
  js[:style][:height] = "#{params}#{unit}"
end



new({ method: :size, type: :int, renderer: :html, specific: :text }) do |value, _user_proc|
  html.style('fontSize', "#{value}px")
end

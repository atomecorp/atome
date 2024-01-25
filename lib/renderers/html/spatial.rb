# frozen_string_literal: true

new({ method: :left, type: :integer, renderer: :html }) do |params|
  unit = @unit[:left] || :px
  js[:style][:left] = "#{params}#{unit}"
end

new({ method: :top, type: :integer, renderer: :html }) do |params|
  unit = @unit[:top] || :px
  # alert  unit
  js[:style][:top] = "#{params}#{unit}"
end
new({ method: :bottom, type: :integer, renderer: :html }) do |params|
  unit = @unit[:bottom] || :px
  js[:style][:bottom] =  "#{params}#{unit}"
end

new({ method: :right, type: :integer, renderer: :html }) do |params|
  unit = @unit[:right] || :px

  js[:style][:right] =  "#{params}#{unit}"
end

new({ method: :top, type: :integer, renderer: :html, specific: :shadow })

# new({ method: :top, type: :integer, renderer: :html, specific: :text }) do |params|
#   unit = @unit[:left] || :px
#   html.style(:top,  "#{params}#{unit}"
# end
#
# new({ method: :bottom, type: :integer, renderer: :html, specific: :text }) do |params|
#   html.style(:bottom,  "#{params}#{unit}")
# end

new({ method: :left, type: :integer, specific: :color, renderer: :html })

new({ method: :left, type: :integer, renderer: :html, specific: :shadow })

new({ method: :top, type: :integer, specific: :color, renderer: :html })

new({ method: :rotate, type: :integer, renderer: :html }) do |params|
  html.transform(:rotate, params)
end

new({ method: :rotate, type: :integer, renderer: :html, specific: :paint })

new({ renderer: :html, method: :position }) do |params|
  html.style("position", params)
end

new({ renderer: :html, method: :depth }) do |params|
  html.style("z-index", params)
end

new({ method: :organise, renderer: :html }) do |params|
  html.style(:gridTemplateColumns, params)
end

new({ method: :spacing, renderer: :html }) do |params|
  html.style(:gap, "#{params}px")
end

new({ method: :display, renderer: :html }) do |params|
  html.style(:display, params)
end

new({ renderer: :html, method: :center }) do |params|
  html.center(params, attach)
end

# frozen_string_literal: true

new({ method: :top, type: :integer, renderer: :html }) do |params|
  html.style(:top, "#{params}px")
end

new({ method: :top, type: :integer, renderer: :html, specific: :text }) do |params|
  html.style(:top, "#{params}px")
end
new({ method: :top, type: :integer, renderer: :html, specific: :shadow })

new({ method: :bottom, type: :integer, renderer: :html }) do |params|
  html.style(:bottom, "#{params}px")
end

new({ method: :bottom, type: :integer, renderer: :html, specific: :text }) do |params|
  html.style(:bottom, "#{params}px")
end

new({ method: :right, type: :integer, renderer: :html }) do |params|
  html.style(:right, "#{params}px")
end

new({ method: :left, type: :integer, renderer: :html }) do |params|
  html.style(:left, "#{params}px")
end

new({ method: :left, type: :integer, specific: :color, renderer: :html })

new({ method: :left, type: :integer, renderer: :html, specific: :shadow })

new({ method: :top, type: :integer, specific: :color, renderer: :html })

new({ method: :rotate, type: :integer, renderer: :html }) do |params|
  html.transform(:rotate, params)
end

new({ method: :rotate, type: :integer, renderer: :html, specific: :paint })

new({renderer: :html, method: :position }) do |params|
  html.style("position", params)
end

new({renderer: :html, method: :depth }) do |params|
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
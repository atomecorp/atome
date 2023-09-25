# frozen_string_literal: true

new({ method: :right, type: :string, specific: :shape, renderer: :html }) do |value, _user_proc|
  html.style(:right, "#{value}px")
end

new({ method: :top, type: :integer, renderer: :html }) do |params, &bloc|
  html.style(:top, "#{params}px")
end

new({ method: :bottom, type: :integer, renderer: :html }) do |params, &bloc|
  html.style(:bottom, "#{params}px")
end

new({ method: :right, type: :integer }) do |params, &bloc|
  html.style(:right, "#{params}px")
end

new({ method: :left, type: :integer, renderer: :html }) do |params, &bloc|

  html.style(:left, "#{params}px")
end

new({ method: :left, type: :integer, specific: :color, renderer: :html })
new({ method: :top, type: :integer, specific: :color, renderer: :html })

# frozen_string_literal: true

new({ method: :top, type: :integer, renderer: :html }) do |params|
  if params.instance_of? Integer
    html.style(:top, "#{params}px")
  else
    html.style(:top, params)
  end
end

new({ method: :top, type: :integer, renderer: :html, specific: :text }) do |params|
  if params.instance_of? Integer
    html.style(:top, "#{params}px")
  else
    html.style(:top, params)
  end
end
new({ method: :top, type: :integer, renderer: :html, specific: :shadow })

new({ method: :bottom, type: :integer, renderer: :html }) do |params|
  if params.instance_of? Integer
    html.style(:bottom, "#{params}px")
  else
    html.style(:bottom, params)
  end
end

new({ method: :bottom, type: :integer, renderer: :html, specific: :text }) do |params|
  if params.instance_of? Integer
    html.style(:bottom, "#{params}px")
  else
    html.style(:bottom, params)
  end
end

new({ method: :right, type: :integer, renderer: :html }) do |params|
  if params.instance_of? Integer
    html.style(:right, "#{params}px")
  else
    html.style(:right, params)
  end
end

new({ method: :left, type: :integer, renderer: :html }) do |params|
  if params.instance_of? Integer
    html.style(:left, "#{params}px")
  else
    html.style(:left, params)
  end
end

new({ method: :left, type: :integer, specific: :color, renderer: :html })

new({ method: :left, type: :integer, renderer: :html, specific: :shadow })

new({ method: :top, type: :integer, specific: :color, renderer: :html })

new({ method: :rotate, type: :integer, renderer: :html }) do |params|
  html.transform(:rotate, params)
end

new({ method: :rotate, type: :integer, renderer: :html, specific: :paint })

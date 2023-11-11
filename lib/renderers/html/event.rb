# frozen_string_literal: true

new({ method: :drag, type: :symbol, renderer: :html }) do |params|
  html.event(:drag, params)
end

new({ method: :drop, type: :symbol, renderer: :html }) do |params|
  html.event(:drop, params)
end

new({ method: :touch, type: :integer, renderer: :html }) do |params|
  html.event(:touch, params)
end

new({ method: :over, type: :integer, renderer: :html }) do |params|
  html.event(:over, params)
end

new({ method: :keyboard, renderer: :html }) do |params|
  html.event(:keyboard, params)
end

new({ method: :play, renderer: :html }) do |params = true|
  # html.event(:keyboard, params, user_bloc)
  if params != true
    html.currentTime(params)
  end
  html.action(:play)
end

new({ method: :on, renderer: :html }) do |params, user_bloc|
  html.on(params, user_bloc)
end

new({ method: :resize, renderer: :html }) do |params, user_bloc|
  unless params.instance_of? Hash
    params={min: {width: 10, height: 10}, max: {width: 2000, height: 2000}}
  end
  html.resize(params,user_bloc)
end


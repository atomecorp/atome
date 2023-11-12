# frozen_string_literal: true

new({ method: :drag, type: :symbol, renderer: :html }) do |params|
  option = @drag[params]
  html.event(:drag, params, option)
end

new({ method: :drop, type: :symbol, renderer: :html }) do |params|
  option = @drop[params]
  html.event(:drop, params, option)
end

new({ method: :touch, type: :integer, renderer: :html }) do |params|
  option = @touch[params]
  html.event(:touch, params, option)
end

new({ method: :over, type: :integer, renderer: :html }) do |params|
  option = @over[params]
  html.event(:over, params, option)
end

new({ method: :keyboard, renderer: :html }) do |params|
  option = @keyboard[params]
  html.event(:keyboard, params, option)
end

new({ method: :play, renderer: :html }) do |params = true|
  option = @play[params]
  html.currentTime(params, option) if params != true
  html.action(:play)
end

new({ method: :on, renderer: :html }) do |params|
  option = @on[params]
  html.on(params, option)
end

new({ method: :resize, renderer: :html }) do |params, user_bloc|
  option = @resize[params]
  html.resize(params, option)
end


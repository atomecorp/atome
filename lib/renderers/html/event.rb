# frozen_string_literal: true

new({ method: :drag, type: :symbol, renderer: :html }) do |params, user_bloc|
  html.event(:drag, params, user_bloc)
end

new({ method: :touch, type: :integer, renderer: :html }) do |params, user_bloc|
  html.event(:touch, params, user_bloc)
end

new({ method: :over, type: :integer, renderer: :html }) do |params, user_bloc|
  html.event(:over, params, user_bloc)
end

new({ method: :keyboard, renderer: :html }) do |params, user_bloc|
  html.event(:keyboard, params, user_bloc)
end

new({ method: :play, renderer: :html }) do |params = true, user_bloc|
  # html.event(:keyboard, params, user_bloc)
  if params != true
    html.currentTime(params)
  end
  html.action(:play)
end

new({ method: :on, renderer: :html }) do |params, user_bloc|
  html.on(params, user_bloc)
end

new({ method: :resize, renderer: :html }) do |_params, user_bloc|
  html.resize(user_bloc)
end
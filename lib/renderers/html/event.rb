# frozen_string_literal: true

new({ method: :drag, type: :symbol, renderer: :html }) do |params|

  if params
    option = @drag[params]
    html.event(:drag, params, option)
  else
    html.event(:drag, :remove, true)
  end
end

new({ method: :drop, type: :symbol, renderer: :html }) do |params|
  if params
    option = @drop[params]
    html.event(:drop, params, option)
  else
    html.event(:drop, remove, true)
  end

end

new({ method: :touch, type: :integer, renderer: :html }) do |params|
  if params
    option = @touch[params]
    html.event(:touch, params, option)
  else
    html.event(:touch, :remove, true)
  end
end

new({ method: :over, type: :integer, renderer: :html }) do |params|
  if params
    option = @over[params]
    html.event(:over, params, option)
  else
    html.event(:over, :remove, true)
  end
end

new({ method: :keyboard, renderer: :html }) do |params|
  if params
    option = @keyboard[params]
    html.event(:keyboard, params, option)
  else
    html.event(:keyboard, :remove, true)
  end
end

new({ method: :play, renderer: :html }) do |params = true|
  option = @play[params]
  # html.currentTime(params, option) if params != true
  html.action(:play, params, option)
  # params
end

new({ method: :on, renderer: :html }) do |params|
  option = @on[params]

  html.on(params, option)
end

new({ method: :resize, renderer: :html }) do |params, _user_bloc|
  option = @resize[params]
  html.resize(params, option)
end

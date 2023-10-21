# frozen_string_literal: true

new({ renderer: :html, method: :diffusion, type: :string })

new({ method: :red, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
end

new({ method: :green, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
end

new({ method: :blue, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
end

new({ method: :alpha, type: :integer, specific: :color, renderer: :html }) do |value, _user_proc|
end

new({ renderer: :html, method: :edit }) do |params|
  html.attr(:contenteditable, params)
  html.update_data(params)
end

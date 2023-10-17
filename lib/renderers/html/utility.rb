# frozen_string_literal: true

new({ renderer: :html, method: :web }) do |params, &user_proc|
  params
end
new({ renderer: :html, method: :preset, type: :string })
new({ renderer: :html, method: :renderers, type: :string })
new({ renderer: :html, method: :delete, type: :string }) do |params|
  html.delete(id)
end
new({ renderer: :html, method: :terminal, type: :multiple }) do |value, &bloc|
  html.terminal(value, &bloc)
end


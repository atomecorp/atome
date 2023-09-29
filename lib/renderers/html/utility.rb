# frozen_string_literal: true

new({ renderer: :html, method: :web }) do |params, &user_proc|
  params
end
new({ renderer: :html, method: :preset, type: :string })
new({ renderer: :html, method: :renderers, type: :string })
new({ renderer: :html, method: :delete, type: :string }) do
  html.delete(id)
end



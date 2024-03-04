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

new({ renderer: :html, method: :diffusion, type: :string })

# edit
new({ renderer: :html, method: :edit }) do |params|
  html.attr(:contenteditable, params)
  html.update_data(params)
end


new({ method: :clean, renderer: :html, type: :hash }) do |params|
  html.table_clean(params)
end

new({ method: :insert, renderer: :html, type: :hash }) do |params|
  html.table_insert(params)
end

new({ method: :remove, renderer: :html, type: :hash }) do |params|
  # alert "===> #{params}"
  # html.table_remove(params)
  html.remove(params)
end

new({ method: :sort, renderer: :html, type: :hash }) do |params|
  html.refresh_table(params)
end


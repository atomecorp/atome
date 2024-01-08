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


new({ method: :border, type: :hash, renderer: :html }) do |value, _user_proc|
  thickness = value[:thickness] || 5
  type = value[:pattern] || :solid
  color = if value[:color]
            color_found = value[:color]
            "#{color_found.red * 255},#{color_found.green * 255},#{color_found.blue * 255},#{color_found.alpha} "
          else
            "0,0,0,1"
          end

  html.style(:border, "#{type} #{thickness}px rgba(#{color})")
end
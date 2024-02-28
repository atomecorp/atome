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
  # color = if value[:color]
  #           color_found = value[:color]
  #           "#{color_found.red * 255},#{color_found.green * 255},#{color_found.blue * 255},#{color_found.alpha} "
  #         else
  #           "0,0,0,1"
  #         end
  if value[:color].instance_of? Atome
    color_found= value[:color]
  else
    color_found=grab('black_matter').color(value[:color])
  end

    # alert "atome found 2 : #{color_found}"
  red =  color_found.red* 255
  green =  color_found.green* 255
  blue =  color_found.blue* 255
  alpha =  color_found.alpha
  # alert "rgba(#{red},#{green},#{blue},#{alpha})"
  #       color_found=    "#{1 * 255},#{color_found.green * 255},#{0 * 255},#{0.3} "

  html.style(:border, "#{type} #{thickness}px rgba(#{red},#{green},#{blue},#{alpha})")
  # html.style(:border, "#{type} #{thickness}px rgba(#{color_found})")
  # html.style(:border, "solid 12px rgba(255, 255, 120, 0,3)")
end

new({ method: :clean, renderer: :html, type: :hash }) do |params|
  html.table_clean(params)
end

new({ method: :insert, renderer: :html, type: :hash }) do |params|
  html.table_insert(params)
end

new({ method: :remove, renderer: :html, type: :hash }) do |params|
  html.table_remove(params)
  html.remove(params)
end

new({ method: :sort, renderer: :html, type: :hash }) do |params|
  html.refresh_table(params)
end


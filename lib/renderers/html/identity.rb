# frozen_string_literal: true

new({ renderer: :html, method: :id, type: :string })

new({ method: :type, type: :string, renderer: :html }) do |_value, _user_proc|
  html.shape(@id)
end

new({ method: :type, type: :string, renderer: :html, specific: :vector }) do |_value, _user_proc|
  html.svg(@id)
end

new({ method: :type, type: :string, renderer: :html, specific: :image }) do |_value, _user_proc|
  html.image(@id)
end

new({ method: :type, type: :string, renderer: :html, specific: :video }) do |_value, _user_proc|
  html.video(@id)
end

new({ method: :type, type: :string, renderer: :html, specific: :www }) do |_value, _user_proc|
  html.www(@id)
end

new({ method: :type, type: :string, renderer: :html, specific: :raw }) do |_value, _user_proc|
  html.raw(@id)
end

new({ method: :type, type: :string, specific: :shape, renderer: :html }) do |_value, _user_proc|
  html.shape(@id)
end

new({ method: :type, type: :string, specific: :text, renderer: :html }) do |_value, _user_proc|
  html.text(@id)
  html.add_class(:text)
end

new({ method: :type, type: :string, specific: :paint, renderer: :html }) do
end

new({ method: :type, type: :string, specific: :color, renderer: :html }) do
end

new({ method: :data, type: :string, specific: :text, renderer: :html }) do |params|
    js[:innerHTML] = if language
                       int8[language].to_s
                     else
                       params.to_s
                     end
end

new({ method: :data, type: :string, specific: :vector, renderer: :html }) do |value|
  html.svg_data(value)
end

new({ method: :component, type: :hash, specific: :text, renderer: :html }) do |params, _user_proc|
  params.each do |prop, value|
    # we send component data directly to the text html renderer
    send("html_text_#{prop}", value)
  end
end

new({ method: :component, type: :hash, specific: :vector, renderer: :html }) do |params, _user_proc|
  html.update_svg_data(params)
end

new({ method: :path, type: :string, renderer: :html }) do |value, _user_proc|
  html.path(value)
end

new({ method: :path, type: :string, renderer: :html, specific: :image }) do |value, _user_proc|
  html.path(value)
end

new({ method: :path, type: :string, renderer: :html, specific: :www }) do |value, _user_proc|
  html.path(value)
end

new({ method: :data, type: :string, renderer: :html, specific: :raw }) do |value, _user_proc|
  html.raw_data(value)
end

new({ renderer: :html, method: :category, type: :symbol }) do |category_names|
  category_names.each do |category_name|
    html.add_class(category_name)
  end
end

new({ method: :data, type: :string, specific: :matrix, renderer: :html }) do |value, _user_proc|
  html.table(value)
end

new({ method: :type, type: :hash, specific: :atomized, renderer: :html }) do |value, _user_proc|
  html.atomized(alien)
end
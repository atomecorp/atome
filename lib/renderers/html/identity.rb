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

# new({ method: :type, type: :string, specific: :shadow, renderer:  }) do
#   # alert "on est en est ici : id is : "
#   # html.shadow(id)
#   # html.innerText(value)
# end

new({ method: :data, type: :string, specific: :text, renderer: :html }) do |value, _user_proc|
  html.innerText(value)
end

new({ method: :data, type: :string, specific: :vector, renderer: :html }) do |value, _user_proc|
  html.svg_data(value)
  # wait 1 do
  #   html.test
  # end
end

new({ method: :component, type: :hash, specific: :text, renderer: :html }) do |params, _user_proc|
  params.each do |prop, value|
    # we send component data directly to the text html renderer
    send("html_text_#{prop}", value)
  end
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

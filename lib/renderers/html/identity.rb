# frozen_string_literal: true

new({ renderer: :html, method: :id, type: :string })

new({ method: :type, type: :string, specific: :shape, renderer: :html }) do |_value, _user_proc|
  html.shape(@atome[:id])
end

new({ method: :type, type: :string, specific: :text, renderer: :html }) do |_value, _user_proc|
  html.text(@atome[:id], :pre)
  html.add_class(:text)
end

new({ method: :data, type: :string, specific: :text, renderer: :html }) do |value, _user_proc|
  html.innerText(value)
end

new({ method: :component, type: :hash, specific: :text, renderer: :html }) do |params, _user_proc|
  params.each do |prop, value|
    # we send component data directly to the text html renderer
    send("html_text_#{prop}", value)
  end
end
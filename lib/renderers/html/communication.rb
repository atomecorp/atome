new({ method: :language, renderer: :html }) do |params|
  js[:innerHTML] = int8[params].to_s
end

new({ method: :connection, renderer: :html }) do |params|
  html.connect(params)
end

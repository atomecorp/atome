new({ method: :language, renderer: :html }) do |params|
  js[:innerHTML] = int8[params].to_s
end
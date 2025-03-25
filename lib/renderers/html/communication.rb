new({ method: :language, renderer: :html }) do |params|
  js[:innerHTML] = int8[params].to_s
end

new({ method: :connection, renderer: :html }) do |params|
  html.connect(params)
end


new({ method: :webkittalk, type: :json, renderer: :html}) do |value, _user_proc|
  html.webkittalk(value)
end


new({ method: :chrometalk, type: :json, renderer: :html}) do |value, _user_proc|
  html.chrometalk(value)
end
#  frozen_string_literal: true

b = box
b.meteo('chamalieres') do |params|
  text({ data: params[:main][:temp] })
  puts params
end


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "meteo"
  ],
  "meteo": {
    "aim": "The `meteo` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `meteo`."
  }
}
end

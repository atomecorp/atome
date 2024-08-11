#  frozen_string_literal: true

b=box
b.meteo('chamalieres') do |data|
  text(data)
end

 # b.instance_variable_get('@meteo_code')[:meteo].call
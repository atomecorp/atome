#  frozen_string_literal: true

b = box
b.meteo('chamalieres') do |params|
  text({ data: params[:main][:temp] })
  puts params
end


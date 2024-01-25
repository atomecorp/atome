# frozen_string_literal: true



new ({particle: :left})  do |params|
  unless params.instance_of? Hash
    params= {value: params, unit: :px}
  end
  params
end

new ({method: :left, renderer: :html}) do |params|
  js[:style][:left] = "#{params[:value]}#{params[:unit]}"
end


b=box
b.touch (true)do
  b.left(533)
end

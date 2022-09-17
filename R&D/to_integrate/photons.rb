# frozen_string_literal: true

# Use for rendering
module Photons

  # include Helper

  def x_opal(params)
    params
  end

  def color_opal(params)
    params
  end

  def render(params)
    params[:id]=id unless params[:id]
    params.each do |key, value|
      opal_method="opal_#{key}".to_sym
      send(opal_method,value)
    end
  end

  def opal_id(params)
    puts "Main/parent id is : #{params}"
  end
  def opal_shape(params)
    # puts "shape id is : #{params[:id]}"
    params.each do |param, value|
      puts "param is #{param}, value is: #{value}"
    end
  end

  def opal_top(value)
    puts "top rendering is #{value}"
  end

end



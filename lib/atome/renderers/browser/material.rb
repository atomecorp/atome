# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:red) do |value|

  red = (@atome[:red] = value) * 255
  green = @atome[:green] * 255
  blue = @atome[:blue] * 255
  alpha = @atome[:alpha]
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  `document.getElementById(#{@atome[:id]}).sheet.cssRules[0].style.backgroundColor = #{color_updated}`
end

generator.build_render_method(:green) do |value|
  red = @atome[:red] * 255
  green = (@atome[:green] = value) * 255
  blue = @atome[:blue] * 255
  alpha = @atome[:alpha]
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  `document.getElementById(#{@atome[:id]}).sheet.cssRules[0].style.backgroundColor = #{color_updated}`
end

generator.build_render_method(:blue) do |value|
  red = @atome[:red] * 255
  green = @atome[:green] * 255
  blue = (@atome[:blue] = value) * 255
  alpha = @atome[:alpha]
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  `document.getElementById(#{@atome[:id]}).sheet.cssRules[0].style.backgroundColor = #{color_updated}`
end

generator.build_render_method(:alpha) do |value|
  red = @atome[:red] * 255
  green = @atome[:green] * 255
  blue = @atome[:blue] * 255
  alpha = (@atome[:alpha] = value)
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  `document.getElementById(#{@atome[:id]}).sheet.cssRules[0].style.backgroundColor = #{color_updated}`
end

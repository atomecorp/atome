# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:browser_width) do |value|
  @browser_object.style[:width] = "#{value}px" unless @browser_type == :style
end

generator.build_render_method(:browser_height) do |value|
  @browser_object.style[:height] = "#{value}px" unless @browser_type == :style
end

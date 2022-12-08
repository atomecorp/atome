# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:browser_width) do |value|
  @browser_object.style[:width] = "#{value}px"
end

generator.build_render(:browser_height) do |value|
  @browser_object.style[:height] = "#{value}px"
end

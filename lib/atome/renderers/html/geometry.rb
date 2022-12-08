# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:html_width) do |value|
  @html_object.style[:width] = "#{value}px" unless @html_type == :style
end

generator.build_render(:html_height) do |value|
  @html_object.style[:height] = "#{value}px" unless @html_type == :style
end

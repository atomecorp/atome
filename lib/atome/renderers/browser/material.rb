# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:red) do |_value|
  puts 'get the color and change the value'
  # @browser_object.style[:width] = "#{value}px"
end

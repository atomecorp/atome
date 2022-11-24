# frozen_string_literal: true

generator = Genesis.generator
generator.build_render_method(:browser_bloc)
generator.build_render_method(:browser_id)
generator.build_render_method(:browser_render)
generator.build_render_method(:browser_delete) do
  browser_object&.remove
end

generator.build_render_method(:browser_clear) do
  @atome[:children].each do |child_found|
    grab(child_found).browser_object&.remove
  end
  children([])
end

generator.build_render_method(:path) do |value|
  @browser_object[:src] = value
end

generator.build_render_method(:data) do |data|
  # according to the type we send the data to different operator
  type_found = @atome[:type]
  send("browser_data_#{type_found}", data)
end

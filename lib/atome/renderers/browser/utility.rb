# frozen_string_literal: true

generator = Genesis.generator
generator.build_render_method(:browser_bloc)
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

generator.build_render_method(:browser_path) do |value|
  BrowserHelper.send("browser_path_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render_method(:browser_data) do |data|
  # according to the type we send the data to different operator
  type_found = @atome[:type]
  BrowserHelper.send("browser_data_#{type_found}", data, self)
end

generator.build_render_method(:browser_schedule) do |format_date, proc|
  years = format_date[0]
  months = format_date[1]
  days = format_date[2]
  hours = format_date[3]
  minutes = format_date[4]
  seconds = format_date[5]
  `atome.jsSchedule(#{years},#{months},#{days},#{hours},#{minutes},#{seconds},#{self},#{proc})`
end

generator.build_render_method(:browser_reader) do |file, proc|
  `atome.jsReader(#{file},#{self},#{proc})`
end

# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:browser_left) do |value, _user_proc|
  BrowserHelper.send("browser_left_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render_method(:browser_right) do |value, _user_proc|
  BrowserHelper.send("browser_right_#{@atome[:type]}", value, @browser_object, @atome)
  # @browser_object.style[:right] = "#{value}px"
end

generator.build_render_method(:browser_top) do |value, _user_proc|
  BrowserHelper.send("browser_top_#{@atome[:type]}", value, @browser_object, @atome)
  # @browser_object.style[:top] = "#{value}px"
end

generator.build_render_method(:browser_bottom) do |value, _user_proc|
  BrowserHelper.send("browser_bottom_#{@atome[:type]}", value, @browser_object, @atome)
  # @browser_object.style[:bottom] = "#{value}px"
end

# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:browser_left) do |value, _user_proc|
  BrowserHelper.send("browser_left_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render_method(:browser_right) do |value, _user_proc|
  BrowserHelper.send("browser_right_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render_method(:browser_top) do |value, _user_proc|
  BrowserHelper.send("browser_top_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render_method(:browser_bottom) do |value, _user_proc|
  BrowserHelper.send("browser_bottom_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render_method(:browser_rotate) do |value, _user_proc|
  @browser_object.style[:transform] = "rotate(#{value}deg)" unless @browser_type == :style
end

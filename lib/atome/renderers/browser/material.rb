# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:red) do |value|
  red = ((@atome[:red] = value) * 255)
  green = @atome[:green] * 255
  blue = @atome[:blue] * 255
  alpha = @atome[:alpha]
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

generator.build_render(:green) do |value|
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
  red = @atome[:red] * 255
  green = (@atome[:green] = value) * 255
  blue = @atome[:blue] * 255
  alpha = @atome[:alpha]
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

generator.build_render(:blue) do |value|
  red = @atome[:red] * 255
  green = @atome[:green] * 255
  blue = (@atome[:blue] = value) * 255
  alpha = @atome[:alpha]
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

generator.build_render(:alpha) do |value|
  red = @atome[:red] * 255
  green = @atome[:green] * 255
  blue = @atome[:blue] * 255
  alpha = (@atome[:alpha] = value)
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

generator.build_render(:visual) do |value|
  # value = if value[:size].instance_of?(String)
  #           value[:size]
  #         else
  #           "#{value[:size]}px"
  #         end
  value = BrowserHelper.value_parse(value[:size])
  browser_object.style['font-size'] = value
end

generator.build_render(:browser_edit) do |value|
  if value == true
    caret_color = 'white'
    user_select = 'text'
    selection_color= 'blue'
  else
    caret_color = 'transparent'
    user_select = 'none'
    selection_color= 'transparent'
  end

  @browser_object.attributes[:contenteditable] = value
  @browser_object.style['caret-color'] = caret_color
  @browser_object.style['webkit-user-select'] = user_select
  @browser_object.style['-moz-user-select'] = user_select
  @browser_object.style['user-select'] = user_select
end

generator.build_render(:browser_hide) do |value|
  @browser_object.style[:display] = "none"

end

generator.build_render(:browser_class) do |value, _user_proc|
  @browser_object.add_class(value)
  # TODO : don't forget to remove class
end

generator.build_render(:browser_remove_class) do |value, _user_proc|
  @browser_object.remove_class(value)
end

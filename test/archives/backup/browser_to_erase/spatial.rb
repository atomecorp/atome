# frozen_string_literal: true

generator = Genesis.generator

new({ browser: :left, type: :integer }) do |value, _user_proc|
  BrowserHelper.send("browser_left_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render(:browser_right) do |value, _user_proc|
  BrowserHelper.send("browser_right_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render(:browser_top) do |value, _user_proc|
  BrowserHelper.send("browser_top_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render(:browser_bottom) do |value, _user_proc|
  BrowserHelper.send("browser_bottom_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render(:browser_rotate) do |value, _user_proc|
  @browser_object.style[:transform] = "rotate(#{value}deg)" unless @browser_type == :style
  # puts self.id
  # browser_object.style[:left] = BrowserHelper.value_parse(value)
  # BrowserHelper.send("browser_left_#{@atome[:type]}", value, @browser_object, @atome)
  # new({ browser: :left, type: :integer }) do |value, _user_proc|
  #   puts self.id
  #   BrowserHelper.send("browser_left_#{@atome[:type]}", value, @browser_object, @atome)
  # end
  # def self.browser_left_shape(value, browser_object, _atome)
  #   browser_object.style[:left] = BrowserHelper.value_parse(value)
  # end

end

generator.build_render(:browser_center) do |value, _user_proc|
  case value
  when :horizontal
    @browser_object.remove_class(:center)
    @browser_object.remove_class(:center_vertical)
    @browser_object.add_class(:center_horizontal)
    @browser_object.style[:bottom] = :auto
    @browser_object.style[:right] = :auto
    @browser_object.style[:top] = '0px'
    @browser_object.style[:left] = '50%'
  when :vertical
    @browser_object.remove_class(:center)
    @browser_object.remove_class(:center_horizontal)
    @browser_object.add_class(:center_vertical)
    @browser_object.style[:bottom] = :auto
    @browser_object.style[:right] = :auto
    @browser_object.style[:left] = '0px'
    @browser_object.style[:top] = '50%'
  else
    @browser_object.remove_class(:center_vertical)
    @browser_object.remove_class(:center_horizontal)
    @browser_object.add_class(:center)
    @browser_object.style[:bottom] = :auto
    @browser_object.style[:right] = :auto
    @browser_object.style[:left] = '50%'
    @browser_object.style[:top] = '50%'
  end

end

new ({ browser: :depth }) do |value|
  @browser_object.style['z-index'] = value
end


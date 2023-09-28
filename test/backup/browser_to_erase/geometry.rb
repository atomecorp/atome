# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:browser_width) do |value|

  # aa=BrowserHelper.value_parse(value)
  # # alert "value_parse : #{aa}"≈
  # alert "#{value} :  #{value.class} : value_parse : #{aa}"
  # @browser_object.style[:width] = if value.instance_of? String
  #                                   value
  #                                 else
  #                                   "#{value}px"
  #                                 end

  @browser_object.style[:width] = BrowserHelper.value_parse(value)
end

generator.build_render(:browser_height) do |value|
  # @browser_object.style[:height] = if value.instance_of? String
  #                                    value
  #                                  else
  #                                    "#{value}px"
  #                                  end
  @browser_object.style[:height] = BrowserHelper.value_parse(value)
end

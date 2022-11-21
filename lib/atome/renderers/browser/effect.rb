# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:browser_smooth) do |value|
  formated_params = case value
                    when Array
                      properties = []
                      value.each do |param|
                        properties << "#{param}px"
                      end
                      properties.join(' ').to_s
                    when Integer
                      "#{value}px"
                    else
                      value
                    end
  @browser_object.style['border-radius'] = formated_params
end

generator.build_render_method(:browser_blur) do |value|
  BrowserHelper.send("browser_blur_#{@browser_type}", @browser_object,value)
end

# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:browser_smooth) do |value|
  format_params = case value
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
  @browser_object.style['border-radius'] = format_params
end

# generator.build_render(:browser_blur) do |value|
#   # alert  "rendering : send('blur', #{value}\n#{self})"
#   # BrowserHelper.send("browser_blur_#{@browser_type}", @browser_object, value, @atome)
# end

# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:browser_width) do |value|
  @browser_object.style[:width] = if value.instance_of? String
                                    value
                                  else
                                    "#{value}px"
                                  end
end

generator.build_render(:browser_height) do |value|
  @browser_object.style[:height] = if value.instance_of? String
                                     value
                                   else
                                     "#{value}px"
                                   end
end

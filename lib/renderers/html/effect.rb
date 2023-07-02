# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:html_smooth) do |value|
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
  @html_object.style['border-radius'] = formated_params unless @html_type == :style
end

# frozen_string_literal: true

new({ renderer: :html, method: :smooth, type: :string }) do |value, _user_proc|
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
  html.style('border-radius', format_params)
end
new({ renderer: :html, method: :blur, type: :integer }) do |value, _user_proc|
  html.filter(:blur, "#{value}px")
end

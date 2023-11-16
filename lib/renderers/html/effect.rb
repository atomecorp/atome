# frozen_string_literal: true

new({ renderer: :html, method: :smooth, type: :string }) do |value, _user_proc|
  # alert :ici
  format_params = case value
                  when Array
                    data_collected = []
                    value.each do |param|
                      data_collected << "#{param}px"
                    end
                    data_collected.join(' ')
                  when Integer
                    "#{value}px"
                  else
                    if value.is_a?(String) && value.end_with?('%')
                      value
                    else
                      "#{value}px"
                    end
                  end
  html.style('border-radius', format_params)
end

new({ renderer: :html, method: :blur, type: :integer }) do |value, _user_proc|
  html.filter(:blur, "#{value}px")
end

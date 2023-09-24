# frozen_string_literal: true

new({ renderer: :html, method: :height, type: :string }) do |value, _user_proc|
  html.style(:height, "#{value}px")
end

new({ renderer: :html, method: :overflow, type: :string })

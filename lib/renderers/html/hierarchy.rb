# frozen_string_literal: true

new({ renderer: :html, method: :attach, type: :string }) do |parent_found, _user_proc|
  html.append_to(parent_found)
end

new({ renderer: :html, method: :attach, type: :string, specific: :color }) do |parent_found, _user_proc|
  grab(parent_found).apply(id)
end

new({ renderer: :html, method: :apply, type: :string }) do |parent_found, _user_proc|
  red = parent_found.red * 255
  green = parent_found.green * 255
  blue = parent_found.blue * 255
  alpha = parent_found.alpha
  html.style(:backgroundColor, "rgba(#{red}, #{green}, #{blue}, #{alpha})")
end

new({ renderer: :html, method: :apply, type: :string, specific: :text }) do |parent_found, _user_proc|
  # TODO:   we should treat objet when multiple : #{self.inspect}

  red = parent_found.red * 255
  green = parent_found.green * 255
  blue = parent_found.blue * 255
  alpha = parent_found.alpha
  html.style(:color, "rgba(#{red}, #{green}, #{blue}, #{alpha})")
end


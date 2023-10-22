# frozen_string_literal: true

new({ renderer: :html, method: :attach, type: :string }) do |parent_found, _user_proc|
  html.append_to(parent_found)
end

new({ renderer: :html, method: :attach, type: :string, specific: :color }) do |parent_found, _user_proc|
  grab(parent_found).apply(id)
end

# new({ renderer: :html, method: :attach, type: :string, specific: :shadow }) do |parent_found, _user_proc|
#   # grab(parent_found).apply(id)
#   alert "#{type} : #{:beefcake}"
# end
#
new({ renderer: :html, method: :apply, type: :string }) do |parent_found, _user_proc|
  case parent_found.type
  when :shadow

    red = parent_found.red * 255
    green = parent_found.green * 255
    blue = parent_found.blue * 255
    alpha = parent_found.alpha
    left = parent_found.left
    top = parent_found.top
    blur = parent_found.blur

    # inset = :inset if parent_found.invert
    if parent_found.invert
      html.style("boxShadow", "#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}) inset")
    elsif parent_found.option == :natural
      # patch to render clean on safari
      html.style("transform", "translate3d(0, 0, 0)")
      html.style("filter", "drop-shadow(#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}))")
    else
      html.style("boxShadow", "#{left}px #{top}px #{blur}px rgba(#{red}, #{green}, #{blue}, #{alpha})")
    end

  else
    # we assume it's a color
    red = parent_found.red * 255
    green = parent_found.green * 255
    blue = parent_found.blue * 255
    alpha = parent_found.alpha
    html.style(:backgroundColor, "rgba(#{red}, #{green}, #{blue}, #{alpha})")
  end

end

new({ renderer: :html, method: :apply, type: :string, specific: :text }) do |parent_found, _user_proc|
  # TODO:   we should treat objet when multiple : #{self.inspect}

  red = parent_found.red * 255
  green = parent_found.green * 255
  blue = parent_found.blue * 255
  alpha = parent_found.alpha
  html.style(:color, "rgba(#{red}, #{green}, #{blue}, #{alpha})")
end



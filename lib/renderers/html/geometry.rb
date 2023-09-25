# frozen_string_literal: true

new({ method: :width, type: :integer, renderer: :html }) do |value, _user_proc|
  unit_found = unit[:width]
  if unit_found
    html.style(:width, "#{value}#{unit_found}")
  else
    html.style(:width, "#{value}px")
  end
end

new({ method: :height,renderer: :html,  type: :string }) do |value, _user_proc|
  html.style(:height, "#{value}px")
end

new({ method: :overflow,renderer: :html,  type: :string })


new({ method: :size, type: :hash, renderer: :html }) do |value, _user_proc|
  # html.style('fontSize',"#{value}px")
  alert 'write method for size here'
end
#
new({ method: :size, type: :int, renderer: :html, specific: :text }) do |value, _user_proc|
  html.style('fontSize', "#{value}px")
end
# frozen_string_literal: true

def extract_rgb_alpha(color_string)
  match_data = color_string.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+(?:\.\d+)?))?\)/)
  # if match_data
  red = match_data[1].to_i
  green = match_data[2].to_i
  blue = match_data[3].to_i
  alpha = match_data[4] ? match_data[4].to_f : nil
  { red: red, green: green, blue: blue, alpha: alpha }

end

# new({ particle: :red, render: true }) do |params, &user_proc|
#   attached.each do |attached_atome_found|
#     targeted_atome = grab(attached_atome_found)
#     color_found = targeted_atome.html.style(:backgroundColor).to_s
#     rgba_data = extract_rgb_alpha(color_found)
#     html_params = params * 255
#     unless rgba_data[:alpha]
#       rgba_data[:alpha] = 1
#     end
#     targeted_atome.html.style(:backgroundColor, "rgba(#{html_params}, #{rgba_data[:green]}, #{rgba_data[:blue]},
# #{rgba_data[:alpha]})")
#   end
#   self
# end
#
# new({ particle: :green, render: true }) do |params, &user_proc|
#   attached.each do |attached_atome_found|
#     targeted_atome = grab(attached_atome_found)
#     color_found = targeted_atome.html.style(:backgroundColor).to_s
#     rgba_data = extract_rgb_alpha(color_found)
#     html_params = params * 255
#     unless rgba_data[:alpha]
#       rgba_data[:alpha] = 1
#     end
#     targeted_atome.html.style(:backgroundColor, "rgba(#{rgba_data[:red]}, #{html_params}, #{rgba_data[:blue]},
# #{rgba_data[:alpha]})")
#   end
#   self
# end
#
# new({ particle: :blue, render: true }) do |params, &user_proc|
#   attached.each do |attached_atome_found|
#     targeted_atome = grab(attached_atome_found)
#     color_found = targeted_atome.html.style(:backgroundColor).to_s
#     rgba_data = extract_rgb_alpha(color_found)
#     html_params = params * 255
#     unless rgba_data[:alpha]
#       rgba_data[:alpha] = 1
#     end
#     targeted_atome.html.style(:backgroundColor, "rgba(#{rgba_data[:red]}, #{rgba_data[:green]}, #{html_params},
# #{rgba_data[:alpha]})")
#   end
#   self
# end
#
# new({ particle: :alpha, render: true }) do |params, &user_proc|
#   attached.each do |attached_atome_found|
#     targeted_atome = grab(attached_atome_found)
#     color_found = targeted_atome.html.style(:backgroundColor).to_s
#     rgba_data = extract_rgb_alpha(color_found)
#     targeted_atome.html.style(:backgroundColor, "rgba(#{rgba_data[:red]}, #{rgba_data[:green]}, #{rgba_data[:blue]},
#  #{params})")
#   end
#   self
# end
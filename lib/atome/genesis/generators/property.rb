# frozen_string_literal: true

def extract_rgb_alpha(color_string)
  match_data = color_string.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+(?:\.\d+)?))?\)/)
  red = match_data[1].to_i
  green = match_data[2].to_i
  blue = match_data[3].to_i
  alpha = match_data[4] ? match_data[4].to_f : nil
  { red: red, green: green, blue: blue, alpha: alpha }
end

new({ particle: :red }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :green }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :blue }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :alpha }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :diffusion }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

# frozen_string_literal: true

require 'fileutils'
require 'atome/version'
@atome_client_ready = false

def eval_protection
  binding
end

# FIXME: atome run doesnt run the code
if RUBY_ENGINE.downcase != 'opal'
  # FIXME: find a better and more elegant solution to avoid opal to treat require
  # FIXME:  replace eval with a safer option
  eval "require 'atome/atome_native_extensions'", eval_protection, __FILE__, __LINE__
  eval "require 'color'", eval_protection, __FILE__, __LINE__
end

require 'atome/kernel/universe'
require 'atome/kernel/generators/genesis'
require 'atome/extensions/utilities'
require 'atome/renderers/renderer'
require 'atome/kernel/generators/sanitizer'
require 'atome/kernel/generators/generator'
require 'atome/renderers/opal/properties/generator'
require 'atome/renderers/server/properties/generator'
require 'atome/renderers/headless/properties/generator'
require 'atome/kernel/generators/shapes'
require 'atome/kernel/atome'
require 'atome/kernel/properties/essential'
require 'atome/extensions/helper'

Universe.send(:initialize)
# puts "@atome_client_ready is : #{@atome_client_ready}"

# puts "app_identity is : #{Universe.app_identity}"

Atome.current_user = :jeezs

require 'atome/kernel/sparkle'

# TODO: create a system to secure and validate generated renderer methods , optional methods and atome's methods

# test below uncomment when production mode
# require '../test/test_app/application/index'
# if RUBY_ENGINE.downcase != 'opal'
#   rgb_color = Color::CSS["red"].css_rgb
#   color_converted = { red: 0, green: 0, blue: 0, alpha: 1 }
#   rgb_color.gsub("rgb(", "").gsub(")", "").gsub("%", "").split(",").each_with_index do |component, index|
#     component = component.to_i/100
#     color_converted[color_converted.keys[index]] = component
#   end
#   puts color_converted
# end






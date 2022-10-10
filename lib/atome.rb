# frozen_string_literal: true

require 'fileutils'
require 'atome/version'
@atome_client_ready = false
def eval_protection
  binding
end

if RUBY_ENGINE.downcase != 'opal'
  # FIXME: find a better and more elegant solution to avoid opal to treat require
  # FIXME:  replace eval with a safer option
  eval "require 'atome/atome_native_extensions'", eval_protection, __FILE__, __LINE__
end

require 'atome/kernel/universe'
require 'atome/kernel/generators/genesis'
require 'atome/extensions/utilities'
require 'atome/renderers/opal/properties/generator'
require 'atome/renderers/server/properties/generator'
require 'atome/renderers/headless/properties/generator'
require 'atome/renderers/renderer'
require 'atome/kernel/generators/sanitizer'
require 'atome/kernel/generators/generator'
require 'atome/kernel/atome'
require 'atome/kernel/properties/essential'

Universe.send(:initialize)
# puts "@atome_client_ready is : #{@atome_client_ready}"

# puts "app_identity is : #{Universe.app_identity}"

Atome.current_user = :jeezs

require 'atome/kernel/sparkle'


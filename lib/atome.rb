# frozen_string_literal: true

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

require 'fileutils'
require 'atome/version'
require 'atome/genesis'
require 'atome/essentials'
require 'atome/universe'
require 'atome/sanitizer'
require 'atome/atome_meta_engine'
require 'atome/utilities'
require 'atome/generators'
require 'atome/renderers/opal/opal_renderers/geometry'
require 'atome/renderers/opal/opal_renderers/positioning'
require 'atome/renderers/opal/opal_renderers/type'
require 'atome/renderers/opal/opal_renderers/utility'
require 'atome/object_extensions'
require 'atome/kernel/sparkle'

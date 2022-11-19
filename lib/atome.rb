# frozen_string_literal: true

@atome_client_ready = false

def eval_protection
  binding
end

if RUBY_ENGINE.downcase != 'opal'
  eval "require 'atome/extensions/geolocation'", eval_protection, __FILE__, __LINE__
  eval "require 'atome/extensions/ping'", eval_protection, __FILE__, __LINE__
  eval "require 'atome/extensions/sha'", eval_protection, __FILE__, __LINE__
end

require 'fileutils'
require 'atome/version'
require 'atome/genesis/genesis'
require 'atome/kernel/essentials'
require 'atome/kernel/universe'
require 'atome/helpers/essentials'
require 'atome/helpers/color_helper/color'
require 'atome/atome_meta_engine'
require 'atome/processors/utilities'
require 'atome/helpers/utilities'
require 'atome/genesis/generators/atome'
require 'atome/presets/atome'
require 'atome/genesis/generators/communication'
require 'atome/genesis/generators/effect'
require 'atome/genesis/generators/event'
require 'atome/genesis/generators/geometry'
require 'atome/genesis/generators/identity'
require 'atome/genesis/generators/material'
require 'atome/genesis/generators/spatial'
require 'atome/genesis/generators/utility'
require 'atome/renderers/opal/opal_renderers/renderers'
require 'atome/renderers/opal/opal_renderers/effect'
require 'atome/renderers/opal/opal_renderers/event'
require 'atome/renderers/opal/opal_renderers/geometry'
require 'atome/renderers/opal/opal_renderers/identity'
require 'atome/renderers/opal/opal_renderers/spatial'
require 'atome/renderers/opal/opal_renderers/atome'
require 'atome/renderers/opal/opal_renderers/utility'
require 'atome/extensions/atome'
require 'atome/genesis/sparkle'
require 'atome/helpers/sanitizer'

# frozen_string_literal: true

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
# renderers
require 'atome/renderers/browser/browser'
require 'atome/renderers/html/html'

require 'atome/extensions/atome'
require 'atome/genesis/sparkle'
require 'atome/helpers/sanitizer'

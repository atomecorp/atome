# frozen_string_literal: true

require 'fileutils'
require 'atome/version'

def eval_protection
  binding
end

if RUBY_ENGINE.downcase != 'opal'
  # FIXME: find a better and more elegant solution to avoid opal to treat require
  # FIXME:  replace eval with a safer option
  eval "require 'atome/atome_native_extensions'", eval_protection, __FILE__, __LINE__
end

require 'atome/kernel/universe'
# require 'atome/kernel/properties/geometry'
require 'atome/kernel/generators/genesis'
require 'atome/extensions/utilities'
require 'atome/kernel/atome'
require 'atome/kernel/properties/essential'

Universe.initialize
# puts "@atome_client_ready is : #{@atome_client_ready}"

# Atome.new( identity: {type: :eVe, aui: Atome.aui})
# puts Atome.aui
# puts Universe.app_identity
require 'atome/kernel/generators/generator'
Atome.current_user = :jeezs
require 'atome/tests'

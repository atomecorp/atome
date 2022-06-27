# frozen_string_literal: true

require 'fileutils'
require 'atome/version'
require 'atome/kernel/universe'
require 'atome/kernel/properties/geometry'
require 'atome/kernel/atome_genesis'
require 'atome/kernel/generators/shapes'
require 'atome/extensions/sha'
require 'atome/extensions/ping'
require 'atome/extensions/geolocation'
Universe.initialize
puts "@atome_client_ready is : #{@atome_client_ready}"

# Atome.new( identity: {type: :eVe, aui: Atome.aui})
# puts Atome.aui
# alert Universe.app_identity

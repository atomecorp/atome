# frozen_string_literal: true

require 'roda'
require 'rack/unreloader'

Unreloader = Rack::Unreloader.new(subclasses: %w[Roda]) { App }
Unreloader.require './atome_server.rb'
run Unreloader
# uncomment to allow code reloading
# uncomment below for prod or comment to allow code reloading
#run App.freeze.app


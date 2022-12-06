# frozen_string_literal: true

require 'roda'
require 'rack/unreloader'

Unreloader = Rack::Unreloader.new(subclasses: %w[Roda]) { App }
Unreloader.require './atome_server.rb'
run Unreloader
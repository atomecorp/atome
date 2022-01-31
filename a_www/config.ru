# frozen_string_literal: true
# cat config.ru
# to run avec rackup :
# rackup -p 4567
# to run avec Puma :
# puma
require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(subclasses: %w[Roda]) { App }
require 'roda'

Unreloader.require './app.rb'

run Unreloader
# uncomment below for prod or comment to allow code reloading
run App.freeze.app

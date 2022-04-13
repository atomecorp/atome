# frozen_string_literal: true
# cat config.ru
# to run avec rackup :
# rackup -p 4567
# to run avec Puma :
# puma

require 'roda'
 Thread.new do
  sleep 1.5
  system("open", "http://127.0.0.1:9292")
end

require 'rack/unreloader'
Unreloader = Rack::Unreloader.new(subclasses: %w[Roda]) { App }
Unreloader.require './atome_server.rb'
# uncomment to allow code reloading
# run Unreloader
# uncomment below for prod or comment to allow code reloading
run App.freeze.app

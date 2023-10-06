# frozen_string_literal: true

# atome server
require 'em/pure_ruby' if RUBY_PLATFORM == 'x64-mingw32'
# require  'atome'
require '../src/utilities/aui'
require 'digest/sha2'
require 'faye/websocket'
require 'geocoder'
require 'json'
require 'mail'
require 'net/ping'
require 'roda'
require 'rufus-scheduler'
require 'securerandom'
require 'sequel'
Faye::WebSocket.load_adapter('puma') # Utilisez l'adaptateur 'thin' pour Faye

class App < Roda

  index_content = File.read("../src/index_server.html")

  opts[:root] = '../src'
  plugin :static, %w[/css /js /medias], root: '../src'
  route do |r|
    r.root do
      if Faye::WebSocket.websocket?(r.env)
        ws = Faye::WebSocket.new(r.env)

        ws.on :open do |event|
          # ws.send({ data: 'hello' }.to_json)
          ws.send("hello")
        end

        ws.on(:message) do |event|
          ws.send("event.data.reverse".to_json) # Envoie le message inversé au client
        end

        ws.on(:close) do |event|
          puts "WebSocket closed with status #{event.code}"
        end
        ws.rack_response
      end

      index_content
    end

  end

end

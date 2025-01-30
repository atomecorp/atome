# frozen_string_literal: true

# atome server

require 'em/pure_ruby' if RUBY_PLATFORM == 'x64-mingw32'
require 'fileutils'
require '../src/utilities/aui'
require 'digest/sha2'
require 'faye/websocket'
require 'geocoder'
require 'json'
require 'mail'
require 'net/imap'
require 'net/ping'
require 'roda'
require 'rufus-scheduler'
require 'securerandom'
require 'sequel'
require './eDen'
require './database'
require './extensions'

Faye::WebSocket.load_adapter('puma')

class App < Roda
  index_content = File.read("../src/index_server_opal.html")
  opts[:root] = '../src'
  plugin :static, %w[/css /js /medias /wasm], root: '../src'
  route do |r|
    r.root do
      if Faye::WebSocket.websocket?(r.env)
        ws = Faye::WebSocket.new(r.env)
        ws.on :open do |_event|
          ws.send({ return: 'server ready' }.to_json)
        end
        ws.on(:message) do |event|
          json_string = event.data
          # json_string = json_string.gsub(/(\w+):/) { "\"#{$1}\":" }.gsub('=>', ':')
          full_data = JSON.parse(json_string)
          data = full_data['data']
          action_requested = full_data['action']
          message_id = full_data['message_id']
          return_message = EDen.safe_send(action_requested, data, message_id, ws)
          ws.send(return_message.to_json)

        end
        ws.on(:close) do |event|
          puts "server closed with status #{event.code}"
        end
        ws.rack_response
      end
      index_content
    end
  end

end
# frozen_string_literal: true
# atome server

if RUBY_PLATFORM == "x64-mingw32"
  require "em/pure_ruby"
end
require "roda"
require "sequel"
require "rufus-scheduler"
require "faye/websocket"
require "json"
require "securerandom"
require "mail"
require "digest"

class String
  def is_json?
    begin
      !JSON.parse(self).nil?
    rescue
      false
    end
  end
end

class App < Roda
  eden = Sequel.connect("sqlite://eden.sqlite3")
  unless File.exist?("eden.sqlite3")
    eden.create_table :objects do
      primary_key :atome_id
      String :id
      String :type
      String :name
      String :content
    end
  end
  index_content = File.read("../build/index.html")

  require 'atome'
  opts[:root] = '../build'
  plugin :static, %w[/css /js /medias], root: '../build'
  route do |r|
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env)
      ws.on :message do |event|
        client_data = event.data
        if client_data.is_json?
          data = JSON.parse(client_data)
          ws.send(data)
        else
          ws.send(client_data)
        end
      end
      ws.on :open do
        # ws.send(event.data)
      end
      ws.on :close do
        # ws.send(event.data)
      end
      ws.rack_response
    end
    r.root do
      r.redirect "/index"
    end
    r.on "index" do
      r.is do
        r.get do
          index_content
        end
      end
    end
  end
end

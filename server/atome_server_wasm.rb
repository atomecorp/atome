# frozen_string_literal: true

# atome server
require 'em/pure_ruby' if RUBY_PLATFORM == 'x64-mingw32'
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

class String
  def is_json?
    begin
      !JSON.parse(self).nil?
    rescue
      false
    end
  end
end

class Database
  def self.connect_database
    if File.exist?("eden.sqlite3")
      eden = Sequel.connect("sqlite://eden.sqlite3")
    else
      eden = Sequel.connect("sqlite://eden.sqlite3")
      eden.create_table :atome do
        primary_key :atome_id
        String :aui
        String :id
        String :type
        String :name
        String :content
        String :position
        String :dimension
        String :color
        String :right
        String :effect
        String :shadow
        String :border
        String :fill
        Float :x
        Float :xx
        Float :y
        Float :yy
        Float :z
        Float :zz
        Float :width
        Float :height
        Float :depth
      end

    end
    eden
  end

end

class App < Roda
  # comment below when test will be done
  File.delete("./eden.sqlite3") if File.exist?("./eden.sqlite3")
  eden = Database.connect_database
  items = eden[:atome]

  # populate the table
  items.insert(name: 'abc', width: rand * 100)
  items.insert(name: 'def', width: rand * 100)
  items.insert(name: 'ghi', width: rand * 100)

  puts "Item count: #{items.count}"

  puts "The average price is: #{items.avg(:width)}"

  index_content = File.read("../src/index_server.html")

  opts[:root] = '../src'
  plugin :static, %w[/css /js /medias], root: '../src'
  route do |r|
    r.root do
      if Faye::WebSocket.websocket?(r.env)
        ws = Faye::WebSocket.new(r.env)

        ws.on :open do |event|
          ws.send('server ready'.to_json)
          ws.send('asking for synchro data'.to_json)
        end

        ws.on(:message) do |event|
          #TODO : encode event on both client and server
        ws.send(event.data.reverse.to_json) # Envoie le message inversé au client
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

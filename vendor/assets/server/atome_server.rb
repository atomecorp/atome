# frozen_string_literal: true

# atome server
require 'em/pure_ruby' if RUBY_PLATFORM == 'x64-mingw32'
# require  'atome'
require '../aui'
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
  def  self.connect_database
    if File.exist?("eden.sqlite3")
      eden=Sequel.connect("sqlite://eden.sqlite3")
    else
      eden=Sequel.connect("sqlite://eden.sqlite3")
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
        Float  :x
        Float  :xx
        Float  :y
        Float  :yy
        Float  :z
        Float  :zz
        Float  :width
        Float  :height
        Float  :depth
      end

    end
    eden
  end

end

class App < Roda
  ## comment below when test will be done
  File.delete("./eden.sqlite3") if File.exist?("./eden.sqlite3")
  eden=Database.connect_database
  items = eden[:atome]

  # populate the table
  items.insert(name: 'abc', width: rand * 100)
  items.insert(name: 'def', width: rand * 100)
  items.insert(name: 'ghi', width: rand * 100)

  puts "Item count: #{items.count}"

  puts "The average price is: #{items.avg(:width)}"


  index_content = File.read("../src/index.html")


  opts[:root] = '../src'
  plugin :static, %w[/css /js /medias], root: '../src'
  route do |r|
    if Faye::WebSocket.websocket?(env)
      websocket = Faye::WebSocket.new(env)
      websocket.on :message do |event|
        client_data = event.data
        if client_data.is_json?
          # to get hash from data:  data_to_hash = JSON.parse(client_data)
          # websocket.send(client_data)
          websocket.send("The average price must be: #{items.avg(:width)}")
          uuid = SecureRandom.uuid
          websocket.send("The coded uuid is : #{uuid}")
        end
      end
      websocket.on :open do
        # websocket.send(event.data)
      end
      websocket.on :close do
        # websocket.send(event.data)
      end
      websocket.rack_response
    end
    r.root do
      r.redirect "/index"
    end
    r.on "index" do
      index_content
    end
  end
end

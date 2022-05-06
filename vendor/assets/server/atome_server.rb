# frozen_string_literal: true
# atome server
if RUBY_PLATFORM == 'x64-mingw32'
  require 'em/pure_ruby'
end
require 'digest/sha2'
require 'net/ping'
require 'roda'
require 'sequel'
require 'rufus-scheduler'
require 'faye/websocket'
require 'json'
require 'securerandom'
require 'mail'
require 'digest'



## comment below when test will be done
File.delete("./eden.sqlite3") if File.exist?("./eden.sqlite3")


if File.exist?("eden.sqlite3")
  eden=Sequel.connect("sqlite://eden.sqlite3")
else
  eden=Sequel.connect("sqlite://eden.sqlite3")
  eden.create_table :objects do
    primary_key :atome_id
    String :id
    String :type
    String :name
    String :content
    Float :numb
  end
end
items = eden[:objects]

# populate the table
items.insert(name: 'abc', numb: rand * 100)
items.insert(name: 'def', numb: rand * 100)
items.insert(name: 'ghi', numb: rand * 100)


puts "Item count: #{items.count}"


puts "The average price is: #{items.avg(:numb)}"

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
      websocket = Faye::WebSocket.new(env)
      websocket.on :message do |event|
        client_data = event.data
        if client_data.is_json?
          # to get hash from data:  data_to_hash = JSON.parse(client_data)
          websocket.send(client_data)
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
      r.is do
        r.get do
          index_content
        end
      end
    end
  end
end

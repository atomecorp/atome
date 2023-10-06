# frozen_string_literal: true

# atome server
require 'em/pure_ruby' if RUBY_PLATFORM == 'x64-mingw32'
# require  'atome'
require '../src/utilities/aui'
require 'digest/sha2'
require 'roda'
require 'faye/websocket'
require 'stringio'
require 'geocoder'
require 'json'
require 'mail'
require 'net/ping'
require 'rufus-scheduler'
require 'securerandom'
require 'sequel'

#
# class String
#   def is_json?
#     begin
#       !JSON.parse(self).nil?
#     rescue
#       false
#     end
#   end
# end

# class Database
#   def  self.connect_database
#     if File.exist?("eden.sqlite3")
#       eden=Sequel.connect("sqlite://eden.sqlite3")
#     else
#       eden=Sequel.connect("sqlite://eden.sqlite3")
#       eden.create_table :atome do
#         primary_key :atome_id
#         String :aui
#         String :id
#         String :type
#         String :name
#         String :content
#         String :position
#         String :dimension
#         String :color
#         String :right
#         String :effect
#         String :shadow
#         String :border
#         String :fill
#         Float  :x
#         Float  :xx
#         Float  :y
#         Float  :yy
#         Float  :z
#         Float  :zz
#         Float  :width
#         Float  :height
#         Float  :depth
#       end
#
#     end
#     eden
#   end
#
# end
##################

##################
class App < Roda
  # use Faye::WebSocket::RackAdapter, :mount => '/websocket', :ping => 15

  # ## comment below when test will be done
  # File.delete("./eden.sqlite3") if File.exist?("./eden.sqlite3")
  # eden=Database.connect_database
  # items = eden[:atome]
  #
  # # populate the table
  # items.insert(name: 'abc', width: rand * 100)
  # items.insert(name: 'def', width: rand * 100)
  # items.insert(name: 'ghi', width: rand * 100)
  #
  # puts "Item count: #{items.count}"
  #
  # puts "The average price is: #{items.avg(:width)}"
  # plugin :websockets
  index_content = File.read("../src/index_server.html")

  opts[:root] = '../src'
  plugin :static, %w[/css /js /medias], root: '../src'
  # plugin :websockets
  route do |r|
    #   r.root do
    #     r.redirect "/index_server"
    #   end

    r.root do
      r.redirect "/index_server"
      if Faye::WebSocket.websocket?(r.env)
        ws = Faye::WebSocket.new(r.env)

        ws.on :open do |event|
          ws.send({ data: 'hello' }.to_json)
        end

        ws.on(:message) do |event|
          ws.send(event.data.reverse) # Envoie le message inversé au client
        end

        ws.on(:close) do |event|
          puts "WebSocket closed with status #{event.code}"
        end
        ws.rack_response
      end
      index_content
    end
    r.on "index" do
      index_content
    end
  end
  # route do |r|
  #   r.on "websocket" do
  #     r.websocket do |ws|
  #       ws.on(:message) do |event|
  #         ws.send("Echo: #{event.data}")
  #       end
  #     end
  #   end
  #
  #
  #   r.root do
  #     r.redirect "/index_server"
  #   end
  #   r.on "index" do
  #     index_content
  #   end
  # end
end

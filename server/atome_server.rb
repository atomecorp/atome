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
require 'net/ping'
require 'roda'
require 'rufus-scheduler'
require 'securerandom'
require 'sequel'

class EDen
  def self.terminal(cmd,option,ws,value, user, pass)
    `#{cmd}`
  end

  def self.file(source, operation,ws,value,user, pass)
    file_content= File.send(operation, source, value).to_s
    file_content = file_content.gsub("'", "\"")
    "=> operation: #{operation}, source:  #{source} , content : #{file_content},"
  end
  # return_message = EDen.safe_send(action_requested, message,option, current_user, user_pass)

  def self.safe_send(method_name, *args)
    method_sym = method_name.to_sym
    eden_methods = EDen.singleton_methods(false) - Object.singleton_methods
    if eden_methods.include?(method_sym)
      send(method_sym, *args)
    else
      "forbidden action:  #{method_name}"
    end
  end
end

Faye::WebSocket.load_adapter('puma')

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
          json_string = event.data.gsub(/(\w+):/) { "\"#{$1}\":" }.gsub('=>', ':')
          full_data = JSON.parse(json_string)

          message = full_data['message']
          action_requested = full_data['action']
          value= full_data['value']
          option= full_data['option']
          current_user = full_data['user']
          user_pass = full_data['pass']['global']
          # if action_requested == :request
          #   request (message)
          # end
            return_message = EDen.safe_send(action_requested, message,option,ws,value, current_user, user_pass)
          # else
          #   return_message = "no action msg: #{full_data}"
          # end
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

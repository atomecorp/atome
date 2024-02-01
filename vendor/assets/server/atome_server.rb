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
  def self.terminal(cmd, option, ws, value, user, pass)
    `#{cmd}`
  end

  def self.init_db(cmd, option, ws, value, user, pass)
    "the value is : #{value}"
  end

  def self.file(source, operation, ws, value, user, pass)
    file_content = File.send(operation, source, value).to_s
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

puts "kjhj"

class Database
  def self.connect_database
    if File.exist?("eden.sqlite3")
      eden = Sequel.connect("sqlite://eden.sqlite3")
    else
      eden = Sequel.connect("sqlite://eden.sqlite3")
      eden.create_table :atome do
        primary_key :atome_id
        String :creator
      end

      eden.create_table :communication do
        primary_key :communication_id
        String :connection
        JSON :message
        JSON :controller
      end

      eden.create_table :effect do
        primary_key :effect_id
        Int :smooth
        Int :blur
      end

      eden.create_table :event do
        primary_key :event_id
        JSON :touch
        Boolean :play
        Boolean :pause
        Int :time
        Boolean :on
        Boolean :fullscreen
        Boolean :mute
        Boolean :drag
        Boolean :drop
        Boolean :over
        String :targets
        Boolean :start
        Boolean :stop
        Time :begin
        Time :end
        Int :duration
        Int :mass
        Int :damping
        Int :stiffness
        Int :velocity
        Boolean :repeat
        Boolean :ease
        Boolean :keyboard
        Boolean :resize
        Boolean :overflow
      end

      eden.create_table :geometry do
        primary_key :geometry_id
        Int :width
        Int :height
        Int :size
      end

      eden.create_table :hierarchy do
        primary_key :hierarchy_id
        String :attach
        String :attached
        String :apply
        String :affect
        String :detached
        String :collect
      end

      eden.create_table :identity do
        primary_key :identity_id
        String :real
        String :type
        Int :id
        String :name
        Boolean :active
        String :markup
        String :bundle
        String :data
        String :category
        String :selection
        Boolean :selected
        String :format
        String :alien
      end

      eden.create_table :material do
        primary_key :material_id
        String :component
        Boolean :edit
        String :style
        Boolean :hide
        Boolean :remove
        JSON :classes
        Boolean :remove_classes
        Int :opacity
        String :definition
        Int :gradient
        Int :border
      end

      eden.create_table :property do
        primary_key :property_id
        String :red
        String :green
        String :blue
        String :alpha
        String :diffusion
        Boolean :clean
        String :insert
        Boolean :remove
        Int :sort
      end

      eden.create_table :security do
        primary_key :security_id
        String :password
      end

      eden.create_table :spatial do
        primary_key :spatial_id
        Int :left
        Int :right
        Int :top
        Int :bottom
        Int :rotate
        String :direction
        String :center
        Int :depth
        Int :position
        String :organise
        String :spacing
        Boolean :display
        String :layout
      end

      eden.create_table :time do
        primary_key :time_id
        JSON :markers
      end

      eden.create_table :utility do
        primary_key :utility_id
        String :renderers
        String :code
        Boolean :run
        Boolean :delete
        Boolean :clear
        String :path
        String :schedule
        String :read
        String :cursor
        String :preset
        JSON :relations
        JSON :tag
        String :web
        JSON :unit
        String :initialize
        String :login
        String :hypertext
        String :hyperedit
        String :terminal
        String :browse
        String :copies
        Int :temporary
        String :atomes
        String :match
        Boolean :invert
        String :option
        String :duplicate
        String :copy
        String :paste
        String :backup
        String :import
        String :compute
        String :get
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
  items.insert(creator: 'moi')
  items.insert(creator: 'toi')
  items.insert(creator: 'vous')
  puts "Item count: #{items.count}"
  test = "Item count: #{items.count}"
  # puts "My name is: #{items(:creator)}"
  index_content = File.read("../src/index_server.html")
  opts[:root] = '../src'
  plugin :static, %w[/css /js /medias], root: '../src'
  route do |r|
    r.root do
      if Faye::WebSocket.websocket?(r.env)
        ws = Faye::WebSocket.new(r.env)
        ws.on :open do |event|
          ws.send('server ready'.to_json)
          # ws.send('asking for synchro data'.to_json)
        end

        ws.on(:message) do |event|
          json_string = event.data.gsub(/(\w+):/) { "\"#{$1}\":" }.gsub('=>', ':')
          full_data = JSON.parse(json_string)
          message = full_data['message']
          action_requested = full_data['action']
          value = full_data['value']
          option = full_data['option']
          current_user = full_data['user']
          user_pass = full_data['pass']['global']
          if action_requested
            return_message = EDen.safe_send(action_requested, message, option, ws, value, current_user, user_pass)
          else
            return_message = "no action msg: #{test}"
          end
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
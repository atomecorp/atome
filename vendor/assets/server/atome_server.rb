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

  def self.db_access
    Database.connect_database
  end

  def self.terminal(data, message_id)
    { data: `#{data}`, message_id: message_id }
  end

  def self.authorization(data, message_id)
    { data: 'password received', message_id: message_id }
  end

  def self.authentication(data, message_id)
    { data: 'login received', message_id: message_id }
  end

  def self.init_db(data, message_id)
    { data: 'database initialised', message_id: message_id }
  end

  def self.query(data, message_id)
    identity_table = db_access[data['table'].to_sym]
    result = identity_table.send(:all).send(:select)
    { data: { table: data['table'], infos: result }, message_id: message_id }
  end

  def self.insert(data, message_id)
    table = data['table'].to_sym
    particle = data['particle'].to_sym
    data = data['data']
    if db_access.table_exists?(table)
      schema = db_access.schema(table)
      if schema.any? { |col_def| col_def.first == particle }
        identity_table = db_access[table.to_sym]
        identity_table.insert(particle => data)
        { data: "column : #{particle}, in table : #{table}, updated with : #{data}", message_id: message_id }
      else
        { data: "column not found: #{particle.class}", message_id: message_id }
      end
    else
      { data: "table not found: #{table.class}", message_id: message_id }

    end
  end

  def self.file(data, message_id)

    file_content = File.send(data['operation'], data['source'], data['value']).to_s
    file_content = file_content.gsub("'", "\"")

    file_content = file_content.gsub('#', '\x23')
    { data: "=> operation: #{data['operation']}, source: #{data['source']}, content: #{file_content}", message_id: message_id }
  end

  def self.safe_send(method_name, data, message_id)
    method_sym = method_name.to_sym
    send(method_sym, data, message_id)
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

  def self.table_exists?(table_name)
    eden = Sequel.connect("sqlite://eden.sqlite3")
    if eden.table_exists?(table_name)
      puts "La table #{table_name} existe dans la base de données."
    else
      puts "La table suivante :  #{table_name} n'existe pas dans la base de données."
    end

  end

  # def self.create_table(table_name)
  def self.connect_database
    if File.exist?("eden.sqlite3")
      eden = Sequel.connect("sqlite://eden.sqlite3")
      # now we test if the table exist
      table_exists?(:table_name)
    else
      eden = Sequel.connect("sqlite://eden.sqlite3")
      eden.create_table :atome do
        primary_key :atome_id
        String :creator
      end

      eden.create_table :communication do
        primary_key :communication_id
        String :connection
        JSON :data
        JSON :controller
      end

      ###################

      Sequel.extension :migration

      Sequel.migration do
        change do
          add_column :communication, :jesaispas, String
        end
      end.apply(eden, :up)

      ###################

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
        String :firstname
        String :email
        String :nickname
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
  index_content = File.read("../src/index_server.html")
  opts[:root] = '../src'
  plugin :static, %w[/css /js /medias], root: '../src'
  route do |r|
    r.root do
      if Faye::WebSocket.websocket?(r.env)
        ws = Faye::WebSocket.new(r.env)
        ws.on :open do |event|
          ws.send({ return: 'server ready' }.to_json)
        end
        ws.on(:message) do |event|
          json_string = event.data.gsub(/(\w+):/) { "\"#{$1}\":" }.gsub('=>', ':')
          full_data = JSON.parse(json_string)
          data = full_data['data']
          action_requested = full_data['action']
          # value = full_data['value']
          # option = full_data['option']
          # current_user = full_data['user']
          message_id = full_data['message_id']
          # user_pass = full_data['pass']['global']
          return_message = EDen.safe_send(action_requested, data, message_id)
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
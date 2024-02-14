# frozen_string_literal: true

# database handling for eDen Db

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
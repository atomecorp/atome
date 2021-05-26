# frozen_string_literal: true

# instructions to install :
# gem install bundler roda sqlite3 sequel rack-unreloader faye-websocket websocket-extensions websocket-driver puma -N
# important if crash the gem install rack-unreloader -v 1.7.0 gem install roda -v 2.26.0
# bundle update
# bundle install
# to run: rackup --server puma --port 4567  or without puma : rackup -p 4567
if RUBY_PLATFORM == "x64-mingw32"
  require "em/pure_ruby"
end
require "sequel"
require "faye/websocket"
require "json"
require "securerandom"

class String
  def is_json?
    begin
      !!JSON.parse(self)
    rescue
      false
    end
  end
end

class App < Roda


  @@channels = {}
  @@user


  #plugin :mail_processor
  eden = Sequel.connect("sqlite://eden_doors.sqlite3")
  unless File.exist?("eden_doors.sqlite3")
    eden.create_table :objects do
      primary_key :atome_id
      String :id
      String :type
      String :name
      String :content
    end
  end

  index_content = File.read("public/index.html")
  # below test line to supress
  #index_content += "<script>setTimeout(function(){ Opal.Object.$text('good!! Roda & puma are initialized'); }, 500);setTimeout(function(){ Opal.Object.$circle() ;Opal.eval('box(x: 200)'); }, 3000)</script>"
  #  index_content += "<script>setTimeout(function(){
  #var ws = new WebSocket('ws://192.168.103.147:9292');
  #   ws.onopen = function () {
  #    ws.send('Hello Server! view');
  #}
  #}, 3000)</script>"
  index_content = index_content.gsub('<script type="text/javascript" src="../cordova.js"></script>', "")
  # below an attempt to load atome in pure ruby not opal
  # require "../atome/lib/atome/core/neutron.rb"
  # require "../atome/lib/atome/core/proton.rb"
  # require "../atome/lib/atome/core/photon.rb"
  # require "../atome/lib/atome/core/nucleon.rb"
  # require "../atome/lib/atome/core/electron.rb"
  # require "../atome/lib/atome/big_bang.rb"
  plugin :static, %w[/css /js /medias]
  plugin "faye/websocket", adapter: :thin, ping: 45

  route do |r|
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env)
      ws.on :message do |event|
        client_data = event.data
        if client_data.is_json?
          data = JSON.parse(client_data)
          # puts data
          case data["type"]
          when "login"
            user_id = data["username"]
            # @user_id[user_id]=ws
            # @user[data["username"]] = ws
            # ws.send()
            # message_back = "text ({content: '#{data["username"]} with id : #{data["id"]} is connected!', y:330})"
            # message_back={id: data["id"], log: true}
            #
            session_id = SecureRandom.uuid
            message_back = JSON.generate({ type: :response,request_id: data["request_id"], session_id: session_id, log: true })
            ws.send(message_back)

          when "start_channel"
            channel_id = SecureRandom.uuid
            # self.channels(channel_id)
            @@channels[channel_id] = []
            # @session[data["username"]] =session_id
            message_back = JSON.generate({ type: :response,request_id: data["request_id"], channel_id: channel_id })
            ws.send(message_back)
          when "list_channels"
            message_back = JSON.generate({ type: :response,request_id: data["request_id"], channels: @@channels.keys })
            ws.send(message_back)
          when "connect_channel"
            channel_id=data["channel_id"]
            @@channels[channel_id] << ws
            message_back = JSON.generate({ type: :response,request_id: data["request_id"], connected: true })
            ws.send(message_back)
          when "push_to_channel"
            channel_id = data["channel_id"]
            message_received = data["message"]
            #fixme the type depend on the kind if received message
            message_to_push = JSON.generate({ type: :code, content: message_received })
            @@channels[channel_id].each do |ws_found|
              # we exclude the sender from the recipient
              unless ws_found == ws
                ws_found.send(message_to_push)
              end
            end

            message_back = JSON.generate({ type: :response,request_id: data["request_id"], pushed: true })
            ws.send(message_back)
            when "read"
              puts "reading now #{data}"
              message_to_push = JSON.generate({ type: :code, content: message_received })
              # ws.send(data["box"])
          when "code"
            message_to_push = JSON.generate({ type: :code, content: data["message"] })
            puts "coding now : #{data}"
            puts "coding this now : #{data["message"]}"

            ws.send(message_to_push)
          when "command"
            puts "command now : #{data}"
            # terminal_content = %x{#{data["text"]}}
            # message_back = "text('#{terminal_content}')"
            # ws.send(message_back)
          else
            ws.send("unknown message received")
          end
          #if data["connection"]
          #  ws.send('{"connection":{"username":"Régis","accepted":"true"}}')
          #elsif data["type"] == "code"
          #  ws.send(data["text"])
          #else
          #  data
          #end
        end
      end
      #ws.on :open do |event|
      #  #ws = nil
      #end
      #ws.on :close do |event|
      #  #ws = nil
      #end
      ws.rack_response
    end
    r.root do
      r.redirect "/index"
    end
    r.on "index" do
      r.is do
        r.get do
          #sleep 7
          #box()
          index_content
        end
      end
    end
  end
end
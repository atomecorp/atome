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
require "rufus-scheduler"
require "faye/websocket"
require "json"
require "securerandom"
require 'mail'

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
            message_back = JSON.generate({ type: :response, request_id: data["request_id"], session_id: session_id, log: true })
            ws.send(message_back)

          when "start_channel"
            channel_id = SecureRandom.uuid
            # self.channels(channel_id)
            @@channels[channel_id] = []
            # @session[data["username"]] =session_id
            message_back = JSON.generate({ type: :response, request_id: data["request_id"], channel_id: channel_id })
            ws.send(message_back)
          when "list_channels"
            message_back = JSON.generate({ type: :response, request_id: data["request_id"], channels: @@channels.keys })
            ws.send(message_back)
          when "connect_channel"
            channel_id = data["channel_id"]
            @@channels[channel_id] << ws
            message_back = JSON.generate({ type: :response, request_id: data["request_id"], connected: true })
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
            message_back = JSON.generate({ type: :response, request_id: data["request_id"], pushed: true })
            ws.send(message_back)
          when "read"
            file_content = File.read(data["file"])
            hashed_content = { content: file_content }
            hashed_options = { options: data["options"].to_s }
            message_to_push = JSON.generate({ type: :read, atome: data["atome"], target: data["target"], content: hashed_content, options: hashed_options })
            ws.send(message_to_push)
          when "list"
            files_found = Dir[data["path"] + "/*"]
            hashed_content = { content: files_found }
            hashed_options = { options: data["options"].to_s }
            message_to_push = JSON.generate({ type: :read, target: data["target"], content: hashed_content, options: hashed_options })
            ws.send(message_to_push)
          when "write"
            File.write(data["file"], data["content"])
            hashed_content = { content: data["content"].to_s }
            hashed_options = { options: data["options"].to_s }
            message_to_push = JSON.generate({ type: :read, target: data["target"], content: hashed_content, options: hashed_options })
            ws.send(message_to_push)
          when "copy"
            FileUtils.cp data["source"], data["dest"]
          when "delete"
            File.delete(data["file"])
            hashed_content = { content: data["file"].to_s }
            hashed_options = { options: data["options"].to_s }
            message_to_push = JSON.generate({ type: :read, target: data["target"], content: hashed_content, options: hashed_options })
            ws.send(message_to_push)
          when "mail"
            if data["from"]
              sender = data[:from]
            else
              sender = "contact@atome.one"
            end
            receiver = data[:to]
            mail_subject = data[:subject]
            content = data[:content]
            attachment = data[:attachment]
            attachments = []

            if attachment
              if attachment.instance_of?(Array)
                attachment.each do |file|
                  filename = File.basename(file)
                  attachments << { file: file, filename: filename }
                end
              else
                filename = File.basename(attachment)
                attachments << { file: attachment, filename: filename }
              end
            end

            mail = Mail.new do
              from sender
              to receiver
              subject mail_subject
              body content
              attachments.each do |file_to_add|
                # add_file attachment
                file = file_to_add[:file]
                filename = file_to_add[:filename]
                add_file :filename => filename, :content => File.read(file)
              end
            end

            mail.delivery_method :sendmail

            mail.deliver
          when "atome"
            message_to_push = JSON.generate({ type: :atome, target: data["target"], atome: data["atome"], content: data["content"] })
            ws.send(message_to_push)
          when "code"
            message_to_push = JSON.generate({ type: :code, content: data["content"] })
            ws.send(message_to_push)
          when "command"
            file_content = `#{data["content"]}`
            # hashed_content = { content: file_content }.merge(data["options"])
            message_to_push = JSON.generate({ type: :command, target: data["target"], atome: data["atome"], content: file_content })
            ws.send(message_to_push)
          else
            ws.send("unknown message received")
          end
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
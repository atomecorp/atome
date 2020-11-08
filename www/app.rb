# frozen_string_literal: true

# instructions to install :
# gem install bundler roda sqlite3 sequel rack-unreloader faye-websocket websocket-extensions websocket-driver puma -N
# important if crash the gem install rack-unreloader -v 1.7.0 gem install roda -v 2.26.0
# bundle update
# bundle install
# to run: rackup --server puma --port 4567  or without puma : rackup -p 4567
require "sequel"
require "faye/websocket"
class App < Roda
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
  index_content += "<script>setTimeout(function(){ Opal.Object.$text('good!! Roda & puma are initialized'); }, 500);setTimeout(function(){ Opal.Object.$circle() ; }, 3000)</script>"

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
        # datas = event.data.split(",")
        # db_mode = datas[0]
        # filename = datas[1]
        # content = datas[2]
        ws.send(event.data)
      end
      ws.on :close do |event|
        p [:close, event.code, event.reason]
        ws = nil
      end
      # Return async Rack response
      ws.rack_response
    else
      # Normal HTTP request
      [200, {"Content-Type" => "text/plain"}, ["Hello"]]
    end
    r.root do
      r.redirect "/index"
    end
    r.on "index" do
      r.is do
        r.get do
          # sleep 7
          # box()
          index_content
        end
      end
    end
  end
end
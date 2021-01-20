# frozen_string_literal: true

# instructions to install :
# gem install bundler roda sqlite3 sequel rack-unreloader faye-websocket websocket-extensions websocket-driver puma -N
# important if crash the gem install rack-unreloader -v 1.7.0 gem install roda -v 2.26.0
# bundle update
# bundle install
# to run: rackup --server puma --port 4567  or without puma : rackup -p 4567
require "sequel"
require "faye/websocket"
require "json"

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
        # datas = event.data.split(",")
        # db_mode = datas[0]
        # filename = datas[1]
        # content = datas[2]
        #puts event.data
        #[200, {"Content-Type" => "text/plain"}, [event.data]]

        client_data = event.data
        #puts "client_data : #{client_data.class} , message : #{client_data} "
        #ws.send(event.data)
        #data=JSON.parse(client_data)
        if client_data.is_json?
          data = JSON.parse(client_data)
          puts data
          if data["connection"]
            ws.send('{"connection":{"username":"Régis","accepted":"true"}}')
          else
            ws.send(client_data)
          end

        else
          client_data
        end
        #if valid_json?(client_data)
        #  data = JSON.parse(client_data)
        #  ws.send('{"connection":{"username":"Régis","accepted":"true"}}')
        #  puts data.class
        #end

        #puts "---data---"
        #puts data.class
        #puts "---username---"
        #puts data[:connection][:username]
        #sleep 5
        #ws.send("box({color: :blue})")
        #sleep 3
        #ws.send("text({color: :orange, content: :hello, x: 100, y: 150, size: 70})")
        #'alert("ok")'
      end
      ws.on :open do |event|
        #ws = nil
      end
      ws.on :close do |event|
        #puts [:close, event.code, event.reason]
        #ws = nil
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
          #sleep 7
          #box()
          index_content
        end
      end
    end
  end
end
# collaborate example

# Call login through web socket
class LoginCallback
  def response(response)
    login_button=box({x: 0, y: 80, width: 100, height: 50})
    login_button.text({x:0, y:0, content: "Login response: #{response.JS["log"]}", size: 20, width: :auto})

    @session_id = response.JS["log"]
  end

  def session_id
    @session_id
  end
end

login_callback = LoginCallback.new

login_button=box({x: 0, y: 0, width: 100, height: 50})
login_button.text({x:0, y:0, content: "Login", size: 20, width: :auto})
login_button.touch do
  ATOME.message({request_id: 0, type: :login, username: "user1", password: "password"}, login_callback)
end

# Start a channel through web socket
class StartChannelCallback
  def response(response)
    start_channel_button=box({x: 120, y: 80, width: 100, height: 50})

    @channel_id = response.JS["channel_id"]
    start_channel_button.text({x:0, y:0, content: "Start channel response: #{@channel_id}", size: 20, width: :auto})

  end

  def channel_id
    @channel_id
  end
end

start_channel_callback = StartChannelCallback.new

start_channel_button=box({x: 120, y: 0, width: 100, height: 50})
start_channel_button.text({x:0, y:0, content: "Start channel", size: 20, width: :auto})
start_channel_button.touch do
  ATOME.message({request_id: 1, type: :start_channel, session_id: login_callback.session_id, name: "channel de test"}, start_channel_callback)
end

# List channels through web socket
class ListChannelsCallback
  def response(response)
    list_channels_button=box({x: 240, y: 80, width: 100, height: 50})

    @channels = response.JS["channels"]
    list_channels_button.text({x:0, y:0, content: "List channels response: #{@channels}", size: 20, width: :auto})
  end

  def channels
    @channels
  end
end

list_channels_callback = ListChannelsCallback.new

list_channels_button=box({x: 240, y: 0, width: 100, height: 50})
list_channels_button.text({x:0, y:0, content: "List channels", size: 20, width: :auto})
list_channels_button.touch do
  ATOME.message({request_id: 2, type: :list_channels, session_id: login_callback.session_id}, list_channels_callback)
end

# Connect to channel through web socket
class ConnectChannelsCallback
  def response(response)
    connect_to_channel_button=box({x: 360, y: 80, width: 100, height: 50})

    @connected = response.JS["connected"]
    connect_to_channel_button.text({x:0, y:0, content: "Connect to channel response: #{@connected}", size: 20, width: :auto})
  end

  def connected
    @connected
  end
end

connect_to_channels_callback = ConnectChannelsCallback.new

connect_channel_button=box({x: 360, y: 0, width: 100, height: 50})
connect_channel_button.text({x:0, y:0, content: "Connect to channel", size: 20, width: :auto})
connect_channel_button.touch do
  ATOME.message({request_id: 3, type: :connect_channel, session_id: login_callback.session_id, channel_id: list_channels_callback.channels[0]}, connect_to_channels_callback)
end

# Push to channel through web socket
class PushToChannelsCallback
  def response(response)
    push_to_channel_button=box({x: 480, y: 80, width: 100, height: 50})

    @pushed = response.JS["pushed"]
    push_to_channel_button.text({x:0, y:0, content: "Push to channel response: #{@pushed}", size: 20, width: :auto})
  end

  def pushed
    @pushed
  end
end

push_to_channels_callback = PushToChannelsCallback.new

push_to_channel_button=box({x: 480, y: 0, width: 100, height: 50})
push_to_channel_button.text({x:0, y:0, content: "Push to channel", size: 20, width: :auto})
push_to_channel_button.touch do
  ATOME.message({request_id: 4, type: :push_to_channel, session_id: login_callback.session_id, channel_id: list_channels_callback.channels[0], message: "box({x: 100, y: 100, color: :red})"}, push_to_channels_callback)
end

# collaborate example

# Call login through web socket
class LoginCallback
  def response(response)
    login_button=box({x: 0, y: 80, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})
    login_button.text({x:0, y:0, content: "Login response: #{response.JS["log"]}",width: :auto, visual: 15, center: true, color: {alpha: 0.9}})

    @session_id = response.JS["log"]
  end

  def session_id
    @session_id
  end
end

login_callback = LoginCallback.new

login_button=box({x: 0, y: 0, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})
login_button.text({x:0, y:0, content: "Login",  width: :auto, visual: 15, center: true, color: {alpha: 0.9}})
login_button.touch do
  ATOME.message({request_id: 0, type: :login, username: "user1", password: "password"}, login_callback)
end

# Start a channel through web socket
class StartChannelCallback
  def response(response)
    start_channel_button=box({x: 120, y: 80, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})
    @channel_id = response.JS["channel_id"]
    start_channel_button.text({x:0, y:0, content: "Start channel response: #{@channel_id}",  width: :auto, visual: 15, center: true, color: {alpha: 0.9}})

  end

  def channel_id
    @channel_id
  end
end

start_channel_callback = StartChannelCallback.new

start_channel_button=box({x: 120, y: 0, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})
start_channel_button.text({x:0, y:0, content: "Start channel",width: :auto, visual: 15, center: true, color: {alpha: 0.9}})

start_channel_button.touch do
  ATOME.message({request_id: 1, type: :start_channel, session_id: login_callback.session_id, name: "channel de test"}, start_channel_callback)
end

# List channels through web socket
class ListChannelsCallback
  def response(response)
    list_channels_button=box({x: 240, y: 80, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})

    @channels = response.JS["channels"]
    list_channels_button.text({x:0, y:0, content: "List channels response: #{@channels}",width: :auto, visual: 15, center: true, color: {alpha: 0.9}})
  end

  def channels
    @channels
  end
end

list_channels_callback = ListChannelsCallback.new

list_channels_button=box({x: 240, y: 0, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})
list_channels_button.text({x:0, y:0, content: "List channels",  width: :auto, visual: 15, center: true, color: {alpha: 0.9}})

list_channels_button.touch do
  ATOME.message({request_id: 2, type: :list_channels, session_id: login_callback.session_id}, list_channels_callback)
end

# Connect to channel through web socket
class ConnectChannelsCallback
  def response(response)
    connect_to_channel_button=box({x: 360, y: 80, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})

    @connected = response.JS["connected"]
    connect_to_channel_button.text({x:0, y:0, content: "Connect to channel response: #{@connected}", width: :auto, visual: 15, center: true, color: {alpha: 0.9}})
  end

  def connected
    @connected
  end
end

connect_to_channels_callback = ConnectChannelsCallback.new

connect_channel_button=box({x: 360, y: 0, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})
connect_channel_button.text({x:0, y:0, content: "Connect to channel", width: :auto, visual: 15, center: true, color: {alpha: 0.9}})

connect_channel_button.touch do
  ATOME.message({request_id: 3, type: :connect_channel, session_id: login_callback.session_id, channel_id: list_channels_callback.channels[0]}, connect_to_channels_callback)
end

# Push to channel through web socket
class PushToChannelsCallback
  def response(response)
    push_to_channel_button=box({x: 480, y: 80, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})

    @pushed = response.JS["pushed"]
    push_to_channel_button.text({x:0, y:0, content: "Push to channel response: #{@pushed}",width: :auto, visual: 15, center: true, color: {alpha: 0.9}})
  end

  def pushed
    @pushed
  end
end

push_to_channels_callback = PushToChannelsCallback.new

push_to_channel_button=box({x: 480, y: 0, width: 100, height: 50, color: :orange , smooth: 12, overflow: :auto})
push_to_channel_button.text({x:0, y:0, content: "Push to channel",width: :auto, visual: 15, center: true, color: {alpha: 0.9}})

push_to_channel_button.touch do
  ATOME.message({request_id: 4, type: :push_to_channel, session_id: login_callback.session_id, channel_id: list_channels_callback.channels[0], message: "box({x: 100, y: 100, color: :red})"}, push_to_channels_callback)
end

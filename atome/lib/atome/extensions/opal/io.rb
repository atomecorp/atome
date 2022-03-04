class Http
  def get (filename, &proc)
    `atome.jsReader(#{filename},#{proc})`
  end
end

class WebSocket
  def initialize(address="0.0.0.0:9292", socket_type="ws")
    super()
    @web_socket = `new WebSocketHelper(#{address}, #{socket_type})`
  end

  def send(data, callback)
    # FIXME: Change default to user authentication.
    `#{@web_socket}.sendMessage(#{data.to_n}, #{callback})`
  end
end
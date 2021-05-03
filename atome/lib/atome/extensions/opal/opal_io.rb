class Http
  def get (filename, &proc)
    `atome.jsReader(#{filename},#{proc})`
  end
end

class WebSocket
  def initialize(address)
    super()
    @web_socket = `new WebSocketHelper(#{address})`
  end

  def send(data, callback)
    # FIXME: Change default to user authentication.
    `#{@web_socket}.sendMessage(#{data.to_n}, #{callback})`
  end
end
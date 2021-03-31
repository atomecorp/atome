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

  def send(data)
    # FIXME: Change default to user authentication.
    default = { type: :code, message: :box }
    data = default.merge(data)
    `#{@web_socket}.sendMessage(#{data[:type]}, #{data[:message]})`
  end
end
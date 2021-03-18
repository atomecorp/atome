module JSUtils
  def self.reader (filename, &proc)
    `atome.jsReader(#{filename},#{proc})`
  end

  def remote_server(msg)
    default = {type: :code, message: :box}
    msg = default.merge(msg)
    `message_server(#{msg[:type]}, #{msg[:message]})`
  end

  def shell(command)
    remote({type: :command, message: command})
  end
end
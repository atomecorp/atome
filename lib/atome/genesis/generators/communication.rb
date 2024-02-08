# frozen_string_literal: true

new({ particle: :connection, category: :communication, type: :hash }) do |params, bloc|
  # params = { server: params }
  # type = { server: params }
  params[:user] = Universe.current_user
  params[:pass] = Black_matter.password
  params[:atomes] = Universe.atome_list
  params[:particles] = Universe.particle_list
  # FIXME :  html method shouldn't be here
  html.connect(params, &bloc)
  # test below
  # wait 1 do
  #   message({message: 'cd ..;cd server;ls; pwd', action: :terminal })
  # end
end

new({ particle: :message, category: :communication, type: :hash }) do |params, bloc|

  params = { data: params } unless params.instance_of? Hash
  params[:user] = 'dfghg4df5gdfgh654'
  params[:pass] = 'gfhkzrhgzr4h98948'

  html.send_message(params)
  params[:message_code]=bloc
  params
end

new({ particle: :controller, category: :communication, type: :hash }) do |msg|
  Atome.controller_sender(msg)
end

new({ particle: :int8, category: :communication, type: :int })

new({ particle: :language, category: :communication, type: :string }) do |params|
  @data = int8[params]
  params
end


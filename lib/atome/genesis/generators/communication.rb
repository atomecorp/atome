# frozen_string_literal: true

new({ particle: :connection }) do |params, bloc|
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

new({ particle: :message }) do |params, bloc|

  params = { message: params } unless params.instance_of? Hash
  params[:user] = Universe.current_user
  params[:pass] = Black_matter.password

  html.send_message(params, &bloc)
end

new({ particle: :controller }) do |msg|
  Atome.controller_sender(msg)
end

new({ particle: :int8 })

new({ particle: :language }) do |params|
  @data = int8[params]
  params
end


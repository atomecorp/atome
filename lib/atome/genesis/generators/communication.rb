# frozen_string_literal: true

new({ particle: :connection, category: :communication, type: :hash }) do |params, bloc|
  # params = { server: params }
  # type = { server: params }
  params[:user] = Universe.current_user
  params[:pass] = Black_matter.password
  params[:atomes] = Universe.atome_list
  params[:particles] = Universe.particle_list
  html.connect(params, &bloc)
end

new({ particle: :message, category: :communication, type: :hash }) do |params, bloc|

  params = { message: params } unless params.instance_of? Hash
  params[:user] = Universe.current_user
  params[:pass] = Black_matter.password

  html.send_message(params, &bloc)
end

new({ particle: :controller, category: :communication, type: :hash }) do |msg|
  Atome.controller_sender(msg)
end

new({ particle: :int8, category: :communication, type: :int })

new({ particle: :language, category: :communication, type: :string }) do |params|
  @data = int8[params]
  params
end


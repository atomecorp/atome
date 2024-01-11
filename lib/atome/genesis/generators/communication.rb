# frozen_string_literal: true

new({ particle: :connection }) do |params, bloc|
  params = { server: params } unless params.instance_of? Hash
  html.connect(params[:server], &bloc)
end

new({ particle: :message }) do |params, bloc|

  params = {message:  params } unless params.instance_of? Hash
  params[:user]=Universe.current_user
  params[:pass]=Black_matter.password

  html.send_message(params, &bloc)
end

new({ particle: :controller }) do |msg|
  Atome.controller_sender(msg)
end
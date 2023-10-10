# frozen_string_literal: true

new({ particle: :connection }) do |params, bloc|
  params = { server: params } unless params.instance_of? Hash
  html.connect(params[:server], &bloc)
end

new({ particle: :message }) do |params, bloc|
  params = { server: params } unless params.instance_of? Hash
  html.send_message(params[:server], &bloc)
end
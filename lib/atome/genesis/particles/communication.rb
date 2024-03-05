# frozen_string_literal: true

new({ particle: :connection, category: :communication, type: :hash }) do |params, bloc|

  # FIXME :  html method shouldn't be here
  html.connect(params, &bloc)
end

new({ particle: :message, category: :communication, type: :hash }) do |params, bloc|
  if Universe.database_ready
    params = { data: params } unless params.instance_of? Hash
    message_id= "msg_#{Universe.messages.length}"
    params[:message_id]=message_id
    Universe.store_messages({msg_nb:message_id, proc: bloc })
    html.send_message(params)
  else
    puts "server not ready "
  end


end

new({ particle: :controller, category: :communication, type: :hash }) do |msg|
  Atome.controller_sender(msg)
end

new({ particle: :int8, category: :communication, type: :int })

new({ particle: :language, category: :communication, type: :string }) do |params|
  @data = int8[params]
  params
end


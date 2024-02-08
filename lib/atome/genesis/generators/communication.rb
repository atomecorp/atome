# frozen_string_literal: true

new({ particle: :connection, category: :communication, type: :hash }) do |params, bloc|
  params[:user] = Universe.current_user
  params[:pass] = Black_matter.password
  params[:atomes] = Universe.atome_list
  params[:particles] = Universe.particle_list
  # FIXME :  html method shouldn't be here
  html.connect(params, &bloc)
end

new({ particle: :message, category: :communication, type: :hash }) do |params, bloc|
  params = { data: params } unless params.instance_of? Hash
  params[:user] = 'dfghg4df5gdfgh654'
  params[:pass] = 'gfhkzrhgzr4h98948'
 instance_variable_set('@message_code', {}) unless instance_variable_get('@message_code')
  store_proc= instance_variable_get('@message_code')
  mmessage_id= "msg_#{store_proc.length}"
  store_proc[mmessage_id]=bloc
  html.send_message(params)

end

new({ particle: :controller, category: :communication, type: :hash }) do |msg|
  Atome.controller_sender(msg)
end

new({ particle: :int8, category: :communication, type: :int })

new({ particle: :language, category: :communication, type: :string }) do |params|
  @data = int8[params]
  params
end


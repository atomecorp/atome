# frozen_string_literal: true

new({particle: :duplicate, store: false}) do |params|
  new_atome_id=:toto
  new_atome=Atome.new({ type: @type, renderers: @renderers, id: new_atome_id  })

  instance_variables.each do |particle_found|
    particle_name=particle_found.to_s.sub('@','')
    unless particle_name == 'history' || particle_name == 'callback' || particle_name ==  'touch_code' || particle_name ==  'html'

      particle_content = self.send(particle_name)
        puts "#{particle_name} : #{particle_content}"
        new_atome.set(particle_name => particle_content)

    end

  end
  if params.instance_of? Hash
    params.each do |k,v|
      new_atome.send(k,v)
    end
  end
  new_atome.id(new_atome_id)
  # alert "=> #{new_atome.id}"
   @duplicate ||= {}
  @duplicate[new_atome_id] = new_atome

  @duplicate
# :poi
  # :poil
end


b=box({id: :the_boxy})
# b.touch(true)  do
alert b.inspect
  # bb=b.duplicate({top: 33})
# bb=b.left(44)
# bbb= bb[:toto]
# alert b.inspect
# alert bbb.inspect

# wait 1 do
#   b.left(333)
#   wait 1 do
#     grab(:toto).top(44)
#
#   end
# end
# bbb.left(3333)
#   # alert b.id
#   # wait 2 do
#   #   alert bb.id
#   #   # b.top(1)
#   # end
#   # alert bb
#   bbb.set({left: 2})
#   bbb.set({top: 2})
#   bbb.set({width: 28})
#   bbb.set({height: 82})
# end


# full of hate full of love full of pain full of revenge
# i just wanna feel better , just wanna forget not sure I'll forgive
# better be dead than live this , better feel alive than dying in your arms
# so much power now , so little power on you
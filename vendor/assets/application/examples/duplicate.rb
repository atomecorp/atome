# frozen_string_literal: true

new({particle: :duplicate, store: false}) do |p|
  new_atome=Atome.new({ type: @type, renderers: @renderers  })

  instance_variables.each do |particle_found|
    particle_name=particle_found.to_s.sub('@','')
    unless particle_name == 'history' || particle_name == 'callback'
    particle_content = self.send(particle_name)
    puts "#{particle_name} :#{particle_content}"
      new_atome.set(particle_name => particle_content)
    end

  end
  @duplicate = new_atome


end


b=box({id: :the_boxy})

bb=b.duplicate({top: 33})


alert bb
bb.set({left: 2})
bb.set({top: 2})
bb.set({width: 28})
bb.set({height: 82})
# full of hate full of love full of pain full of revenge
# i just wanna feel better , just wanna forget not sure I'll forgive
# better be dead than live this , better feel alive than dying in your arms
# so much power now , so little power on you
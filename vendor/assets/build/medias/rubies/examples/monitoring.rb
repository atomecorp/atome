# frozen_string_literal: true
class Atome

  # def broadcasting(modified_particle, value)
  #   @broadcast.each_value do |particle_monitored|
  #     if particle_monitored[modified_particle]
  #       code_found = particle_monitored[modified_particle]
  #       instance_exec(self, modified_particle, value, &code_found) if code_found.is_a?(Proc)
  #     end
  #   end
  # end

  # def monitor(params, &proc_monitoring)
  #   atome[:monitor] ||= {}
  #   params[:atomes].each do |atome_id|
  #     target_broadcaster = grab(atome_id).instance_variable_get('@broadcast')
  #     monitor_id = params[:id] || "monitor#{target_broadcaster.length}"
  #     atome[:monitor] [monitor_id]=params.merge({code: proc_monitoring})
  #     params[:particles].each do |targeted_particle|
  #       target_broadcaster[monitor_id] = { targeted_particle => proc_monitoring }
  #     end
  #   end
  # end

  # def store_value(element, value)
  #   # this method save the value of the particle and broadcast to the atomes listed in broadcast
  #   broadcasting(element, value)
  #   inject_value(element, value)
  # end

end

a = text({ data: "open the console!" })
a.right(44).left(66)

b = Atome.new(shape: { type: :shape, id: :my_shape, children: [], parents: [:view], renderers: [:browser],
                       left: 0, right: 33
})

c = Atome.new(shape: { type: :shape, id: :my_pix, children: [], parents: [:view], renderers: [:browser],
                       left: 50, right: 78
})

a.monitor({ atomes: grab(:view).children.value, particles: [:left] }) do |atome, element, value|
  puts "monitoring: #{atome.id}, #{element}, #{value}"
end

b.left(936)
b.left(777)
c.left(888)

# test 2
aa = text({ data: 'touch me and look in the console', top: 99, width: 399, left: 120 })
aa.touch(true) do
  aa.color(:red)
  aa.left(333)
  aa.width(555)
  aa.right(4)
  aa.height(199)
end

aa.box({ id: :theboxy })

aa.monitor({ atomes: grab(:view).children.value, particles: [:left] }) do |_atome, _element, value|
  puts "the left value was change to : #{value}"
end

aa.monitor({ atomes: grab(:view).children.value, particles: [:width] }) do |_atome, _element, value|
  puts "the width's value was change to : #{value}"
end

aa.monitor({ atomes: grab(:view).children.value, particles: [:left], id: :my_monitorer }) do |_atome, _element, value|
  puts "the second monitor left value was log to : #{value}"
end

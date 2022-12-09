# frozen_string_literal: true
generator = Genesis.generator


generator.build_particle(:clones) do |clones_found|

  clones_found.each_with_index  do |clone_found, index|
    clone_id="#{particles[:id]}_clone_#{index}"
    original_id=atome[:id]
    clone_found[:id] = clone_id
    clone_found = particles.merge(clone_found)
    cloned_atome=Atome.new({ shape: clone_found })

    cloned_atome.monitor({ atomes: [original_id], particles: [:width, :attached,:height ]}) do |atome, particle, value|
      cloned_atome.send(particle,value)
    end
  end

end

# generator.build_particle(:particles) do |particles_found|
#
#   particles_found.each do |particle_found, value_found|
#     atome[particle_found]=value_found
#   end
# end

# generator.build_option(:pre_get_particles) do |value,proc, current_atome|
#   # alert  self
#   "lkjlkj"
# end
class Atome
  def particles(particles_found = nil)
    if particles_found
      particles_found.each do |particle_found, value_found|
        atome[particle_found] = value_found
      end
    else
      atome
    end
  end
end

b = box({ color: :red, smooth: 6 })
#
  b.clones([ left: 333, top: 300 ])
#   alert b
#
wait 1 do
  b.width(500)

end

wait 2 do
  b.height(500)
end
# text({ id: :the_text, left: 0 })

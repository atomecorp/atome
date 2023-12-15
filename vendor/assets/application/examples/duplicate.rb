# frozen_string_literal: true

# new({ particle: :duplicate, store: false }) do |params|
#   if @duplicate
#     copy_number = @duplicate.length
#   else
#     copy_number = 0
#   end
#
#   new_atome_id = "#{@id}_copy_#{copy_number}"
#   new_atome = Atome.new({ type: @type, renderers: @renderers, id: new_atome_id })
#
#   attached_atomes = []
#   attached_found = attached.dup
#   particles_found = instance_variables.dup
#
#   particles_found.delete(:@history)
#   particles_found.delete(:@callback)
#   particles_found.delete(:@duplicate)
#   particles_found.delete(:@touch_code)
#   # touch_code=instance_variable_get('@touch_code')
#   particles_found.delete(:@html)
#   particles_found.delete(:@attached)
#   particles_found.delete(:@id)
#   params[:id] = new_atome_id
#   attached_found.each do |child_id_found|
#     child_found = grab(child_id_found)
#     if child_found
#       new_child = child_found.duplicate({})
#       attached_atomes << new_child.id
#     end
#   end
#   particles_found.each do |particle_found|
#     particle_name = particle_found.to_s.sub('@', '')
#     particle_content = self.send(particle_name)
#     new_atome.set(particle_name => particle_content)
#     # new_atome.instance_variable_set('@touch_code',touch_code)
#   end
#   params[:attached] = attached_atomes
#
#   if params.instance_of? Hash
#     params.each do |k, v|
#       new_atome.send(k, v)
#     end
#   end
#
#   @duplicate ||= {}
#   @duplicate[new_atome_id] = new_atome
#   new_atome
# end
#
# new({ after: :duplicate }) do |params|
#   @duplicate[@duplicate.keys[@duplicate.keys.length - 1]]
# end

b = circle({ id: :the_cirlce })
b.text(:hello)
bb = b.duplicate({  width: 33, left: 234, top: 222 })
bb.color(:red)
wait 1 do
bb2 = b.duplicate({ width: 33, left: 12 })
bb3 = b.duplicate({ width: 33, left: 444 })
bb3.color(:green)
bb2.color(:orange)
end


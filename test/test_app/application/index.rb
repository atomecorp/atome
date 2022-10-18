# animation atome
Genesis.atome_creator(:animation)
Genesis.generate_html_renderer(:animation) do |value, atome, proc|
  id_found = id
  instance_exec(&proc) if proc.is_a?(Proc)
  DOM do
    div(id: id_found)
  end.append_to($document[:user_view])
  @html_object = $document[id_found]
  @html_type = :div
end
Genesis.particle_creator(:code)
Genesis.generate_html_renderer(:code) do |value, atome, proc|
  # alert proc
  # @html_object << value
end
Genesis.particle_creator(:target) do |params|
  # alert params
end

Genesis.particle_creator(:bloc)
Genesis.atome_creator_option(:bloc_pre_render_proc) do |params|
  proc_found = params[:value][:bloc]
  instance_exec(&proc_found) if proc_found.is_a?(Proc)

  params[:value]
end
Genesis.generate_html_renderer(:target) do |value, atome, proc|
  @html_object
end
# Genesis.generate_html_renderer(:bloc) do |value, atome, proc|
#   # alert value
#
# end
Genesis.particle_creator(:data)
# Anim verif

anim1={
  start: { smooth: 0, blur: 0, rotate: 0, color: { red: 1, green: 1, blue: 1 } },
  end: { smooth: 25, rotate: 180, blur: 20, color: { red: 1, green: 0, blue: 0 } },
  duration: 1000,
  loop: 1,
  curve: :easing,
  target: :my_shape
}

animation = Atome.new(
  animation: { render: [:html], id: :anim1, type: :animation, parent: [:view], target: :image1, code: anim1, left: 333, top: 333, width: 199, height: 99,
  }
  # animation: { render: [:html], id: :anim1, type: :animation, parent: [:view], target: :image1, code: "alert :web", left: 333, top: 333, width: 199, height: 99,
  # }
) do
  puts "proc exec added at atome creation level : #{self.class}"
end
Genesis.particle_creator(:play)

# animation=box
animation.play(true)


#TODO int8! : language


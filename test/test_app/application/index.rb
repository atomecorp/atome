# # TODO: when using Rake the atomejs and others are rebuild iun test application
# # TODO : maybe revert default renderer to headless istead of html
# # ###################### animation tests
# #
# # Genesis.atome_creator(:animator)
# # Genesis.generate_html_renderer(:animator) do |value, atome, proc|
# #   id_found = id
# #   instance_exec(&proc) if proc.is_a?(Proc)
# #   DOM do
# #     div(id: id_found)
# #   end.append_to($document[:user_view])
# #   @html_object = $document[id_found]
# #   @html_type = :div
# # end
# #
# #
# #
# #
# # Genesis.particle_creator(:target) do |params|
# #   # alert params
# # end
# #
# # Genesis.generate_html_renderer(:target) do |value, atome, proc|
# #   @html_object
# # end
# #
# #
# #
# # def animation(params = {}, &proc)
# #   Utilities.grab(:view).animation(params, &proc)
# # end
# #
# #
# # class Atome
# #
# #   def animation(params = {}, &proc)
# #     generated_id = params[:id] || "animation_#{Universe.atomes.length}"
# #     generated_parent = params[:parent] || id
# #
# #     temp_default = { id: generated_id, type: :animator, parent: [generated_parent], bloc: proc }
# #     params = temp_default.merge(params)
# #     # alert params
# #     new_atome = Atome.new({ animator: params })
# #     new_atome.animator
# #   end
# #
# #   def play_animator(params)
# #     "I play the animation : #{params}"
# #     exec_found = params[:atome].bloc
# #     instance_exec('::callback from anim player', &exec_found) if exec_found.is_a?(Proc)
# #   end
# # end
# #
# # ######################################
# # # Anim verif
# #
# # anim1 = {
# #   start: { smooth: 0, blur: 0, rotate: 0, color: { red: 1, green: 1, blue: 1 } },
# #   end: { smooth: 25, rotate: 180, blur: 20, color: { red: 1, green: 0, blue: 0 } },
# #   duration: 1000,
# #   loop: 1,
# #   curve: :easing,
# #   target: :my_shape
# # }
# # my_anim = animation({ data: anim1, id: :my_animation }) do |params|
# #   puts "animation params callback is : #{params} #{self.id}"
# # end
# # my_anim.play(true)
# # alert my_anim
# #
# # my_animation = Atome.new(
# #   animator: { render: [:html], id: :anim12, type: :animator, parent: [:view], target: :image1, data: anim1, left: 333, top: 333, width: 199, height: 99,
# #   }
# # # animator: { render: [:html], id: :anim1, type: :animator, parent: [:view], target: :image1, code: "alert :web", left: 333, top: 333, width: 199, height: 99,
# # # }
# # ) do
# #   puts "non proc exec added at atome creation level : #{self.class}"
# # end
# ############# Drag ###########
#
# box({width: 333, height: 333, id: :the_constraint_box, color: :orange})
#
# b = box
#
# b.drag({ remove: true}) do |position|
#   # below here is the callback :
#   puts "1 - callback drag position: #{position}"
#   puts "1 - callback id is: #{id}"
# end
#
# wait 4 do
#   b.drag({ max: { left: 333 ,right: 90, top: 333, bottom: 30}})
# end
#
# bb = box({ left: 120, color: :green })
# bb.touch(true) do
#   alert left
# end
#
# bb.drag({ lock: :x }) do |position|
#   # below here is the callback :
#   puts "2 - drag position: #{position}"
#   puts "2 - id is: #{id}"
# end
# #TODO: when we add a color we must change the code : do we create a new color with it's id or do we replace the old one?
# #
# bbb = box({ left: 120, top: 120 })
# bbb.drag({}) do |position|
#   # below here is the callback :
#   puts "bbb drag position: #{position}"
#   puts "bbb id is: #{id}"
# end
# bbb.color(:black)
#
# bbb.remove(:drag)
# wait 3 do
#   bbb.drag({fixed: true}) do |position|
#     puts position
#   end
# end
#
# circle({drag: {inside: :the_constraint_box}, color: :red})

#TODO: gem install webrick  ; ruby -run -e httpd . -p 8080
#TODO: new id Scheme base on id, with verification if already exist
#FIXME : if we change the id, changing the color crash
#TODO try to add Shape and Image Class

class Universe
  def self.initialize
    @atomes = {}
  end

  def self.atomes_add(new_atome, atome_id)
    new_atome.instance_variable_set('@id', atome_id)
    @atomes[atome_id] = new_atome
  end

  def self.change_atome_id(prev_id, new_id)
    @atomes[new_id] = @atomes.delete(prev_id)
  end

  def self.delete(id)
    @atomes.delete(id)
  end

end

module Genesis
  def create_new_atomes(params, instance_var, new_atome, &userproc)
    atome_id = params.delete(:id)
    return false unless Universe.atomes_add(new_atome, atome_id)
    instance_variable_set(instance_var, new_atome)
    params.each do |param, value|
      new_atome.send(param, value)
    end
    new_atome
  end
end

module Utilities
  def self.grab(params)
    Universe.atomes[params]
  end

end

Genesis.atome_creator_option(:id_pre_render_proc) do |params|
  # prev_id = params[:atome].id
  new_id = params[:value]
  current_atome = params[:atome]
  # Universe.change_atome_id(prev_id, new_id)
  particles_found = current_atome.particles
  current_atome.delete(true)
  particles_found[:id] = new_id
  particles_found.delete(:html_type)
  particles_found.delete(:html_object)
  ##################### trying to reconnect atomes
  atomes_to_re_attach= {}
   Utilities.atome_list.each do |atome_found|

     # unless particles_found.delete(atome_found).nil?
     atome_found= particles_found.delete(atome_found)
     # alert atome_found
     if atome_found
         # atome_found_particles=atome_found
         atomes_to_re_attach[atome_found.type]=atome_found
     end

   end

  # atomes_to_re_attach.each do |particle|
  #   type_found= particle[:type]
  #   particle.delete(:html_type)
  #   particle.delete(:html_object)
  #
  #   renamed_atome.send(type_found,particle)
  # end
  ##################### trying to reconnect atomes

  dna_found=particles_found.delete(:dna)
  type_found=  particles_found[:type]
  renamed_atome=Atome.new({type_found => particles_found })
  renamed_atome.instance_variable_set("@dna",dna_found)
  ##################### trying to reconnect atomes
  atomes_to_re_attach.each do |atome_to_attatch, content|
    renamed_atome.instance_variable_set("@#{atome_to_attatch}", content)
  end
  ##################### trying to reconnect atomes
  alert renamed_atome
  renamed_atome
end

class Atome
  def delete(params)

    self.html_object&.remove
    Universe.delete(id)
    # grab(child_found).html_object&.remove
  end
end


# alert Universe.atomes

############# for test only
#
# Genesis.generate_html_renderer(:type) do |value, atome, proc|
#   send("#{value}_html", value, atome, proc)
#   value
# end
#
# Genesis.generate_html_renderer(:shape) do |value, atome, proc|
#   id_found = id
#   instance_exec(&proc) if proc.is_a?(Proc)
#   DOM do
#     div(id: id_found).atome
#   end.append_to($document[:user_view])
#   @html_object = $document[id_found]
#   @html_type = :div
# end
############# verif


b = box({ id: :kool })
# alert b.parent
# b.delete(true)
# alert b.color
b.color(:orange)
# alert b.color
b.id(:okpp)
grab(:okpp).color(:cyan)
# b.color(:orange)
# Atome.new({ "shape": {render: [:html], id: :view_test, type: :shape, parent: [:view], "width" => 99, "height" => 99, "left" => 9, "top" => 9 } })
# Atome.new({"shape"=>{"render"=>["html"], "id"=>"okpp", "parent"=>["view"], "width"=>99, "height"=>99, "left"=>9, "top"=>9}})
# { shape: { render: [:html], id: :view_test, type: :shape, parent: [:view],
#            left: 0, width: 90, top: 0, height: 90, overflow: :auto,
#            color: { render: [:html], id: :view_test_color, type: :color,
#                     red: 1, green: 0.15, blue: 0.15, alpha: 1 } } }

# Atome.new({"render"=>["html"], "child"=>["color_kool"], "type"=>"shape", "width"=>99, "height"=>99, "left"=>9, "top"=>9, })
# # # # alert b.id
# # b.left(66)
# # grab(:okpp).top(333)
# # # alert b.id

# # # c=circle({id: :kool, top: 99})
# #
# grab(:okpp).color(:pink)

############# endverif

# class Sshape  < Atome
#
#   def initialize
#     @atome=  Atome.new(
#       { shape: { render: [:html], id: :view_test, type: :shape, parent: [:view],
#                  left: 0, width: 90, top: 0, height: 90, overflow: :auto,
#                  color: { render: [:html], id: :view_test_color, type: :color,
#                           red: 0, green: 0.15, blue: 0.15, alpha: 1 } } }
#     )
#   end
#
#   def color(val)
#     @atome.color(val)
#   end
# end
#
# class Image < Atome
#
# end
#
# s=Shape.new
# alert s.class
#
# wait 2 do
#   s.color({ render: [:html], id: :view_test_color, type: :color,
#             red: 1, green: 0.15, blue: 0.15, alpha: 1 })
# end
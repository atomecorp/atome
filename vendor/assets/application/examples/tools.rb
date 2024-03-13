# frozen_string_literal: true

# Universe.allow_history = false

color({ id: :creation_layer_col, alpha: 1 })

b = box({ top: :auto, bottom: 0, id: :box_tool })

b.touch(:down) do
  creation_layer = box({ top: 0, left: 0, id: :creation_layer, width: '100%', height: '100%', apply: :creation_layer_col })
  creation_layer.touch(:down) do |event|
    left_found = event[:pageX].to_i
    top_found = event[:pageY].to_i
    box({ left: left_found, top: top_found ,id: "tutu_#{Universe.atomes.length}", color: :red})
    creation_layer.delete(true)
    creation_layer.touch({ remove: :down })
    puts Universe.atomes.length
    puts "=> #{Universe.user_atomes}"
  end
end


#
# ######################
#
# # frozen_string_literal: true
# class Atome
#
#   def build_tool(&bloc)
#     # alert params[:tool]
#     a = Atome.instance_exec(&bloc)
#     puts "===> a is : #{a[:action]}"
#     # check below
#     # wait 2 do
#     #   send a[:action]
#     # end
#     grab(:toolbox).box({color: :white, width: Intuition.style[:tool][:width], height: Intuition.style[:tool][:width]})
#   end
# end
#
# class Object
#   def new(params, &bloc)
#     # Genesis = Genesis.Genesis
#     if params.key?(:atome)
#       Universe.add_atomes_specificities params[:atome]
#       Genesis.build_atome(params[:atome], &bloc)
#     elsif params.key?(:particle)
#       Atome.instance_variable_set("@main_#{params[:particle]}", bloc)
#       # render indicate if the particle needs to be rendered
#       # store tell the system if it need to store the particle value
#       # type help the system what type of type the particle will receive and store
#       Genesis.build_particle(params[:particle], { render: params[:render], return: params[:return],
#                                                   store: params[:store], type: params[:type] }, &bloc)
#     elsif params.key?(:sanitizer)
#       Genesis.build_sanitizer(params[:sanitizer], &bloc)
#     elsif params.key?(:pre)
#       Atome.instance_variable_set("@pre_#{params[:pre]}", bloc)
#     elsif params.key?(:post)
#       Atome.instance_variable_set("@post_#{params[:post]}", bloc)
#     elsif params.key?(:after)
#       Atome.instance_variable_set("@after_#{params[:after]}", bloc)
#     elsif params.key?(:read)
#       Atome.instance_variable_set("@read_#{params[:read]}", bloc)
#     elsif params[:renderer]
#       renderer_found = params[:renderer]
#       if params[:specific]
#         Universe.set_atomes_specificities(params)
#         params[:specific] = "#{params[:specific]}_"
#       end
#       render_method = "#{renderer_found}_#{params[:specific]}#{params[:method]}"
#       Genesis.build_render(render_method, &bloc)
#     elsif params.key?(:callback)
#       particle_targetted = params[:callback]
#       Atome.define_method "#{particle_targetted}_callback" do
#         bloc.call
#       end
#     elsif params.key?(:tool)
#       A.build_tool(&bloc)
#     end
#   end
# end
#
#
# def record_tool
#   grab(Universe.current_user).selection
#   alert "must get selection to treat it "
# end
#
#
# module Intuition
#   class << self
#     def style
#       size=39
#       style={}
#       style[:toolbox]={width: size}
#       style[:toolbox]={height: size}
#       style[:tool]={width: size}
#       style[:tool]={height: size}
#
#       style
#     end
#     def intuition_int8
#       # tool taxonomy and list
#       {
#         capture: { int8: { french: :enregistrement, english: :record, german: :datensatz } },
#         communication: { french: :communication, english: :communication, german: :communication },
#         tool: { french: :outils, english: :tools, german: :werkzeuge },
#         view: { french: :vue, english: :view, german: :aussicht },
#         time: { french: :horloge, english: :clock, german: :Uhr },
#         find: { french: :trouve, english: :find, german: :finden },
#         home: { french: :accueil, english: :home, german: :zuhause },
#         code: { french: :code, english: :code, german: :code },
#         impulse: { french: :impulse, english: :impulse, german: :impulse },
#       }
#     end
#     def intuition_taxonomy
#
#     end
#
#     def impulse
#       # tool start point
#       [:capture, :communication, :tool, :view, :time, :find, :home]
#     end
#   end
#
#
#   # def capture
#   #   categories=ATOME.methods_categories
#   #   [categories[:inputs]]
#   # end
#   #
#   # def communication
#   #   categories=ATOME.methods_categories
#   #   [categories[:communications]]
#   # end
#   #
#   # def toolz
#   #   categories=ATOME.methods_categories
#   #   [categories[:spatials],categories[:helpers],categories[:materials],
#   #    categories[:geometries],categories[:effects],
#   #    categories[:medias],categories[:hierarchies],categories[:utilities],categories[:events]]
#   # end
#   #
#   # def tool_style(size = 33)
#   #   # styling
#   #   shadows = [{ x: size / 15, y: size / 15, thickness: 0, blur: size / 3, color: { red: 0, green: 0, blue: 0, alpha: 0.3 } }, { x: -size / 15, y: -size / 15, thickness: 0, blur: size / 6, color: { red: 1, green: 1, blue: 1, alpha: 0.3 } }]
#   #   style = { type: :tool, content: { points: 4 }, color: { red: 0.9, green: 0.9, blue: 0.9, alpha: 0.15 }, parent: :intuition, shadow: shadows, blur: { value: 6, invert: true } }
#   #   return style
#   # end
#   #
#   # def open_tool(tool_id, widthness=3, orientation=:x, speed=0.6)
#   #   if orientation == :x
#   #     orientation = :width
#   #     value = grab(tool_id).width
#   #   else
#   #     orientation = :height
#   #     value = grab(tool_id).height
#   #   end
#   #   animate({
#   #             start: { orientation => value },
#   #             end: { orientation => value * widthness },
#   #             duration: speed * 1000,
#   #             loop: 0,
#   #             curve: :easing,
#   #             target: tool_id
#   #           })
#   #   notification "find why this id #{self.atome_id}, add annimation callback to set overflow when anim complete"
#   #   grab(tool_id).overflow(:visible)
#   # end
#   #
#   # def close_tool(tool_id, widthness, orientation, speed)
#   #   if orientation == :x
#   #     orientation = :width
#   #     value = grab(tool_id).width
#   #   else
#   #     orientation = :height
#   #     value = grab(tool_id).height
#   #   end
#   #   animate({
#   #             start: { orientation => value * widthness },
#   #             end: { orientation => value },
#   #             duration: speed * 1000,
#   #             loop: 0,
#   #             curve: :easing,
#   #             target: tool_id
#   #           })
#   #   # grab(tool_id).overflow(:hidden)
#   # end
#   #
#   # def create_tool(tool_name, size = 33, x_pos = 0, y_pos = 33, offsset=0)
#   #   tool_created = tool(self.tool_style(size).merge({ parent: :main_menu, atome_id: "tool_" + tool_name, id: "tool_" + tool_name,
#   #                                                     width: size, height: size, smooth: size / 9, overflow: :hidden, x: x_pos, y: y_pos, z: 1, content: [] }))
#   #   icon=tool_created.shape({ path: tool_name, width: size - size / 2, height: size - size / 2, center: true })
#   #   # name = intuition_list[tool_name][language]
#   #   particle({ atome_id: :tools_property_container, color: { red: 0.6, green: 0.6, blue: 0.6 } })
#   #   # we get the plugin code only if the plugin hasn't been interpreted before (unless condition below)
#   #   unless grab(:intuition).content.include? tool_name
#   #     ATOME.reader("./medias/e_rubies/tools/#{tool_name}.rb") do |data|
#   #       #  todo add a security parser here
#   #       # we set the variable tool that can be used to facilitate plugin creation
#   #       data="tool=grab(:#{tool_created.atome_id})\n"+data
#   #       compile(data)
#   #       # we add the tool to the intuition content so it won't be loaded twice
#   #       grab(:intuition).content |= [tool_name]
#   #     end
#   #   end
#   #   # end
#   #   tool_created.active({ exec: false })
#   #   tool_created.inactive({ exec: false })
#   #   icon.touch(stop: true) do
#   #     if tool_created.active[:exec] == true
#   #       tool_created.color(:transparent)
#   #       tool_created.active(exec: false, proc: tool_created.active[:proc]  )
#   #       tool_created.inactive(exec: true, proc: tool_created.inactive[:proc]  )
#   #     else
#   #       tool_created.color({alpha: 0.3})
#   #       tool_created.active({ exec: true, proc: tool_created.active[:proc]  })
#   #     end
#   #   end
#   # end
#   #
#   # # we get menu entry point
#   # def open_intuition(position = {})
#   #   position = { x: 0, yy: 0, size: 33, orientation: :vertical, offset: 0 }.merge(position)
#   #   # we get content language from view's language
#   #   if grab(:main_menu)
#   #     grab(:main_menu).delete
#   #   else
#   #     grab(:view).language
#   #     self.language(grab(:view).language)
#   #     orientation = position.delete(:orientation)
#   #     size = position.delete(:size)
#   #     offset = position.delete(:offset)
#   #     # positioning and scaling
#   #     if orientation == :vertical
#   #       requested_width = size
#   #       requested_height = (size+offset)* impulse.length
#   #     else
#   #       requested_width = (size+offset) * impulse.length
#   #       requested_height = size
#   #     end
#   #     tool({ atome_id: :main_menu, parent: :intuition, color: { alpha: 0 } }.merge(position).merge(width: requested_width, height: requested_height))
#   #     impulse.each_with_index do |item, index|
#   #       if orientation == :vertical
#   #         create_tool(item, size, 0, index * (size+offset))
#   #       else
#   #         create_tool(item, size, index * (size+offset), 0)
#   #       end
#   #     end
#   #   end
#   # end
# end
# # atome class extension for eVe
#
# class Atome
#   include Intuition
#   #  def atome(requested_property)
#   #    # add component list iin the content we maybe ahave to create a tool object because box can't handle this type of content
#   #    new_atome=self.tool({ atome_id: "#{self.atome_id}_#{requested_property}_atome_#{self.content.length}", x: 66})
#   #    new_atome.touch({ stop: true, option: :down}) do
#   #      color(:red)
#   #      new_atome.height = new_atome.height*3
#   #    end
#   #    new_atome.touch({ stop: true, option: :up}) do
#   #      color(:red)
#   #      new_atome.height = new_atome.height/3
#   #    end
#   #    notification "now we have to add an object or a new property (style) to store complete tool style including size and
#   # orientation so we can position the new atome correctly"
#   #    # alert self.content.class
#   #    # alert self.content.length
#   #    # alert tool_style
#   #  end
# end
#
# # # we initialise the toolbox here :
# #
# # # the launch bar
# # launch_bar = box({ x: 0, y: 0, width: 33, height: "100%", parent: :intuition, z: 0, color: { alpha: 0 } })
# # launch_bar.touch({ option: :long }) do |evt|
# #   size = 33
# #   yy_touch_position = grab(:view).convert(:height) - evt.page_y
# #   if yy_touch_position < size
# #     #if the long touch is within the wanted area( in this  at bottom of the screen) we open the menu
# #     # launch_bar.open_intuition({ x: size, yy: 6,offset: 6, orientation: :horizontal, size: size })
# #     launch_bar.open_intuition({ x: 6, yy: size,offset: 6, orientation: :vertical, size: size })
# #   end
# # end
# #
# # # # # # # # # # # # # # # # tests below   # # # # # # # # # # # # #
# #
# # list = molecule_analysis(@molecules_list)
# # notif list[:tools]
# # notif "======"
# # notif list[:molecules]
# # notif "======"
# # notif list[:atomes]
# # notif "======"
# # notif list[:molecules][:shadow]
# # let's build the toolbox
# grab(:intuition).box({id: :toolbox, top: :auto, bottom: 0, left: 0, width: Intuition.style[:toolbox][:width], height: 255})
#
# # tool builder
#
# new({ tool: :capture }) do |params|
#   tool = { id: :rec_01,
#            name: :record, icon: :record, action: {open: [:sub_menu]},  code: :record_tool, position: { root: 1 }, # position can be multiple
#            option: { opt1: :method_2 }, int8: { french: :enregistrement, english: :record, german: :datensatz } }
#   tool
# end
# # Intuition::toolbox_style
# # Intuition.toolbox_style
# # puts A.impulse
# # def fill_toolzone(tools_ids)
# #
# # end
# #
# # fill_toolzone(%i[files edition select group link copy undo settings])
#


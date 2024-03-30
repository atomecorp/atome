# frozen_string_literal: true

# frozen_string_literal: true
# text(:hello)
element({ aid: :toolbox_style, id: :toolbox_style, data: { color: :gray, size: 39 } })

class Atome
  def build_tool(params, &bloc)

    # default_params={author: alert Universe.current_user}
    tool_box_style = grab(:toolbox_style).data
    tool_size = tool_box_style[:size]
    # puts "intuition data is used to store user choices for colors, size, etc..  #{grab(:intuition).data}"
    tool_name = params[:tool]
    color({ id: :creation_layer_col, alpha: 0 })
    color({ id: :active_tool_col, alpha: 1, red: 1, green: 1, blue: 1 })
    color({ id: :inactive_tool_col, alpha: 0.6 })
    tool_content = Atome.instance_exec(&bloc)
    tool = grab(:toolbox).box({ aid: "#{tool_name}_tool", id: "#{tool_name}_tool", apply: [:inactive_tool_col], width: 33, height: 33, top: tool_size * grab(:toolbox).attached.length })
    tool.touch(true) do |ev|
      alert "intuition data is used to store user choices for colors, size, etc..  #{grab(:intuition).data}"
      tick(tool_name)
      if tick[tool_name] == 1 # first click
        tool.apply(:active_tool_col)
        unless grab(:creation_layer)
          alert grab(:creation_layer).class
          creation_layer = grab(:view).box({ id: :creation_layer, top: 0, left: 0, aid: :creation_layer, width: '100%', height: '100%', apply: :creation_layer_col })
          # creation_layer.touch(:down) do |event|
          #   puts "<< Syncing >>"
          #   tool_content[:active].each do |code_exec|
          #     Atome.instance_exec(event, &code_exec)
          #   end
          # end
        end
        grab(:creation_layer).touch(:down) do |event|
          puts "<< Syncing >>"
          tool_content[:active].each do |code_exec|
            Atome.instance_exec(event, &code_exec)
          end
        end
      else
        tool.apply(:inactive_tool_col)
        tool_content[:inactive].each do |code_exec|
          Atome.instance_exec(params, &code_exec)
        end if tool_content[:inactive]
        creation_layer = grab(:creation_layer)
        if grab(:creation_layer)
          creation_layer.delete(true)
          creation_layer.touch({ remove: :down })
        end
        tick[tool_name] = 0
      end
    end
  end
end

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
#       A.build_tool(params, &bloc)
#     elsif params.key?(:template)
#       A.build_template(&bloc)
#     elsif params.key?(:code)
#       A.build_code(&bloc)
#     elsif params.key?(:test)
#       A.build_test(&bloc)
#     end
#   end
# end

grab(:intuition).box({ id: :toolbox, top: :auto, bottom: 0, left: 0, width: 50, height: 255 })

module Intuition
  def intuition_int8
    # tool taxonomy and list
    {
      capture: { int8: { french: :enregistrement, english: :record, german: :datensatz } },
      communication: { french: :communication, english: :communication, german: :communication },
      tool: { french: :outils, english: :tools, german: :werkzeuge },
      view: { french: :vue, english: :view, german: :aussicht },
      time: { french: :horloge, english: :clock, german: :Uhr },
      find: { french: :trouve, english: :find, german: :finden },
      home: { french: :accueil, english: :home, german: :zuhause },
      code: { french: :code, english: :code, german: :code },
      impulse: { french: :impulse, english: :impulse, german: :impulse },
    }
  end

  def intuition_taxonomy

  end

  def impulse
    # tool start point
    [:capture, :communication, :tool, :view, :time, :find, :home]
  end

  # def capture
  #   categories=ATOME.methods_categories
  #   [categories[:inputs]]
  # end
  #
  # def communication
  #   categories=ATOME.methods_categories
  #   [categories[:communications]]
  # end
  #
  # def toolz
  #   categories=ATOME.methods_categories
  #   [categories[:spatials],categories[:helpers],categories[:materials],
  #    categories[:geometries],categories[:effects],
  #    categories[:medias],categories[:hierarchies],categories[:utilities],categories[:events]]
  # end
  #
  # def tool_style(size = 33)
  #   # styling
  #   shadows = [{ x: size / 15, y: size / 15, thickness: 0, blur: size / 3, color: { red: 0, green: 0, blue: 0, alpha: 0.3 } }, { x: -size / 15, y: -size / 15, thickness: 0, blur: size / 6, color: { red: 1, green: 1, blue: 1, alpha: 0.3 } }]
  #   style = { type: :tool, content: { points: 4 }, color: { red: 0.9, green: 0.9, blue: 0.9, alpha: 0.15 }, parent: :intuition, shadow: shadows, blur: { value: 6, invert: true } }
  #   return style
  # end
  #
  # def open_tool(tool_id, widthness=3, orientation=:x, speed=0.6)
  #   if orientation == :x
  #     orientation = :width
  #     value = grab(tool_id).width
  #   else
  #     orientation = :height
  #     value = grab(tool_id).height
  #   end
  #   animate({
  #             start: { orientation => value },
  #             end: { orientation => value * widthness },
  #             duration: speed * 1000,
  #             loop: 0,
  #             curve: :easing,
  #             target: tool_id
  #           })
  #   notification "find why this id #{self.atome_id}, add annimation callback to set overflow when anim complete"
  #   grab(tool_id).overflow(:visible)
  # end
  #
  # def close_tool(tool_id, widthness, orientation, speed)
  #   if orientation == :x
  #     orientation = :width
  #     value = grab(tool_id).width
  #   else
  #     orientation = :height
  #     value = grab(tool_id).height
  #   end
  #   animate({
  #             start: { orientation => value * widthness },
  #             end: { orientation => value },
  #             duration: speed * 1000,
  #             loop: 0,
  #             curve: :easing,
  #             target: tool_id
  #           })
  #   # grab(tool_id).overflow(:hidden)
  # end
  #
  # def create_tool(tool_name, size = 33, x_pos = 0, y_pos = 33, offsset=0)
  #   tool_created = tool(self.tool_style(size).merge({ parent: :main_menu, atome_id: "tool_" + tool_name, id: "tool_" + tool_name,
  #                                                     width: size, height: size, smooth: size / 9, overflow: :hidden, x: x_pos, y: y_pos, z: 1, content: [] }))
  #   icon=tool_created.shape({ path: tool_name, width: size - size / 2, height: size - size / 2, center: true })
  #   # name = intuition_list[tool_name][language]
  #   particle({ atome_id: :tools_property_container, color: { red: 0.6, green: 0.6, blue: 0.6 } })
  #   # we get the plugin code only if the plugin hasn't been interpreted before (unless condition below)
  #   unless grab(:intuition).content.include? tool_name
  #     ATOME.reader("./medias/e_rubies/tools/#{tool_name}.rb") do |data|
  #       #  todo add a security parser here
  #       # we set the variable tool that can be used to facilitate plugin creation
  #       data="tool=grab(:#{tool_created.atome_id})\n"+data
  #       compile(data)
  #       # we add the tool to the intuition content so it won't be loaded twice
  #       grab(:intuition).content |= [tool_name]
  #     end
  #   end
  #   # end
  #   tool_created.active({ exec: false })
  #   tool_created.inactive({ exec: false })
  #   icon.touch(stop: true) do
  #     if tool_created.active[:exec] == true
  #       tool_created.color(:transparent)
  #       tool_created.active(exec: false, proc: tool_created.active[:proc]  )
  #       tool_created.inactive(exec: true, proc: tool_created.inactive[:proc]  )
  #     else
  #       tool_created.color({alpha: 0.3})
  #       tool_created.active({ exec: true, proc: tool_created.active[:proc]  })
  #     end
  #   end
  # end
  #
  # # we get menu entry point
  # def open_intuition(position = {})
  #   position = { x: 0, yy: 0, size: 33, orientation: :vertical, offset: 0 }.merge(position)
  #   # we get content language from view's language
  #   if grab(:main_menu)
  #     grab(:main_menu).delete
  #   else
  #     grab(:view).language
  #     self.language(grab(:view).language)
  #     orientation = position.delete(:orientation)
  #     size = position.delete(:size)
  #     offset = position.delete(:offset)
  #     # positioning and scaling
  #     if orientation == :vertical
  #       requested_width = size
  #       requested_height = (size+offset)* impulse.length
  #     else
  #       requested_width = (size+offset) * impulse.length
  #       requested_height = size
  #     end
  #     tool({ atome_id: :main_menu, parent: :intuition, color: { alpha: 0 } }.merge(position).merge(width: requested_width, height: requested_height))
  #     impulse.each_with_index do |item, index|
  #       if orientation == :vertical
  #         create_tool(item, size, 0, index * (size+offset))
  #       else
  #         create_tool(item, size, index * (size+offset), 0)
  #       end
  #     end
  #   end
  # end
end
# atome class extension for eVe

class Atome
  include Intuition
  #  def atome(requested_property)
  #    # add component list iin the content we maybe ahave to create a tool object because box can't handle this type of content
  #    new_atome=self.tool({ atome_id: "#{self.atome_id}_#{requested_property}_atome_#{self.content.length}", x: 66})
  #    new_atome.touch({ stop: true, option: :down}) do
  #      color(:red)
  #      new_atome.height = new_atome.height*3
  #    end
  #    new_atome.touch({ stop: true, option: :up}) do
  #      color(:red)
  #      new_atome.height = new_atome.height/3
  #    end
  #    notification "now we have to add an object or a new property (style) to store complete tool style including size and
  # orientation so we can position the new atome correctly"
  #    # alert self.content.class
  #    # alert self.content.length
  #    # alert tool_style
  #  end
end

# # we initialise the toolbox here :
#
# # the launch bar
# launch_bar = box({ x: 0, y: 0, width: 33, height: "100%", parent: :intuition, z: 0, color: { alpha: 0 } })
# launch_bar.touch({ option: :long }) do |evt|
#   size = 33
#   yy_touch_position = grab(:view).convert(:height) - evt.page_y
#   if yy_touch_position < size
#     #if the long touch is within the wanted area( in this  at bottom of the screen) we open the menu
#     # launch_bar.open_intuition({ x: size, yy: 6,offset: 6, orientation: :horizontal, size: size })
#     launch_bar.open_intuition({ x: 6, yy: size,offset: 6, orientation: :vertical, size: size })
#   end
# end
#
# # # # # # # # # # # # # # # tests below   # # # # # # # # # # # # #
#
# list = molecule_analysis(@molecules_list)
# notif list[:tools]
# notif "======"
# notif list[:molecules]
# notif "======"
# notif list[:atomes]
# notif "======"
# notif list[:molecules][:shadow]

# grab(:intuition).data[:color]= :orange
new({ tool: :color }) do |params|
  @new_created_items ||= []
  active_code = lambda { |event|
    grab(:intuition).data[:color] = :red
    # left_found = event[:pageX].to_i
    # top_found = event[:pageY].to_i
    # new_box = box({ left: left_found, top: top_found, width: 66, height: 66, drag: true })
    # @new_created_items << new_box
    # new_box.resize(true) do |event|
    #   puts "width is  is #{event[:rect][:width]}"
    # end
  }

  inactive_code = lambda { |param|
    # @new_created_items.each do |new_atome_found|
    #   new_atome_found.drag(false)
    #   new_atome_found.resize(:remove)
    # end

  }
  {
    icon: :shape, action: { open: [:sub_menu] }, active: [active_code],
    inactive: [inactive_code],
    position: { root: 1 }, # position can be multiple
    option: { opt1: :method_2 },
    int8: { french: :couleur, english: :color, german: :colorad } }

end

new({ tool: :shape }) do |params|
  @new_created_items ||= []
  shape_code = lambda { |event|
    left_found = event[:pageX].to_i
    top_found = event[:pageY].to_i
    new_box = box({ left: left_found, top: top_found, width: 66, height: 66, drag: true })
    @new_created_items << new_box
    new_box.resize(true) do |event|
      puts "width is  is #{event[:rect][:width]}"
    end
  }

  inactive_code = lambda { |param|
    @new_created_items.each do |new_atome_found|
      new_atome_found.drag(false)
      new_atome_found.resize(:remove)
    end

  }
  {
    name: :shape, icon: :shape, action: { open: [:sub_menu] }, active: [shape_code],
    inactive: [inactive_code],
    position: { root: 1 }, # position can be multiple
    option: { opt1: :method_2 }, int8: { french: :formes, english: :shape, german: :jesaispas } }

end

puts A.impulse
# def fill_toolzone(tools_ids)
#
# end

# fill_toolzone(%i[files edition select group link copy undo settings])

##########################################
# new({template: :my_template}) do
#   # aid must be consistent
#
# end
#
# new({code: :my_code}) do
#
# end
#
# new({tool: :my_tool}) do
#
# end

# new({test: :my_test}) do
#
# end

# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
#                      <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="1024" height="1024"  xml:space="preserve" id="colorCanvas">
# <!-- Generated by PaintCode - http://www.paintcodeapp.com -->
#                                                           <circle id="colorCanvas-oval" stroke="none" fill="rgb(255, 0, 0)" cx="274" cy="306" r="198" />
# <circle id="colorCanvas-oval2" stroke="none" fill="rgb(0, 142, 255)" cx="767" cy="306" r="198" />
# <circle id="colorCanvas-oval3" stroke="none" fill="rgb(50, 255, 0)" cx="499" cy="702" r="198" />
# </svg>




# edition = "M257.7 752c2 0 4-0.2 6-0.5L431.9 722c2-0.4 3.9-1.3 5.3-2.8l423.9-423.9c3.9-3.9 3.9-10.2 0-14.1L694.9 114.9c-1.9-1.9-4.4-2.9-7.1-2.9s-5.2 1-7.1 2.9L256.8 538.8c-1.5 1.5-2.4 3.3-2.8 5.3l-29.5 168.2c-1.9 11.1 1.5 21.9 9.4 29.8 6.6 6.4 14.9 9.9 23.8 9.9z m67.4-174.4L687.8 215l73.3 73.3-362.7 362.6-88.9 15.7 15.6-89zM880 836H144c-17.7 0-32 14.3-32 32v36c0 4.4 3.6 8 8 8h784c4.4 0 8-3.6 8-8v-36c0-17.7-14.3-32-32-32z"

# v = vector({ data: { circle: { cx: 300, cy: 300, r: 340, id: :p2, stroke: :blue, 'stroke-width' => 35, fill: :yellow } } })
#
# # wait 2 do
# #   v.data({})
#   # alert v.data
#   # v.data(circle: { cx: 1000, cy: 1000, r: 340, id: :p2, stroke: :green, 'stroke-width' => 35, fill: :yellow })
#   wait 1 do
#     # <circle id="colorCanvas-oval" stroke="none" fill="rgb(255, 0, 0)" cx="274" cy="306" r="198" />
#     # <circle id="colorCanvas-oval2" stroke="none" fill="rgb(0, 142, 255)" cx="767" cy="306" r="198" />
#     # <circle id="colorCanvas-oval3" stroke="none" fill="rgb(50, 255, 0)" cx="499" cy="702" r="198" />
#     v.data([{ circle: { cx: 274, cy: 306, r: 198, id: :p2, stroke: :none, 'stroke-width' => 0, fill: "rgb(255, 0, 0)" } },
#             { circle: { cx: 767, cy: 306, r: 198, id: :p2, stroke: :none, 'stroke-width' => 0, fill: "rgb(0, 142, 255)" } },
#             { circle: { cx: 499, cy: 702, r: 198, id: :p2, stroke: :none, 'stroke-width' => 0, fill: "rgb(50, 255, 0)" } }])
#   # end
# end

image({path: 'medias/images/icons/color.svg', width: 33})

# p=[]
#  Universe.particle_list.each do |k,v|
#    p << k
#  end
#
# alert p
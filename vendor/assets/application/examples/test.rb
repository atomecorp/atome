# frozen_string_literal: true

# grab(:intuition).box({id: :toolbox, left: 33, top: 333})
# toolbox_style contain all tools styles
size = 33
smooth = 3
shadow({
         id: :tool_shade,
         left: 3, top: 3, blur: 3,
         invert: false,
         red: 0, green: 0, blue: 0, alpha: 0.6
       })

color({ id: :tool_inactive_color, red: 1, green: 1, blue: 1, alpha: 0.12 })
color({ id: :tool_active_color, red: 1, green: 1, blue: 1, alpha: 0.3 })
border({ id: :tool_box_border, thickness: 1, red: 1, green: 1, blue: 1, alpha: 0.06, pattern: :solid, inside: true })
# Tool's style object container below
element({ aid: :toolbox_style, id: :toolbox_style, data: {
  color: :gray,
  size: size,
  smooth: smooth
} })

class Atome

  class << self
    def selection
      grab(Universe.current_user).selection.collect
    end
  end

  def build_tool(params, &bloc)
    orientation_wanted = :sn
    index = 0
    tool_box_style = grab(:toolbox_style).data
    tool_size = tool_box_style[:size]
    tool_name = params[:tool]
    color({ id: :creation_layer_col, alpha: 0 })
    color({ id: :active_tool_col, alpha: 1, red: 1, green: 1, blue: 1 })
    color({ id: :inactive_tool_col, alpha: 0.6 })
    tool_content = Atome.instance_exec(&bloc) if bloc.is_a?(Proc)

    grab(:intuition).storage[:tool_open] ||= []
    grab(:intuition).storage[:tool_open] << tool_name
    size = grab(:toolbox_style).data[:size]
    smooth = grab(:toolbox_style).data[:smooth]
    case orientation_wanted
    when :sn
      top = :auto
      bottom = index * (size + 3)
      left = 0
      right = :auto
    when :ns
    when :ew
    when :we
    else
      #
    end

    # tool creation
    tool = grab(:intuition).box({ id: tool_name,
                                  tag: { system: true },
                                  # orientation: orientation_wanted,
                                  top: top,
                                  bottom: bottom,
                                  left: left,
                                  right: right,
                                  width: size,
                                  height: size,
                                  smooth: smooth,
                                  apply: [:tool_inactive_color, :tool_box_border, :tool_shade],
                                  state: :closed,
                                  storage: { taxonomy: Intuition.impulse },
                                })
    tool.vector({ tag: { system: true }, left: 9, top: :auto, bottom: 9, width: 18, height: 18, id: "tool_#{tool_name}_icon" })
    tool.text({ tag: { system: true }, data: tool_name, component: { size: 9 }, color: :grey, id: "tool_#{tool_name}_label" })
    tool.touch(true) do |ev|
      # we create the creation_layer if not already exist
      unless grab(:creation_layer)
        grab(:view).box({ id: :creation_layer, tag: { system: true }, depth: 3000, top: 0, left: 0, aid: :creation_layer, width: '100%', height: '100%', apply: :creation_layer_col })
      end
      tick(tool_name)
      # active code exec
      if tick[tool_name] == 1 # first click
        tool.data = []
        # generic behavior
        tool.apply(:active_tool_col)
        # activation code
        tool_content[:active].each do |code_exec|
          tool.instance_exec(&code_exec)
        end if tool_content && tool_content[:active]
        # creation layer creation
        if tool_content && tool_content[:creation]
          atome_scaffold = tool_content[:creation]

          grab(:creation_layer).touch(:down) do |event|
            atome_scaffold.each do |creation_params|
              puts "sync now + #{creation_params}"
              # pre code
              pre_proc = creation_params[:pre]
              tool.instance_exec(event, &pre_proc) if pre_proc.is_a? Proc
              new_atome = send(creation_params[:type], creation_params[:particles])
              new_atome.drag(true)
              new_atome.resize(true)
              new_atome.selected(true)
              new_atome.left(event[:pageX].to_i)
              new_atome.top(event[:pageY].to_i)
              tool.data << new_atome
              # post code
              post_proc = creation_params[:post]
              tool.instance_exec(new_atome, event, &post_proc) if post_proc.is_a? Proc
            end
          end
        end
        # alteration code
        if tool_content && tool_content[:alteration]
          tool_content[:alteration].each do |action|
            Atome.selection.each do |atome_to_treat|
              pre_proc = action[:pre]
              tool.instance_exec(atome_to_treat, &pre_proc) if pre_proc.is_a? Proc
              grab(atome_to_treat).send(action[:particle], action[:value])
              post_proc = action[:post]
              tool.instance_exec(atome_to_treat, &post_proc) if post_proc.is_a? Proc
            end
          end
        end

      else
        # inactivation code
        tool_content[:inactive].each do |code_exec|
          tool.instance_exec(tool.data, &code_exec)
        end if tool_content && tool_content[:inactive]

        # generic behavior
        tool.apply(:inactive_tool_col)
        # creation layer deletion
        creation_layer = grab(:creation_layer)
        if grab(:creation_layer)
          creation_layer.delete(true)
          creation_layer.touch({ remove: :down })
          tool.data.each do |new_atome|
            new_atome.drag(false)
            new_atome.resize(:remove)
          end
        end
        tick[tool_name] = 0
      end
    end
  end
end

module Intuition
  class << self
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

    def impulse
      # tool start point
      [:capture_tool, :communication, :tool, :view, :time, :find, :home]
    end
  end

end

##########################################################
# new({ tool: :impulse }) do |params|
#
#   creation_code = lambda { |event|
#     puts :box_creation
#   }
#
#   active_code = lambda { |event|
#     puts :start
#     apply([:tool_active_color])
#     storage[:taxonomy].each_with_index do |tool, index|
#
#       # Atome.display_tool("tool_#{tool}", index + 1, :ns)
#     end
#     state(:open)
#   }
#
#   inactive_code = lambda { |param|
#     puts :stop
#     # impulse.storage[:taxonomy].each do |tool|
#     #   grab("tool_#{tool}").delete(true)
#     # end
#     # impulse.apply([:tool_inactive_color])
#     # impulse.state(:closed)
#   }
#
#   {
#     active: [active_code],
#     inactive: [inactive_code],
#     creation: [creation_code],
#     int8: { french: :impulse, english: :impulse, german: :impulse }
#   }
# end

# toolbox creation
# Atome.display_tool(:impulse, 0, :ns)
# grab(:impulse).touch(true) do
#   impulse = grab(:impulse)
#   if impulse.state == :closed
#     impulse.apply([:tool_active_color])
#     impulse.storage[:taxonomy].each_with_index do |tool, index|
#
#       Atome.display_tool("tool_#{tool}", index + 1, :ns)
#     end
#     impulse.state(:open)
#   else
#     impulse.storage[:taxonomy].each do |tool|
#       grab("tool_#{tool}").delete(true)
#     end
#     impulse.apply([:tool_inactive_color])
#     impulse.state(:closed)
#   end
# end

# ##############################################################################################
# new({ tool: :color }) do |params|
#   active_code = lambda { |event|
#     grab(:intuition).data[:color] = :red
#
#   }
#
#   inactive_code = lambda { |param|
#
#   }
#   {
#     icon: :shape, action: { open: [:sub_menu] }, active: [active_code],
#     inactive: [inactive_code],
#     option: { opt1: :method_2 },
#     int8: { french: :couleur, english: :color, german: :colorad }
#   }
#
# end
#
new({ tool: :shape }) do |params|

  active_code = lambda {

    puts "activation code here"
    # atomes_treated.each do |new_atome|
    #   if new_atome.selected
    #     new_atome.left(new_atome.left + 33)
    #     new_atome.color({ red: rand, green: rand, blue: rand })
    #   end
    # end
  }

  inactive_code = lambda { |atomes_treated|
    atomes_treated.each do |new_atome|
      if new_atome.selected
        new_atome.left(new_atome.left + 33)
        new_atome.color({ red: rand, green: rand, blue: rand })
      end
    end
  }
  pre_crea_code = lambda { |event|
    Atome.selection.each do |atome_to_treat|
      grab(atome_to_treat).color(:red)
      grab(atome_to_treat).rotate(21)
      puts "pre"
    end

  }

  post_crea_code = lambda { |new_atome, _event|
    new_atome.color(:blue)
    puts "post"

  }

  creation_code = [{ type: :box, particles: { width: 66, height: 66 }, pre: pre_crea_code },
                   { type: :circle, particles: { width: 66, height: 66 }, post: post_crea_code }
  ]
  pre_code = lambda { |new_atome|
    # alert grab(new_atome).height
    grab(new_atome).height(99)
  }

  post_code = lambda { |new_atome|
    # alert grab(new_atome).height
    grab(new_atome).width(99)
  }

  alterations = [{ particle: :blur, value: 3, pre: pre_code, post: post_code }]

  { name: :shape, creation: creation_code, alteration: alterations,
    # pre: [pre_code], post: [post_code],
    active: [active_code],
    inactive: [inactive_code],
    int8: { french: :formes, english: :shape, german: :jesaispas } }

end
# ##############################################################################################
#

box({ left: 123, top: 66, selected: true })
circle({ left: 123, top: 120, selected: true })

# def id_found_under_touch(obj_found)
#   alert obj_found
# end
# aa=<<STR
# document.addEventListener('click', function(event) {
#     var x = event.clientX;
#     var y = event.clientY;
#     var elementUnderCursor = document.elementFromPoint(x, y).id;
# Opal.Object.$id_found_under_touch(elementUnderCursor);
# });
# STR
#
#  JS.eval(aa)

# ###################### marche
class Atome

  def set_action_on_touch(&action)
    @touch_action = action

  end

  def set_atome_on_touch
    document = JS.global[:document]
    document.addEventListener("click") do |native_event|
      event = Native(native_event)
      x = event[:clientX]
      y = event[:clientY]
      element = document.elementFromPoint(x, y)
      element_id = element[:id]
      puts "test if element is a system element elese select it "
      @touch_action.call(element_id) if @touch_action.is_a? Proc
    end
  end

  # def set_atome_on_touch
  #   document = JS.global[:document]
  #   document.addEventListener("click") do |native_event|
  #     event = Native(native_event)
  #     x = event[:clientX]
  #     y = event[:clientY]
  #     element = document.elementFromPoint(x, y)
  #
  #     # Boucle pour remonter la hiérarchie des éléments
  #     while element && element != document
  #       # Vérifie si l'élément a l'ID 'view'
  #       if element[:id].to_s == 'view'
  #         element_id = element[:id]
  #               @touch_action.call(element_id) if @touch_action.is_a? Proc
  #
  #         # alert "Clic sur un descendant de 'view'"
  #         break
  #       end
  #       # Passe au parent de l'élément actuel
  #       # element = element.JS[:parentNode]
  #       break
  #     end
  #   end
  # end

  def remove_get_atome_on_touch
    @touch_action = nil
  end

end

###### verif
# A.set_action_on_touch do |at_id|
#   puts "==> #{at_id}"
# end
# A.set_atome_on_touch
#
#
# wait 2 do
#   A.remove_get_atome_on_touch
#   wait 3 do
#     puts 'ready again !!'
#     A.set_action_on_touch do |at_id|
#       puts "******> #{at_id}"
#     end
#   end
# end

###### good algo
class Atome
  class << self

    def activate_click_analysis
      @click_analysis = lambda { |native_event|
        event = Native(native_event)

        x = event[:clientX]
        y = event[:clientY]
        elements = JS.global[:document].elementsFromPoint(x, y)
        # puts elements
        elements.to_a.each do |element|
          id_found = element[:id].to_s
          if grab(id_found) && grab(id_found).tag[:system]
          else
            if grab(id_found)
              Atome.instance_exec(id_found, &@click_analysis_action) if @click_analysis_action.is_a?(Proc)
            end
            break
          end
        end
      }
    end

    def de_activate_click_analysis
      @click_analysis = nil
    end

    def click_analysis
      JS.global[:document].addEventListener('mousedown') do |native_event|
        Atome.instance_exec(native_event, &@click_analysis) if @click_analysis.is_a?(Proc)
      end
    end
  end

end

check_me_first = lambda { |atome_id_found|
  alert "first user atome ==> #{grab(atome_id_found).id}"
}
Atome.instance_variable_set('@click_analysis_action', check_me_first)
# alert grab(:intuition).instance_variable_get('@click_analysis_action')
Atome.click_analysis
Atome.activate_click_analysis

wait 3 do
  check_me = lambda { |atome_id_found|
    alert "Cool cool cool, for :#{atome_id_found}"
  }
  Atome.instance_variable_set('@click_analysis_action', check_me)
  wait 2 do
    Atome.de_activate_click_analysis
    alert :game_over
  end
end


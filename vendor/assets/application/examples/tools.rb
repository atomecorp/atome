# frozen_string_literal: true

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
  @tools_actions_to_exec = {}

  class << self

    def init_intuition
      Atome.start_click_analysis
      Universe.tools.each_with_index do |(tool_name, bloc), index|
        # puts "add position and orientation"
        A.build_tool({ name: tool_name, index: index }, &bloc)
      end
    end

    def selection
      grab(Universe.current_user).selection.collect
    end

    def add_tool_actions(tool_name, tool_content)
      @tools_actions_to_exec[tool_name] = tool_content
    end

    def tool_actions_to_exec
      @tools_actions_to_exec
    end

    def activate_click_analysis

      # the condition below avoid touchdown analysis accumulation
      unless @click_analysis_active
        # this method analyse all object under the touchdown to find the first user objet and return it's id

        @click_analysis = lambda { |native_event|
          # the instance variable below check if we can apply tool (cf:  if the atome we don't want to apply tool)
          if Universe.allow_tool_operations
            event = Native(native_event)
            x = event[:clientX]
            y = event[:clientY]
            elements = JS.global[:document].elementsFromPoint(x, y)
            elements.to_a.each do |element|
              id_found = element[:id].to_s
              atome_touched = grab(id_found)
              if grab(id_found) && grab(id_found).tag[:system]
              else
                @creations_f = []
                @alterations_f = []
                current_tool = ''
                @tools_actions_to_exec.each do |tool_name, actions|
                  current_tool = grab(tool_name)
                  @creations_f = @creations_f.concat(actions[:creation]) if actions[:creation] # Concaténation
                  @alterations_f = @alterations_f.concat(actions[:alteration]) if actions[:alteration] # Concaténation
                end
                # Creation below
                @creations_f.each do |create_content|
                  code_before_applying = create_content[:pre]
                  code_after_applying = create_content[:post]
                  instance_exec(atome_touched,event,&code_before_applying) if code_before_applying.is_a? Proc
                  atome_type = create_content[:type]
                  particles = create_content[:particles]
                  new_atome = grab(:view).send(atome_type)
                  particles.each do |particle_found, value_found|
                    new_atome.send(particle_found, value_found)
                  end
                  new_atome.resize(true)
                  new_atome.drag(true)
                  new_atome.left(event[:pageX].to_i)
                  new_atome.top(event[:pageY].to_i)
                  current_tool.data << new_atome
                  instance_exec(atome_touched,new_atome,event,&code_after_applying) if code_after_applying.is_a? Proc

                  # now applying alterations on new atome if needed:
                  @alterations_f.each do |actions_f|
                    code_before_applying = actions_f[:pre]
                    code_after_applying = actions_f[:post]
                    instance_exec(new_atome,event,&code_before_applying) if code_before_applying.is_a? Proc
                    action = actions_f[:particle]
                    value = actions_f[:value]
                    new_atome.send(action, value)
                    instance_exec(new_atome,event,&code_after_applying) if code_after_applying.is_a? Proc
                  end

                end
                if atome_touched
                  @alterations_f.each do |actions_f|
                    code_before_applying = actions_f[:pre]
                    code_after_applying = actions_f[:post]
                    instance_exec(atome_touched,event,&code_before_applying) if code_before_applying.is_a? Proc
                    action = actions_f[:particle]
                    value = actions_f[:value]
                    atome_touched.send(action, value)
                    instance_exec(atome_touched,event,&code_after_applying) if code_after_applying.is_a? Proc
                  end
                end
                break
              end
            end
          else
            Universe.allow_tool_operations=true
          end

        }
        @click_analysis_active = true
      end

    end

    def de_activate_click_analysis
      # alert 'we need to find how many  tools are still active'
      @click_analysis = nil
      @click_analysis_active = false
    end

    def start_click_analysis
      @click_analysis_active = false
      JS.global[:document].addEventListener('mouseup') do |native_event|
        Atome.instance_exec(native_event, &@click_analysis) if @click_analysis.is_a?(Proc)
      end
    end

  end

  def set_action_on_touch(&action)
    @touch_action = action

  end

  def remove_get_atome_on_touch
    @touch_action = nil
  end

  def build_tool(params, &bloc)
    label = params[:name]
    name = "#{params[:name]}_tool"
    index = params[:index]
    orientation = params[:orientation]
    orientation_wanted = :sn
    color({ id: :active_tool_col, alpha: 1, red: 1, green: 1, blue: 1 })
    color({ id: :inactive_tool_col, alpha: 0.6 })
    tool_content = Atome.instance_exec(&bloc) if bloc.is_a?(Proc)
    grab(:intuition).storage[:tool_open] ||= []
    grab(:intuition).storage[:tool_open] << name
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
    tool = grab(:intuition).box({ id: name,
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
                                  # storage: { taxonomy: Intuition.impulse },
                                })
    tool.vector({ tag: { system: true }, left: 9, top: :auto, bottom: 9, width: 18, height: 18, id: "#{name}_icon" })
    tool.text({ tag: { system: true }, data: label, component: { size: 9 }, color: :grey, id: "#{name}_label" })
    tool.touch(true) do |ev|
      # we add all specific tool actions to @tools_actions_to_exec hash

      Atome.add_tool_actions(name, tool_content)
      # we set allow_tool_operations to false to ignore tool operation when clicking on a tool
      Universe.allow_tool_operations=false
      # we create the creation_layer if not already exist

      tick(name)
      # active code exec
      if tick[name] == 1 # first click
        # we set edit mode to true (this allow to prevent user atome to respond from click)
        Universe.edit_mode = true
        # activate tool analysis test
        Atome.activate_click_analysis
        # init the tool
        tool.data = []
        # generic behavior
        tool.apply(:active_tool_col)
        # activation code
        tool_content[:active].each do |code_exec|
          tool.instance_exec(&code_exec)
        end if tool_content && tool_content[:active]
        if tool_content && tool_content[:alteration]
          # here we treat any selected items on tool activation
          tool_content[:alteration].each do |action|
            Atome.selection.each do |atome_id_to_treat|
              atome_to_treat=grab(atome_id_to_treat)
              pre_proc = action[:pre]
              tool.instance_exec(atome_to_treat,nil, &pre_proc) if pre_proc.is_a? Proc
              particle_f = action[:particle]
              value_f = action[:value]
              atome_to_treat.send(particle_f, value_f)
              post_proc = action[:post]
              tool.instance_exec(atome_to_treat,nil, &post_proc) if post_proc.is_a? Proc
            end
          end
        end

      else
        # when closing delete tools action from tool_actions_to_exec
        Atome.tool_actions_to_exec.delete(name)
        # we check if all tools are inactive if so we set edit_mode to false
        if Atome.tool_actions_to_exec.length == 0
          Atome.de_activate_click_analysis
          Universe.edit_mode = false
        end

        # inactivation code
        tool_content[:inactive].each do |code_exec|
          tool.instance_exec(tool.data, &code_exec)
        end if tool_content && tool_content[:inactive]

        # generic behavior
        # we remove touch and resize binding on newly created atomes
        tool.apply(:inactive_tool_col)
        tool.data.each do |new_atome|
          new_atome.drag(false)
          new_atome.resize(:remove)
        end
        tick[name] = 0
      end
    end
  end
end

module Intuition
  class << self
    @toolbox = { impulse: [:capture_tool, :communication_tool, :creation_tool, :view_tool, :time_tool, :find_tool, :home_tool],
                 capture_tool: [:microphone_tool, :camera_tool,]
    }

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

  end

end


# ##############################################################################################

new({ tool: :shape }) do |params|

  active_code = lambda {
    puts :creation_tool_code_activated
  }

  inactive_code = lambda { |atomes_treated|
    puts :creation_tool_code_inactivated

  }
  pre_crea_code = lambda { |atome_touched, event|
    puts "pre_creation_code : atome_touched : #{atome_touched} event : #{event} "

  }

  post_crea_code = lambda { |atome_touched, new_atome, event|
    puts "post_creation_code,atome_touched: #{atome_touched}, new_atome :#{new_atome}, event : #{event}"
  }

  creation_code = [{ type: :box, particles: { width: 66, height: 66 }, pre: pre_crea_code },
                   { type: :circle, particles: { width: 66, height: 66 }, post: post_crea_code }
  ]
  pre_code = lambda { |atome_touched, event|
    puts 'alteration pre treatment'
  }

  post_code = lambda { |atome_touched, event|

    atome_touched.height(199)
    puts 'alteration post treatment'

  }

  alterations = [{ particle: :blur, value: 3, pre: pre_code, post: post_code }]

  { creation: creation_code, alteration: alterations,
    active: [active_code],
    inactive: [inactive_code],
    int8: { french: :formes, english: :shape, german: :jesaispas } }

end

### tool2 test

new({ tool: :color }) do |params|


  active_code = lambda {
    puts :alteration_tool_code_activated
  }

  inactive_code = lambda { |param|
    puts :alteration_tool_code_inactivated
  }
  pre_code= lambda { |atome_touched, event|
    puts "post_creation_code,atome_touched: #{atome_touched}, event : #{event}"


  }
  post_code= lambda { |atome_touched, event|
    puts "post_creation_code,atome_touched: #{atome_touched}, event : #{event}"

  }
  alterations = [{ particle: :width, value: 22 }, { particle: :color, value: :red,  pre: pre_code,
                                                    post: post_code, }, { particle: :rotate, value: 33 }]
  {
    active: [active_code],
    inactive: [inactive_code],
    alteration: alterations,

    int8: { french: :couleur, english: :color, german: :colorad } }

end



  Atome.init_intuition




# ###################



b = box({ left: 123, top: 66, selected: false, id: :the_box })
b.touch(:down) do
  puts '"im touched"'
end
circle({ left: 123, top: 120, selected: true, id: :the_circle, drag: true })

bb = box()

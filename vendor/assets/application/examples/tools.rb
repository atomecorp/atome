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
  class << self
    def init_intuition
      Atome.start_click_analysis
      root = [:osc, :filter, :drag, :rotate, :select, :move]
      root.each_with_index do |root_tool, index|
        tools_scheme = Universe.tools[root_tool]
        A.build_tool({ name: root_tool, scheme: tools_scheme, index: index })
      end
      # Universe.tools.each_with_index do |(tool_name, bloc), index|
      #
      #   A.build_tool({ name: tool_name, index: index }, &bloc)
      # end
    end

    def selection
      grab(Universe.current_user).selection.collect
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
            elements.to_a.each do |atome_touched|
              id_found = atome_touched[:id].to_s
              atome_found = grab(id_found)
              unless atome_found && atome_found.tag[:system]

                # if atome_found
                Universe.active_tools.each do |tool|
                  apply_tool(tool, atome_found, event)
                end
                break
              end
            end
          else
            Universe.allow_tool_operations = true
          end
        }
        @click_analysis_active = true
      end

    end

    def de_activate_click_analysis
      @click_analysis = nil
      @click_analysis_active = false
    end

    def start_click_analysis
      @click_analysis_active = false
      JS.global[:document].addEventListener('mouseup') do |native_event|
        Atome.instance_exec(native_event, &@click_analysis) if @click_analysis.is_a?(Proc)
      end
    end

    def alteration(current_tool, tool_actions, atome_touched, a_event)
      if atome_touched
        storage_allowed= Universe.allow_localstorage
        action_found = tool_actions[:action]
        pre = tool_actions[:pre]
        post = tool_actions[:post]
        params = { current_tool: current_tool, atome_touched: atome_touched, event: a_event }
        action_found.each do |part, val|
          Universe.allow_localstorage = false
          current_tool.instance_exec(params, &pre) if pre.is_a? Proc
          Universe.allow_localstorage = storage_allowed
          if current_tool.data[:allow_alteration]
            atome_touched.send(part, val)
            current_tool.data[:treated] << atome_touched
          end
          current_tool.instance_exec(params, &post) if post.is_a? Proc
        end

      end
    end

    def creation(current_tool, tool_actions, atome_touched, a_event)

      # we store prev_local_storage prior to lock it to prevent unwanted logs
      # prev_local_storage=Universe.allow_localstorage()
      storage_allowed= Universe.allow_localstorage
      Universe.allow_localstorage = false

      action_found = tool_actions[:action]
      pre = tool_actions[:pre]
      post = tool_actions[:post]
      params = { current_tool: current_tool, atome_touched: atome_touched, event: a_event }

      action_found.each do |atome, particle|
        current_tool.instance_exec(params, &pre) if pre.is_a? Proc
        temp_val = particle.merge({ resize: true, drag: true, top: a_event[:pageY].to_i, left: a_event[:pageX].to_i })
        if current_tool.data[:allow_creation]
          # uncomment the line below if you want to attach to current atome
          if atome_touched
            new_atome = atome_touched.send(atome, temp_val)
          else
            new_atome = grab(:view).send(atome, temp_val)
          end
          # current_tool.data[:treated] << new_atome
          current_tool.data[:created] << new_atome
          params.delete(:atome_touched)
          params[new_atome: new_atome]
          Universe.allow_localstorage = [atome]
          Universe.historicize(new_atome.aid, :write, atome, particle)
        end

      end
      current_tool.instance_exec(params, &post) if post.is_a? Proc
      # we restore prev_local_storage to allow logs of drag and resize ...
      Universe.allow_localstorage = storage_allowed
    end

    def apply_tool(tool, atome_touched, a_event)
      current_tool = grab(tool)
      tool_actions = current_tool.data
      method_found = tool_actions[:method]


      send(method_found, current_tool, tool_actions, atome_touched, a_event)
    end

  end

  def set_action_on_touch(&action)
    @touch_action = action

  end

  def remove_get_atome_on_touch
    @touch_action = nil
  end

  def build_tool(params)
    label = params[:name]
    tool_name = "#{params[:name]}_tool"
    index = params[:index]
    orientation_wanted = :sn
    tool_scheme = params[:scheme]
    color({ id: :active_tool_col, alpha: 1, red: 1, green: 1, blue: 1 })
    color({ id: :inactive_tool_col, alpha: 0.6 })
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
    if tool_scheme[:creation]
      action = tool_scheme[:creation]
      method = :creation
    end
    if tool_scheme[:alteration]
      action = tool_scheme[:alteration]
      method = :alteration
    end
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
                                  data: { method: method,
                                          action: action,
                                          allow_alteration: true,
                                          allow_creation: true,
                                          # activation: tool_scheme[:activation],
                                          #  inactivation: tool_scheme[:inactivation], zone: tool_scheme[:zone],
                                          post: tool_scheme[:post],
                                          pre: tool_scheme[:pre],
                                  }

                                })
    tool.vector({ tag: { system: true }, left: 9, top: :auto, bottom: 9, width: 18, height: 18, id: "#{tool_name}_icon" })
    tool.text({ tag: { system: true }, data: label, component: { size: 9 }, color: :grey, id: "#{tool_name}_label" })
    code_for_zone = tool_scheme[:zone]
    tool.instance_exec(tool, &code_for_zone) if code_for_zone.is_a? Proc
    tool.touch(true) do

      # we add all specific tool actions to @tools_actions_to_exec hash
      # we set allow_tool_operations to false to ignore tool operation when clicking on a tool
      Universe.allow_tool_operations = false
      # we create the creation_layer if not already exist
      tick(tool_name)
      # active code exec
      if tick[tool_name] == 1 # first click
        events_allow = [:top, :left, :right, :bottom, :width, :height]
        alterations = tool_scheme[:alteration] ? tool_scheme[:alteration].keys : []
        creations = tool_scheme[:creation] ? tool_scheme[:creation].keys : []
        prev_auth = Universe.allow_localstorage ||= []
        storage_allowed = events_allow.concat(alterations).concat(creations).concat(prev_auth).uniq
        Universe.allow_localstorage = storage_allowed
        # we set edit mode to true (this allow to prevent user atome to respond from click)
        Universe.edit_mode = true
        Universe.active_tools << tool_name
        # init the tool
        tool.data[:treated] = []
        tool.data[:created] = []
        # generic behavior
        tool.apply(:active_tool_col)
        # activation code
        activation_code = tool_scheme[:activation]
        tool.instance_exec(&activation_code) if activation_code.is_a? Proc
        # below we the particles of selected atomes to feed tools values
        # possibility 1 (pipette like):
        # now we get the values from selected atomes
        Atome.selection.each do |atome_id_to_treat|
          tool.data[:action].each do |particle_req, value_f|
            unless Universe.atome_preset
              value_found = grab(atome_id_to_treat).send(particle_req)
              if value_found
                tool.data[:action][particle_req] = value_found
              else
              end
            end
          end
        end
        # possibility 2  (immediate apply):
        allow_creation = tool.data[:allow_creation]
        allow_alteration = tool.data[:allow_alteration]
        Atome.selection.each do |atome_id_to_treat|
          atome_found = grab(atome_id_to_treat)
          event = { pageX: 0, pageY: 0, clientX: 0, clientY: 0 }
          Atome.apply_tool(tool_name, atome_found, event)
        end unless tool_name.to_sym == :select_tool || !allow_creation || !allow_alteration

        # activate tool analysis test
        Atome.activate_click_analysis
      else
        Universe.allow_localstorage = false
        # when closing delete tools action from tool_actions_to_exec
        Universe.active_tools.delete(tool_name)
        # we check if all tools are inactive if so we set edit_mode to false
        if Universe.active_tools.length == 0
          Atome.de_activate_click_analysis
          Universe.edit_mode = false
        end

        # inactivation code
        inactivation_code = tool_scheme[:inactivation]
        tool.instance_exec(tool.data, &inactivation_code) if inactivation_code.is_a? Proc
        # end if tool_content && tool_content[:inactive]

        # generic behavior
        # we remove touch and resize binding on newly created atomes
        tool.apply(:inactive_tool_col)
        tool.data[:created].each do |new_atome|
          puts "find a strategy to re-activate the line below else drag accumulate"
          new_atome.drag(false)
          new_atome.resize(:remove)
        end

        tick[tool_name] = 0
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

new({ tool: :filter }) do |params|

  active_code = lambda {
    puts :alteration_tool_code_activated
  }

  inactive_code = lambda { |param|
    puts :alteration_tool_code_inactivated
  }
  pre_code = lambda { |params|
    puts "pre_creation_code,atome_touched: #{:params}"

  }
  post_code = lambda { |params|
    puts "post_creation_code,atome_touched: #{:params}"

  }

  zone_spe = lambda { |current_tool|
    puts "current tool is : #{:current_tool} now creating specific zone"
    # b = box({ width: 33, height: 12 })
    # b.text({ data: :all })

  }

  {
    activation: active_code,
    inactivation: inactive_code,
    alteration: { width: 22, blur: 3 },
    pre: pre_code,
    post: post_code,
    zone: zone_spe,
    int8: { french: :couleur, english: :color, german: :colorad } }

end

new({ tool: :osc }) do |params|

  active_code = lambda {
    puts :creation_tool_code_activated
  }

  inactive_code = lambda { |atomes_treated|
    puts :creation_tool_code_inactivated

  }
  pre_creation_code = lambda { |params|
    puts "pre_creation_code : atome_touched : #{:params} "

  }

  post_creation_code = lambda { |params|
    puts "post_creation_code,atome_touched: #{:params}"
  }

  { creation: { box: { color: :blue , width: 66, height: 66} },
    activation: active_code,
    inactivation: inactive_code,
    pre: pre_creation_code,
    post: post_creation_code,
    int8: { french: :formes, english: :shape, german: :jesaispas } }

end

new({ tool: :drag }) do |params|

  active_code = lambda {
    # Atome.selection.each do |atome_id_to_treat|
    #   # reinit first to avoid multiple drag event
    #   grab(atome_id_to_treat).drag(false)
    # end
    # drag_remove
    # puts :alteration_tool_code_activated
  }

  inactive_code = lambda { |param|
    # puts :alteration_tool_code_inactivated
  }
  pre_code = lambda { |params|
    atome_target = params[:atome_touched]
    atome_target.drag(false)
  }
  post_code = lambda { |params|
    # puts "post_creation_code,atome_touched: #{params}"

  }

  zone_spe = lambda { |current_tool|
    # puts "current tool is : #{current_tool} now creating specific zone"
    # b = box({ width: 33, height: 12 })
    # b.text({ data: :all })

  }

  {
    activation: active_code,
    inactivation: inactive_code,
    alteration: { drag: true },
    pre: pre_code,
    post: post_code,
    zone: zone_spe,
    int8: { french: :drag, english: :drag, german: :drag } }

end

new({ tool: :select }) do |params|
  pre_code = lambda { |param|
    atome_touched = param[:atome_touched]
    current_tool = param[:current_tool]
    if atome_touched.selected
      atome_touched.selected(false)
      current_tool.data[:allow_alteration] = false
    else
      # atome_touched.selected(true)
      current_tool.data[:allow_alteration] = true
    end
  }
  {
    pre: pre_code,
    alteration: { selected: true },
    int8: { french: :select, english: :select, german: :select }
  }
end

new({ tool: :rotate }) do
  { alteration: { height: 150, rotate: 45 } }
end

new({ tool: :move }) do
  inactivate=lambda{|param|
     param[:treated].each do |atome_f|
       atome_f.drag(false)
     end
  }
  { alteration: { drag: true, left: nil , top: nil}, inactivation: inactivate }
end
### tool2 test

Atome.init_intuition

# ###################

b = box({ left: 123, top: 66, selected: false, id: :the_box, color: :green })
b.touch(:down) do
  alert " on touch : #{Universe.allow_localstorage}"
end
the_circ = circle({ left: 123, top: 120, selected: false, id: :the_circle, drag: true })

the_circ.touch(:down) do
  puts the_circ.id
end
bb = box({ left: 333, width: 120, selected: false, id: :big_box })

b = box({ id: :the_big_boxy })
# text({ data: :hello, selected: true, left: 120, id: :texting, blur: 12 })
# text({data: :hello, left: 120, id: :texting})
# Universe.tools.each_with_index do |(tool_name, bloc), index|
#  Atome.instance_exec(&bloc) if bloc.is_a?(Proc)
#   # alert "#{tool_name} : #{tool_content}"
#   # alert b.id
# end

# wait 2 do
#   # c.preset( {:box=>{:width=>39, :height=>39, :apply=>[:box_color], :left=>0, :top=>0}} )
#   c.preset( :box )
# end
# b=box({left: 333, top: 333})
# b.touch(true) do
#   alert Atome.selection
# end
# grab(:the_texting).color(:white)
# grab(:the_texting).left(33)
# grab(:the_texting).top(133)
# grab(:the_texting).width(133)
# grab(:the_texting).top(133)
# grab(:the_texting).data(:kool)
# grab(:the_texting).type(:text)
# grab(:the_texting).rotate(:text)

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
      root = Universe.tools_root
      root.each_with_index do |root_tool, index|
        tools_scheme = Universe.tools[root_tool]
        A.build_tool({ name: root_tool, scheme: tools_scheme, index: index })
      end
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
        storage_allowed = Universe.allow_localstorage
        action_found = tool_actions[:action]
        pre = tool_actions[:pre]
        post = tool_actions[:post]
        params = { current_tool: current_tool, atome_touched: atome_touched, event: a_event }
        action_found.each do |part, val|
          Universe.allow_localstorage = false
          #################################
          touch_found = atome_touched.touch
          touch_procs=atome_touched.instance_variable_get("@touch_code")
          resize_found = atome_touched.resize
          resize_procs=atome_touched.instance_variable_get("@resize_code")
          current_tool.data[:prev_states][atome_touched] = {events: { touch: touch_found, resize: resize_found },
                                                            procs: {touch_code: touch_procs, resize_code: resize_procs } }
          #################################
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
      storage_allowed = Universe.allow_localstorage
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
      unless method_found
        method_found = :alteration
        tool_actions[:action] = { noop: true }
        current_tool.data = tool_actions
      end

      send(method_found, current_tool, tool_actions, atome_touched, a_event)
    end

  end

  def noop(_p)
    # this method is used by tools when no treatment is needed
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
        tool.data[:prev_states] = {}
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

        inactivation_code = tool_scheme[:inactivation]
        tool.instance_exec(tool.data, &inactivation_code) if inactivation_code.is_a? Proc
        # end if tool_content && tool_content[:inactive]

        # generic behavior
        # we remove touch and resize binding on newly created atomes
        tool.apply(:inactive_tool_col)
        tool.data[:created].each do |new_atome|
          new_atome.drag(false)
          new_atome.resize(:remove)
        end
        ################################
        # we restore prev touch and resize
        tool.data[:prev_states].each do |atome_f, prev_par|
          puts prev_par
          # params[:events].each do |part_f, val_f|
          #   # alert "@#{part_f}, #{part_f}"
          #   atome_f.send(part_f, val_f)
          # end
          # alert "--> params :  #{params[:events]}"
          # alert "--> procs :  #{params[:procs][params[:events]]}"
          # atome_f.touch(false)
          # atome_f.touch(true) do
          #   alert :kool
          # end
          # alert params[:procs]
          # params[:procs].each do |var_n, procs_f|
          #   # procs_f.each do |action_f, proc|
          #   #   # puts "#{var_n}==> #{action_f}, #{proc}"
          #   # end
          #   puts "==> #{var_n}, #{proc_f}"
          #   # atome_f.instance_variable_set("@#{var_n}", proc_f)
          # end
          # atome_f.touch(false)
          # alert "#{atome_f.touch} : #{atome_f.instance_variable_get("@touch_code")}"
        end

        # atome_f.touch(touch_found)
        # atome_f.resize(resize_found)
        # inactivation code
        #################################
        tick[tool_name] = 0
      end
    end
  end
end
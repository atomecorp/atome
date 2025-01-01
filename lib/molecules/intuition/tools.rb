# frozen_string_literal: true

size = 33
smooth = 3
margin = 3
text_color = { alpha: 0.3, red: 1, green: 1, blue: 1 }
shadow({
         id: :tool_shade,
         left: 3, top: 3, blur: 3,
         invert: false,
         red: 0, green: 0, blue: 0, alpha: 0.6
       })
color({ id: :active_tool_col, alpha: 1, red: 1, green: 1, blue: 1 })
color({ id: :inactive_tool_col, alpha: 0.1 })
border({ id: :tool_box_border, thickness: 1, red: 1, green: 1, blue: 1, alpha: 0.06, pattern: :solid, inside: true })
# Tool's style object container below
element({ aid: :toolbox_style, id: :toolbox_style, data: {
  color: :gray,
  size: size,
  margin: margin,
  smooth: smooth,
  text_color: text_color,
} })

class Atome

  def toolbox(tool_list)
    @toolbox = tool_list[:tools]
    tool_list[:tools].each_with_index do |root_tool, index|
      tools_scheme = Universe.tools[root_tool]
      build_tool({ name: root_tool, scheme: tools_scheme, index: index, toolbox: tool_list[:toolbox] })
    end
  end

  class << self
    def init_intuition
      Atome.start_click_analysis
      toolbox_root = Universe.tools_root
      toolbox_root[:tools].each_with_index do |root_tool, index|
        tools_scheme = Universe.tools[root_tool]
        A.build_tool({ name: root_tool, scheme: tools_scheme, index: index, toolbox: toolbox_root[:toolbox] })
      end
    end

    def selection
      grab(Universe.current_user).selection.collect
    end

    def activate_click_analysis
      # the condition below avoid touchdown analysis accumulation
      unless @click_analysis_active
        # this method analyse all object under the touchdown to find the first user object and return it's id
        @click_analysis = lambda { |native_event|
          # the instance variable below check if we can apply tool (cf:  if the atome we don't want to apply tool)
          if Universe.allow_tool_operations
            event = Native(native_event)
            x = event[:clientX]
            y = event[:clientY]
            elements = JS.global[:document].elementsFromPoint(x, y)
            elements.to_a.each do |atome_touched|
              id_found = atome_touched[:id]
              id_found = id_found.to_s.to_sym # keep .to_s to because ruby wasm try may to_sym on on symbol
              atome_found = grab(id_found)

              is_descendant_of_intuition = atome_found.descendant_of?(:intuition).to_s if atome_found
              # the condition below is use to exclude the treatment any object in the intuition layer
              unless is_descendant_of_intuition == 'true'

                Universe.active_tools.each do |tool|
                  apply_tool(tool, atome_found, event)
                end
              end
              break
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
      # here we capture any touch when using tool
      @click_analysis_active = false

      click_timeout = nil
      double_click_delay = 222

      JS.global[:document].addEventListener('click') do |native_event|
        if @click_analysis
          if click_timeout
            wait(:kill, click_timeout)
            click_timeout = nil
            selected_items = grab(Universe.current_user).selection.collect
            if  selected_items.length >  0
              dup_selected_items = selected_items.dup
              dup_selected_items.each do |atome_id_selected|
                atome_selected = grab(atome_id_selected)
                atome_selected.selected(false)
              end
            else
              atomes_in_view= grab(:view).fasten
              atomes_in_view.each do |atome_id_found|
                grab(atome_id_found).selected(true)
              end
              end


          else
            click_timeout = wait(double_click_delay / 1000.0) do
              click_timeout = nil # important do not remove !
              Atome.instance_exec(native_event, &@click_analysis) if @click_analysis.is_a?(Proc)
            end
          end
        end

      end

    end

    def alteration(current_tool, tool_actions, atome_touched, a_event)
      if atome_touched
        storage_allowed = Universe.allow_localstorage
        action_found = tool_actions[:action]
        post = tool_actions[:post]
        params = { current_tool: current_tool, atome_touched: atome_touched, event: a_event }
        action_found.each do |part, val|
          Universe.allow_localstorage = false
          Universe.allow_localstorage = storage_allowed
          if current_tool.data[:allow_alteration]
            if val.instance_of?(Proc)
              atome_touched.instance_exec(&val)
            else
              atome_touched.send(part, val)
            end
            current_tool.data[:treated] << atome_touched if current_tool.data[:treated]
          end
          current_tool.instance_exec(params, &post) if post.is_a? Proc
        end

      end
    end

    def creation(current_tool, tool_actions, atome_touched, a_event)
      @creation_mode = true
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
          new_atome = if atome_touched
                        atome_touched.send(atome, temp_val)
                      else
                        grab(:view).send(atome, temp_val)
                      end
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
      tool_name = tool.to_s.sub('_tool', '')
      tools_scheme = Universe.tools[tool_name.to_sym]

      target = if tools_scheme[:target]
                 grab(atome_touched.send(tools_scheme[:target]).last)
               else
                 atome_touched
               end
      if target && method_found == :alteration && target.tag[:system]
        # in this case (on target touch )we are targeting a system object non alterable so we create an a new atome
        # Ex: if we are on a system color we create a new color that can be altered
        tools_scheme[:particles]&.each do |particle_f, value_f|
          type_to_create = target.type
          if type_to_create
            target = atome_touched.send(type_to_create, { particle_f => value_f })
            tools_scheme[:particles]&.each do |particle_f, value_f|
              target.send(particle_f, value_f)
            end
          end
        end
      else

        # below code trigger when activating the current tool :
        tools_scheme[:particles]&.each do |particle_f, value_f|
          is_descendant_of_intuition = target.descendant_of?(:intuition).to_s
          atome_descendant_of_intuition = atome_touched.descendant_of?(:intuition).to_s
          # the condition below is use to exclude the treatment any object in the intuition layer
          unless is_descendant_of_intuition == 'true' || atome_descendant_of_intuition == 'true'
            target.send(particle_f, value_f)
          end
        end
        send(method_found, current_tool, tool_actions, target, a_event)
      end

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

  def activate_tool
    tool_name = id
    tool_scheme = @tool_scheme
    tool = self

    alterations = tool_scheme[:alteration] ? tool_scheme[:alteration].keys : []
    creations = tool_scheme[:creation] ? tool_scheme[:creation].keys : []
    prev_auth = Universe.allow_localstorage ||= []
    events_allow = %i[top left right bottom width height]
    storage_allowed = events_allow.concat(alterations).concat(creations).concat(prev_auth).uniq

    Universe.allow_localstorage = storage_allowed
    # we set edit mode to true (this allow to prevent user atome to respond from click)

    Universe.edit_mode = true
    # init the tool
    tool.data[:treated] = []
    tool.data[:created] = []
    tool.data[:prev_states] = {}
    # generic behavior
    grab("#{tool_name}_icon").color(:white)
    grab("#{tool_name}_label").color(:white)
    Universe.active_tools << tool_name
    # activation code
    activation_code = tool_scheme[:activation]
    tool.instance_exec(&activation_code) if activation_code.is_a? Proc
    # below we the particles of selected atomes to feed tools values
    # possibility 1 (pipette like):
    # now we get the values from selected atomes
    Atome.selection.each do |atome_id_to_treat|
      tool.data[:action]&.each_key do |particle_req|
        unless Universe.preset_list
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
    unless tool_name.to_sym == :select_tool || !allow_creation || !allow_alteration
      Atome.selection.each do |atome_id_to_treat|
        atome_found = grab(atome_id_to_treat)
        event = { pageX: 0, pageY: 0, clientX: 0, clientY: 0 }
        Atome.apply_tool(tool_name, atome_found, event)
      end
    end
    # activate tool analysis test
    Atome.activate_click_analysis
    tool.active(true)
  end

  def deactivate_tool
    tool_name = id
    tool_scheme = @tool_scheme
    tool = self
    tool.active(false)
    tool.instance_variable_get('@toolbox')&.each do |sub_tool_id|
      toolbox_tool = grab("#{sub_tool_id}_tool")
      toolbox_tool.deactivate_tool
      # we delete the fasten toolbox if it exist
      toolbox_tool.delete({ force: true })
    end
    grab("#{tool_name}_icon").color(grab(:toolbox_style).data[:text_color])
    grab("#{tool_name}_label").color(grab(:toolbox_style).data[:text_color])
    # when closing delete tools action from tool_actions_to_exec
    Universe.active_tools.delete(tool_name)
    # we check if all tools are inactive if so we set edit_mode to false
    if Universe.active_tools.length == 0
      Atome.de_activate_click_analysis
      Universe.edit_mode = false
      Universe.allow_localstorage = false
    end

    inactivation_code = tool_scheme[:inactivation]
    tool.instance_exec(tool.data, &inactivation_code) if inactivation_code.is_a? Proc
    # generic behavior
    # we remove touch and resize binding on newly created atomes
    tool.apply(:inactive_tool_col)
    tool.data[:created]&.each do |new_atome|
      new_atome.drag(false)
      new_atome.resize(:remove)
    end
  end

  def build_tool(params)
    # here is the main entry for tool creation
    language ||= grab(:view).language

    label = params.dig(:scheme, :int8, language) || params[:name]
    tool_name = "#{params[:name]}_tool"
    index = params[:index]
    tool_scheme = params[:scheme]
    toolbox = params[:toolbox] || {}
    orientation_wanted = tool_scheme[:orientation] || :sn

    grab(:intuition).storage[:tool_open] ||= []
    grab(:intuition).storage[:tool_open] << tool_name
    size = grab(:toolbox_style).data[:size]
    margin = grab(:toolbox_style).data[:margin]
    smooth = grab(:toolbox_style).data[:smooth]
    text_color = grab(:toolbox_style).data[:text_color]
    case orientation_wanted
    when :sn
      top = :auto
      bottom_offset = toolbox[:bottom] || 3
      spacing = toolbox[:spacing] || 3
      bottom = index * (size + spacing) + bottom_offset
      left = toolbox[:left] || 3
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
                                  depth: 0,
                                  left: left,
                                  right: right,
                                  width: size,
                                  height: size,
                                  smooth: smooth,
                                  apply: %i[inactive_tool_col tool_box_border tool_shade],
                                  state: :closed,
                                  data: { method: method,
                                          action: action,
                                          allow_alteration: true,
                                          allow_creation: true,
                                          post: tool_scheme[:post],
                                          pre: tool_scheme[:pre],
                                  }

                                })

    tool.instance_variable_set('@tool_scheme', tool_scheme)
    edition = 'M257.7 752c2 0 4-0.2 6-0.5L431.9 722c2-0.4 3.9-1.3 5.3-2.8l423.9-423.9c3.9-3.9 3.9-10.2 0-14.1L694.9 114.9c-1.9-1.9-4.4-2.9-7.1-2.9s-5.2 1-7.1 2.9L256.8 538.8c-1.5 1.5-2.4 3.3-2.8 5.3l-29.5 168.2c-1.9 11.1 1.5 21.9 9.4 29.8 6.6 6.4 14.9 9.9 23.8 9.9z m67.4-174.4L687.8 215l73.3 73.3-362.7 362.6-88.9 15.7 15.6-89zM880 836H144c-17.7 0-32 14.3-32 32v36c0 4.4 3.6 8 8 8h784c4.4 0 8-3.6 8-8v-36c0-17.7-14.3-32-32-32z'
    icon = tool.vector({ tag: { system: true }, left: 9, top: :auto, bottom: 9, width: 18, height: 18, id: "#{tool_name}_icon",
                         data: { path: { d: edition, id: "p1_#{tool_name}_icon", stroke: :black, 'stroke-width' => 37, fill: :white } } })

    icon.color(text_color)

    tool.text({ tag: { system: true }, data: truncate_string(label, 5), component: { size: 9 }, center: { x: 0 }, top: :auto, bottom: 0,
                color: text_color, id: "#{tool_name}_label", width: size, position: :absolute })

    code_for_zone = tool_scheme[:zone]
    tool.instance_exec(tool, &code_for_zone) if code_for_zone.is_a? Proc
    tool.active(false)
    tool.touch(:long) do
      tool.instance_variable_set('@prevent_action', true)
      if tool.instance_variable_get('@tool_open') == true
        tool.instance_variable_set('@tool_open', false)
        tool_scheme[:particles]&.each_key do |particle|
            grab("tool_particle_#{particle}").delete({ force: true })
          end
        tool.width(size)
      else
        tool.instance_variable_set('@tool_open', true)

        tool_scheme[:particles]&.each_with_index do |(particle_name, _value_), ind|
          particle = tool.box({ id: "tool_particle_#{particle_name}", tag: { system: true }, depth: 1, smooth: smooth,
                                apply: %i[inactive_tool_col tool_box_border tool_shade],
                                width: size, height: size, left: ind * (size + margin) + size })
          particle_label = particle.text({
                                           id: "tool_particle_name_#{particle_name}",
                                           tag: { system: true },
                                           data: truncate_string(particle_name, 5),
                                           center: { x: 0 },
                                           position: :absolute,
                                           component: { size: 9 },
                                           color: text_color,
                                           top: :auto,
                                         }

          )
          label_value = particle.text({
                                        id: "tool_particle_value_#{particle_name}",
                                        data: 0.00,
                                        tag: { system: true },
                                        center: { x: 0 },
                                        position: :absolute,
                                        component: { size: 9 },
                                        color: text_color,
                                        top: margin,

                                      })
          particle_label.center({ x: 0 })
          particle_label.top(:auto)
          particle_label.bottom(0)
          particle.touch(true) do
            tool.instance_variable_set('@prevent_action', true)
            slider_id = "particle_slider_#{particle_name}"
            if particle.instance_variable_get('@active')
              grab(slider_id).delete({ force: true })
              particle.instance_variable_set('@active', false)
              particle.height(size)
              particle.top(0)
            else
              particle.height(139 + size / 2)
              particle.top(-139 + size)
              slider_id = "particle_slider_#{particle_name}"
              slider_f = particle.slider({ orientation: :vertical,
                                           id: slider_id,
                                           range: { color: { alpha: 0 } },
                                           value: 55,
                                           depth: 2,
                                           center: { x: 0 },
                                           width: 18, height: 123, smooth: 1,
                                           left: 0,
                                           top: size / 2,
                                           color: { alpha: 0 },
                                           cursor:
                                             { color: { alpha: 1, red: 0.9, green: 0.9, blue: 0.0 },
                                               width: 18, height: 12, smooth: 3 } }) do |value|
                # Slider actions below:
                if grab(slider_id).instance_variable_get('@initialised')
                  Atome.selection.each do |atome_id_to_treat|


                    tool_scheme[:particles][particle_name] = value.to_f / 100
                    atome_found = grab(atome_id_to_treat)
                    target = grab(atome_found.color.last)
                    target.send(particle_name, value.to_f / 100) if tool.active

                  end

                  label_value.data(value.to_f / 100)
                  tool_scheme[:particles][particle_name]=value.to_f / 100
                end
              end

              Atome.selection.each do |atome_id_to_treat|
                atome_found = grab(atome_id_to_treat)
                target = if tool_scheme[:target]
                           grab(atome_found.send(tool_scheme[:target]).last)
                         else
                           atome_found
                         end
                value_found = target.send(particle_name)
                slider_f.value(value_found * 100)
              end
              slider_f.instance_variable_set('@initialised', true)
              particle.instance_variable_set('@active', true)
            end

          end
        end
      end

    end
    tool.touch(:down) do
      tool.depth(999)
    end
    tool.touch(:double) do
      tool_to_deactivate = Universe.active_tools.dup
      tool_to_deactivate.each do |atome_id_found|
        atome_found = grab(atome_id_found)
        atome_found.deactivate_tool
      end
      tool.activate_tool
    end
    tool.touch(true) do
      unless tool.instance_variable_get('@prevent_action')
        # we add all specific tool actions to @tools_actions_to_exec hash
        # we set allow_tool_operations to false to ignore tool operation when clicking on a tool
        Universe.allow_tool_operations = false
        # we create the creation_layer if not already exist
        if tool.active == false # first click
          tool.activate_tool
        else
          tool.deactivate_tool
          tick[tool_name] = 0
        end
      end
      tool.instance_variable_set('@prevent_action', false)
    end
  end

end

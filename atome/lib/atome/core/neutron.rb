# here the methods to add conceptual properties to atome objects
module Nucleon
  module Core
    #this is a module for Atome gem dedicated to non audiovisual apis
    module Neutron
      @@monitor = []
      attr_accessor :id
      attr_accessor :atome_id

      def inspect
        properties = []
        instance_variables.map do |attribute|
          properties << {attribute => instance_variable_get(attribute)}
        end
        properties
      end

      def properties(params = nil, refresh = true)
        if params || params == false
          error("info is read only!! for now")
        else
          properties = []
          instance_variables.map do |attribute|
            properties << {attribute.sub("@".to_sym, "") => instance_variable_get(attribute)}
          end
          properties
        end
      end

      def info(params = nil, refresh = true)
        properties
      end

      def id(params = nil, refresh = true)
        if params || params == false
          @id = params.to_sym
          broadcast(atome_id => {id: params, private: false})
          Render.render_id(self, params) if refresh
          self
        else
          @id
        end
      end

      def id=(params = nil, refresh = true)
        id(params, refresh)
      end

      def convert(property, unit = :px)
        Render.render_convert self, property, unit
      end

      def name(params = nil, refresh = true)
        if params || params == false
          @name = params.to_sym
          self
        else
          @name
        end
      end

      def name=(params = nil, refresh = true)
        name(params, refresh)
      end

      def type(params = nil, refresh = true)
        if params || params == false
          @type = params
          broadcast(atome_id => {type: params, private: false})
          Render.render_type(self, params) if refresh
          self
        else
          @type
        end
      end

      def type=(params = nil, refresh = true)
        type(params, refresh)
      end

      def preset(params = nil)
        if params || params == false
          @preset = params
          self
        else
          @preset
        end
      end

      def preset=(params = nil, refresh = true)
        preset(params)
      end

      def content(params = nil, refresh = true)
        if params || params == false
          @content = params
          broadcast(atome_id => {content: params, private: false})
          Render.render_content(self, params) if refresh
          self
        else
          @content
        end
      end

      def content=(params = nil, refresh = true)
        content(params, refresh)
      end

      def edit(params = nil, refresh = true)
        if params || params == false
          @edit = params
          broadcast(atome_id => {edit: params, private: false})
          Render.render_edit(self, params) if refresh
          self
        else
          @edit
        end
      end

      def edit=(params = nil, refresh = true)
        edit(params, refresh)
      end

      def select(params = nil, refresh = true)
        if params || params == false
          @select = params
          broadcast(atome_id => {select: params, private: false})
          Render.render_select(self, params) if refresh
          self
        else
          @select
        end
      end

      def select=(params = nil, refresh = true)
        select(params, refresh)
      end

      def active(params = nil, refresh = true)
        if params || params == false
          @active = params
          broadcast(atome_id => {active: params, private: false})
          Render.render_active(self, params) if refresh
          self
        else
          @active
        end
      end

      def active=(params = nil, refresh = true)
        active(params, refresh)
      end

      def group(params = nil, refresh = true)
        atome = Atome.new({type: :shape, parent: :view})
        if params.class == Array
          params << self
        else
          params = [params, self]
        end
        atome.insert(params)
        atome
      end

      def group=(params = nil, refresh = true)
        group(params, refresh)
      end

      def parent(params = nil, refresh = true)
        if params
          atome = find_atome_from_params(params)
          Atome.atomes.each do |atome|
          end
          atome.insert(self)
        else
          # we check if the properties store is a string (atome_id), if its an array or an atome when return the raw value
          if @parent.class == String || @parent.class == Symbol
            grab(@parent)
          elsif @parent.class == Array
            # now we return an array of atome instead
            atome_parent = []
            @parent.each do |parent|
              atome_parent << grab(parent)
            end
            atome_parent
          else
            @parent
          end

        end
      end

      def parent=(params = nil, refresh = true)
        parent(params, refresh)
      end

      def child(params = nil, refresh = true)
        if params
          atome = find_atome_from_params(params)
          insert(atome)
        else
          # we check if the properties store is a string (atome-id), if its an array or an atome when return the raw value
          if @child.class == String || @child.class == Symbol
            grab(@child)
          elsif @child.class == Array
            # now we return an array of atome instead
            atome_child = []
            unless @child.nil?
              @child.each do |child|
                atome_child << grab(child)
              end
              atome_child
            end
          else
            @child
          end
        end
      end

      def child=(params = nil, refresh = true)
        child(params, refresh)
      end

      def insert(params = nil, refresh = true)
        @child = [] if @child.class == NilClass || (params.class == Hash && params[:add] == true)
        if params || params == false
          #if params.atome_id== self.atome_id
          #  alert "message is \n\n#{"montruous dick in the soup"} \n\nLocation: neutron.rb, line 229"
          #end
          if params.class == String || params.class == Symbol || params.class == Atome
            atome = find_atome_from_params(params)
            params = atome
            # below we store the child list in "child_list_found" variable to re-affect it after the line below(" parent_found.extract(params)") may remove them fixme : find a more oprimised solution maybe rewrite the whole child parent delete clear system
            child_list_found = [params.atome_id]
            @child |= child_list_found
            if params.parent
              #alert "message is \n\n#{:parent} \n\nLocation: neutron.rb, line 237"
              previous_parent = params.parent
              # the syntax below allow to add the value only if its present before.
              # its it already exist its replace not store twice
              previous_parent |= [atome_id]
              # we check if the child should be extract from it's ancient parent or not( if we add it)
              unless params.class == Hash && params[:add]
                #alert "message is \n\n#{:hash} \n\nLocation: neutron.rb, line 244"
                params.parent.each do |parent_found|
                  parent_found.extract(params)
                end
                # as we don't wont  to add it but move tthe atome, we have to remove it from it's previous parent
                previous_parent = [atome_id]
              end
              #alert "message is \n\n#{child_list_found} \n\nLocation: neutron.rb, line 251"
              @child |= child_list_found
              params.property({property: :parent, value: previous_parent})
            else
              params.property({property: :parent, value: [atome_id]})
            end
            broadcast(atome_id => {insert: params, private: false})
            Render.render_group(self, params) if refresh
          elsif params.class == Array
            params.each do |atome|
              insert(atome)
            end
          end
          self
        end
        self
      end

      def insert=(params = nil, refresh = true)
        insert(params, refresh)
      end

      def attach(params = nil, refresh = true)
        params = find_atome_from_params(params)
        params.insert(self)
      end

      def attach=(params = nil, refresh = true)
        attach(params, refresh)
      end

      def ungroup(params = nil, refresh = true)
        if child
          if params.class == String || params.class == Symbol || params.class == Atome
            params = find_atome_from_params(params)
            extract(params)
          elsif params.class == Array
            params.each do |atome_found|
              atome_found = find_atome_from_params(atome_found)
              extract(atome_found)
            end
          else
            child.each do |atome_found|
              atome_found = find_atome_from_params(atome_found)
              extract(atome_found)
            end

          end
        end

      end

      def ungroup=(params = nil, refresh = true)
        ungroup(params, refresh)
      end

      def extract(params = nil, refresh = true)
        new_child_list = []
        # we parse the child to find the requested
        if child
          child.each do |children|
            children = find_atome_from_params(children)
            params = find_atome_from_params(params)
            # we rebuild the array conataining the new list of child excluding the removed one
            if params.atome_id != children.atome_id
              new_child_list << children.atome_id
            else
              # now we have to  remove the extract atome from parent child list
              # now we have to  remove parental link to the current atome
              children.parent.delete(atome_id)
              # now we group the detached item from the parent
              # we attach the detached atome to the grand parent(parent of the current atome )
              # todo : maybe there's a better strategy than attaching to the last parent
              parent = find_atome_from_params(self.parent.last)
              # if we detach an atome from the view(as intuition is the parent of the view, and intuition is a reserved zone for tools) we made an exeption to attach the object to the dark matter
              if parent.atome_id == :intuition
                parent = grab(:dark_matter)
              end
              #we hook the detached atome to the new parent
              children.parent << parent.atome_id
              broadcast(atome_id => {extract: params, private: false})
              Render.render_group(parent, children) if refresh
            end
          end
          @child = new_child_list
        end

      end

      def extract=(params = nil, refresh = true)
        extract(params, refresh)
      end

      def detach(params = nil, refresh = true)
        params = find_atome_from_params(params)
        params.extract(self, refresh)
      end

      def detach=(params = nil, refresh = true)
        detach(params, refresh)
      end



      def selector(params = nil, refresh = true)
        if params || params == false
          if params.class == Hash && params[:add]
            if @selector.class == Array
              @selector << params if !@selector.include? params
            else
              @selector = [params]
            end
          else
            @selector = [params]
          end
          Render.render_selector(self, params) if refresh
        #  self
        else
          @selector
        end
      end

      def selector=(params = nil, refresh = true)
        selector(params, refresh)
      end

      # events
      def touch(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        if proc
          case params
          when nil
            options = {option: :touch, add: false}
          when Hash
            unless params[:option]
              params[:option] = :touch
            end
            unless params[:add]
              params[:add] = false
            end
            options = params
          when Array
            error "recursive analysis of array needed here"
          else
            options = {:option => params}
          end
          options = {:content => proc}.merge(options)
          #if params && (params[:add] || params[:add] == false || params[:add] == :false)
          if params.class == Hash && params[:add]
            if touch.class == Array
              @touch << options
            else
              prop_array = []
              prop_array << @touch
              prop_array << options
              @touch = prop_array
            end
          else
            @touch = options
          end
          broadcast(atome_id => {touch: options, private: false})
          if refresh
            Render.render_touch(self, options)
          end
          self
        else
          @touch
        end
      end

      def touch=(params = nil, refresh = true, &proc)
        touch(params, refresh, &proc)
      end

      def drag(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        if proc || !params.nil?
          case params
          when nil
            options = {option: :drag}
          when Hash
            options = params
          when Array
            error "recursive analysis of array here"
          else
            options = {:option => params}
          end
          bloc = {:content => proc}.merge(options)
          if params.class == Hash && params[:add]
            if drag.class == Array
              @drag << bloc
            else
              prop_array = []
              prop_array << @drag
              prop_array << bloc
              @drag = prop_array
            end
          else
            @drag = bloc
          end
          broadcast(atome_id => {drag: params, private: false})
          if refresh
            option = case params
                     when nil
                       :drag
                     when Hash
                       params
                     when true
                       params
                     when :true
                       params
                     when Symbol
                       {lock: params}
                     when String
                       {lock: params}
                     else
                       params
                     end
            params = {params: option, proc: proc}
            Render.render_drag(self, params)
          end
          self
        else
          @drag
        end
      end

      def drag=(params = nil, refresh = true, &proc)
        drag(params, refresh, &proc)
      end

      def over(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        broadcast(atome_id => {over: params, private: false})
        if proc
          if refresh
            params = {params: params, proc: proc}
            Render.render_over(self, params)
          end
        elsif params || params == false
          @over = params
          Render.render_over(self, params) if refresh
          self
        else
          @over
        end
      end

      def over=(params = nil, refresh = true, &proc)
        over(params, refresh, &proc)
      end

      def enter(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        if proc || !params.nil?
          case params
          when nil
            options = {option: :enter}
          when Hash
            options = params
          when Array
            error "recursive analysis of array here"
          else
            options = {:option => params}
          end
          bloc = {:content => proc}.merge(options)
          if params.class == Hash && params[:add]
            if drag.class == Array
              @enter << bloc
            else
              prop_array = []
              prop_array << @enter
              prop_array << bloc
              @enter = prop_array
            end
          else
            @enter = bloc
          end
          broadcast(atome_id => {enter: params, private: false})
          if refresh
            option = case params
                     when nil
                       :drop
                     when Hash
                       params
                     when true
                       params
                     when :true
                       params
                     when Symbol
                       params
                     when String
                       params.to_sym
                     else
                       params
                     end
            params = {params: option, proc: proc}
            Render.render_enter(self, params)
          end
          self
        else
          @enter
        end
      end

      def enter=(params = nil, refresh = true, &proc)
        enter(params, refresh, &proc)
      end

      def exit(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        if proc || !params.nil?
          case params
          when nil
            options = {option: :exit}
          when Hash
            options = params
          when Array
            error "recursive analysis of array here"
          else
            options = {:option => params}
          end
          bloc = {:content => proc}.merge(options)
          if params.class == Hash && params[:add]
            if drag.class == Array
              @exit << bloc
            else
              prop_array = []
              prop_array << @exit
              prop_array << bloc
              @exit = prop_array
            end
          else
            @exit = bloc
          end
          broadcast(atome_id => {exit: params, private: false})
          if refresh
            option = case params
                     when nil
                       :exit
                     when Hash
                       params
                     when true
                       params
                     when :true
                       params
                     when Symbol
                       params
                     when String
                       params.to_sym
                     else
                       params
                     end

            params = {params: option, proc: proc}
            Render.render_exit(self, params)
          end
          self
        else
          @leave
        end
      end

      def exit=(params = nil, refresh = true, &proc)
        exit(params, refresh, &proc)
      end

      def drop(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        if proc || !params.nil?
          case params
          when nil
            options = {option: :drop}
          when Hash
            options = params
          when Array
            error "recursive analysis of array here"
          else
            options = {:option => params}
          end
          bloc = {:content => proc}.merge(options)
          if params.class == Hash && params[:add]
            if drag.class == Array
              @drop << bloc
            else
              prop_array = []
              prop_array << @drop
              prop_array << bloc
              @drop = prop_array
            end
          else
            @drop = bloc
          end
          broadcast(atome_id => {drop: params, private: false})
          if refresh
            option = case params
                     when nil
                       :drop
                     when Hash
                       params
                     when true
                       params
                     when :true
                       params
                     when Symbol
                       params
                     when String
                       params.to_sym
                     else
                       params
                     end

            params = {params: option, proc: proc}
            Render.render_drop(self, params)
          end
          self
        else
          @drop
        end
      end

      def drop=(params = nil, refresh = true, &proc)
        collide(params, refresh, add, &proc)
      end

      def key(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        if proc
          case params
          when nil
            options = {option: :key}
          when Hash
            options = params
          when Array
            error "recursive analysis of array here"
          else
            options = {:option => params}
          end
          bloc = {:content => proc}.merge(options)
          if params.class == Hash && params[:add]
            if key.class == Array
              @key << bloc
            else
              prop_array = []
              prop_array << @key
              prop_array << bloc
              @key = prop_array
            end
          else
            @key = bloc
          end
          broadcast(atome_id => {key: params, private: false})
          if refresh
            option = case params
                     when nil
                       :key
                     when Hash
                       params[:option]
                     else
                       params
                     end
            params = {params: option, proc: proc}
            Render.render_key(self, params)
          end
          self
        else
          @key
        end
      end

      def key=(params = nil, refresh = true, &proc)
        key(params, refresh, &proc)
      end

      def resize(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        if proc || !params.nil?
          case params
          when nil
            options = {option: :resize}
          when Hash
            options = params
          when Array
            error "recursive analysis of array here"
          else
            options = {:option => params}
          end
          bloc = {:content => proc}.merge(options)
          if params.class == Hash && params[:add]
            if drag.class == Array
              @resize << bloc
            else
              prop_array = []
              prop_array << @resize
              prop_array << bloc
              @resize = prop_array
            end
          else
            @drag = bloc
          end
          broadcast(atome_id => {resize: params, private: false})
          if refresh
            params = {params: params, proc: proc}
            Render.render_resize(self, params)
          end
          self
        else
          @drag
        end
      end

      def resize=(params = nil, refresh = true, &proc)
        resize(params, refresh, &proc)
      end

      def scale(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        broadcast(atome_id => {scale: params, private: false})
        if proc
          Render.render_scale(self, proc) if refresh
        elsif params || params == false
          @scale = params
          Render.render_scale(self, params) if refresh
          self
        else
          @scale
        end
      end

      def scale=(params = nil, refresh = true, &proc)
        scale(params, refresh, &proc)
      end

      def scroll(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        broadcast(atome_id => {scroll: params, private: false})
        if proc
          Render.render_scroll(self, proc) if refresh
        elsif params || params == false
          @scroll = params
          Render.render_scroll(self, params) if refresh
          self
        else
          @scroll
        end
      end

      def scroll=(params = nil, refresh = true, &proc)
        scroll(params, refresh, &proc)
      end

      def clear(params = :console, refresh = true, &proc)


        if params.class == Hash
          if params[:exclude] && params[:exclude].class == Array
          elsif params[:exclude]
            exclusion_list = if params[:exclude].class == Array
                               params[:exclude]
                             else
                               [params[:exclude]]
                             end
            exclusion_list.each do |atome_to_keep|
              atome_to_keep = find_atome_from_params(atome_to_keep)
              grab(:view).child.each do |child_found|
                if child_found != atome_to_keep
                  child_found.delete(true)
                end
              end
            end
            #params = :reset_view
            #Render.render_clear(self, params)
          end
        elsif params.to_sym == :all || params.to_sym == :view
          #alert "message :\n#{get(:view).child}\n from : neutron.rb : 817"
          #alert "message :\n#{find({format: :id})}\n from : neutron.rb : 818"
          get(:view).child.each do |child_found|
            #if child_found && child_found.id==:view
            #  #alert "message :\n#{"big couille dans le potage"}\n from : neutron.rb : 822"
            #else
              if child_found
                child_found.delete(true)
              end
            #end

          end
        else
          child.each do |atome_found|
            atome_found.delete(true)
          end
        end
        self
      end

      # animation

      def play(params = nil, refresh = true, &proc)
        #todo : allow to pass video "start play position" without triggering the video with a touch event
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        if !params.nil?
          if proc
            case params
            when nil
              options = {option: :play}
            when Hash
              options = params
            when Array
              error "recursive analysis of array here"
            else
              options = {:option => params}
            end
            bloc = {:content => proc}.merge(options)
            if params.class == Hash && params[:add]
              if touch.class == Array
                @play << bloc
              else
                prop_array = []
                prop_array << @play
                prop_array << bloc
                @play = prop_array
              end
            else
              @play = bloc
            end
            broadcast(atome_id => {play: params, private: false})
            if refresh
              option = case params
                       when nil
                         :touch
                       when Hash
                         params[:option]
                       else
                         params
                       end
              params = {params: option, proc: proc}
              Render.render_play(self, params)
            end
            self
          else
            @play = params
            options = {}
            options[:params] = params
            Render.render_play(self, options)
          end
        else
          @play
        end
      end

      def play=(params = nil, refresh = true, &proc)
        play(params, refresh, &proc)
      end

      def pause(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        if proc
          case params
          when nil
            options = {option: :touch}
          when Hash
            options = params
          when Array
            error "recursive analysis of array here"
          else
            options = {:option => params}
          end
          bloc = {:content => proc}.merge(options)
          if params.class == Hash && params[:add]
            if touch.class == Array
              @pause << bloc
              @play = false
            else
              prop_array = []
              prop_array << @pause
              prop_array << bloc
              @pause = prop_array
              @play = false
            end
          else
            @pause = bloc
            @play = false
          end
          broadcast(atome_id => {pause: params, private: false})
          if refresh
            option = case params
                     when nil
                       :touch
                     when Hash
                       params[:option]
                     else
                       params
                     end
            params = {params: option, proc: proc}
            Render.render_pause(self, params)
          end
          return self
        else
          Render.render_pause(self, params)
          @play = false
        end
        @pause
      end

      def pause=(params = nil, refresh = true, &proc)
        pause(params, refresh, &proc)
      end

      def stop(params = "0", refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] && params[:content].class == Proc
        pause(params, refresh, &proc)
      end

      def stop=(params = nil, refresh = true, &proc)
        stop(params, refresh, &proc)
      end

      # int8
      def language(params = nil, refresh = true)
        if params || params == false
          @lanquage = params
          self
        else
          @lanquage
        end
      end

      # creation of object in object
      def image(params = nil, refresh = true)
        params = {content: Atome.presets[:image][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :image, preset: :image, content: content})
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome
      end

      def image=(params = nil, refresh = true)
        image(params, refresh)
      end

      def text(params = nil, refresh = true)
        params = {content: Atome.presets[:text][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :text, preset: :text, content: content})
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome
      end

      def text=(params = nil, refresh = true)
        text(params, refresh)
      end

      def box(params = nil, refresh = true)
        params = {content: Atome.presets[:box][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash

        atome = Atome.new({type: :shape, preset: :box})
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome
      end

      def box=(params = nil, refresh = true)
        box(params, refresh)
      end

      def circle(params = nil, refresh = true)
        params = {content: Atome.presets[:circle][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        atome = Atome.new({type: :shape, preset: :circle})
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome
      end

      def circle=(params = nil, refresh = true)
        circle(params, refresh)
      end

      def user(params = nil, refresh = true)
        params = {content: Atome.presets[:user][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :user, preset: :user, content: content})
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome
      end

      def user=(params = nil, refresh = true)
        user(params, refresh)
      end

      def video(params = nil, refresh = true)
        params = {content: Atome.presets[:video][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :video, preset: :video, content: content})
        insert(atome)
        atome_a = Atome.new({type: :audio, preset: :audio, content: content})
        atome.insert(atome_a)
        if params
          x = params.delete(:x) if params[:x]
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          atome_a.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome
      end

      def video=(params = nil, refresh = true)
        video(params, refresh)
      end

      def audio(params = nil, refresh = true)
        params = {content: Atome.presets[:audio][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :audio, preset: :audio, content: content})
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome

      end

      def audio=(params = nil, refresh = true)
        audio(params, refresh)
      end

      def web(params = nil, refresh = true)
        params = {content: Atome.presets[:web][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :web, preset: :web, content: content})
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome
      end

      def web=(params = nil, refresh = true)
        web(params, refresh)
      end

      def particle(params = nil, refresh = true)
        params = {content: Atome.presets[:particle][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :particle, preset: :particle, content: content}, refresh)
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        end
        atome
      end

      def particle=(params = nil, refresh = true)
        particle(params, refresh)
      end

      def tool(params = nil, refresh = true)
        params = {content: Atome.presets[:tool][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :tool, preset: :tool, content: content}, refresh)
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome
      end

      def tool=(params = nil, refresh = true)
        tool(params, refresh)
      end

      def effect(params = nil, refresh = true)
        params = {content: Atome.presets[:effect][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :effect, preset: :effect, content: content}, refresh)
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome
      end

      def effect=(params = nil, refresh = true)
        effect(params, refresh)
      end

      def constraint(params = nil, refresh = true)
        params = {content: Atome.presets[:constraint][:content]} unless params
        if params.class == Symbol || params.class == String
          content = {content: params}
          params = content
        end
        params && params.class == Hash
        content = params.delete(:content)
        atome = Atome.new({type: :tag, preset: :constraint, content: content}, refresh)
        insert(atome)
        if params
          x = params.delete(:x)
          y = params.delete(:y)
          xx = params.delete(:xx)
          yy = params.delete(:yy)
          atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
        else
          atome.set({center: :true})
        end
        atome


      end

      def constraint=(params = nil, refresh = true)
        constraint(params, refresh)
      end

      # utils

      def pick params
        # allow easily get child of  a certain type. ex : v.pick(:audio).level 0.5 get all child of type :audio
        childs = []
        child.each do |child|
          childs << child if child.type == params
        end
        if childs.length == 1
          childs = childs[0]
        else
          childs
        end
        childs
      end

      def each params, &proc
        child.each do |atome|
          proc.call(atome)
        end
      end

      def value(params = :size, refresh = true)
        if params.to_sym == :width
          Render.render_get_width(self)
        elsif params.to_sym == :height
          Render.render_get_height(self)
        elsif params.to_sym == :x
          Render.render_get_x(self)
        elsif params.to_sym == :y
          Render.render_get_y(self)
        else
          send(params)
        end
      end

      def value=(params = nil, refresh = true)
        value(params, refresh)
      end

      def broadcast(params)
        @@monitor.each do |action|
          atome = action[:atome]
          property = action[:property]
          proc = action[:proc]
          if atome == :all # monitor any modification on any object is monitored
            params.each do |messages|
              if property == :all
                proc.call(messages)
              else # monitor a specific property on any object is monitored
                if messages[1][property]
                  atome_id_found = messages[0]
                  value_found = messages[1][property]
                  proc.call([atome_id_found, value_found])
                end
              end
            end
          elsif params[atome] && params[atome][property] # monitor  a specific property on a specific object is monitored
            evt = params[atome][property]
            proc.call(evt)
          elsif params[atome] && property == :all # monitor any property on a specific object is monitored
            evt = params[atome]
            proc.call(evt)
          end
        end
      end

      def virtual_touch(params, &proc)
        #todo : pass ruby code not javascript!!
        Render.render_virtual_touch(self, params)
      end

      # here the user send the atome and the properties he want to monitor
      def monitor(params, &proc)
        # we add the proc to the hash send to the @@monitor
        if params == :clear || params == "clear" || params == :clear || params == "clear" || params == :delete || params == "delete" || params[:reset]
          @@monitor = []
        end
        if params[:atome].nil?
          params[:atome] = self.atome_id
        elsif params[:atome].class == Atome
          params[:atome] = params[:atome].atome_id
        end
        if proc
          params[:proc] = proc
          @@monitor << params
        end

      end

      # allow to set property to an object without using Atome's methods, used to assign the property avoiding to use the internal logic of the api
      # usage : b = box() ; b.assign({property: :color, value: :red})
      def property(params)
        unless params[:property].to_sym == :atome_id
          instance_variable_set("@" + params[:property], params[:value])
        end
      end

      def property=(params)
        property params
      end

      def assign(params)
        alert "deprecated please now use property method instead"
      end

      private

      def atome_id(params = nil, refresh = true)
        if params || params == false
          # todo : protect the atome_id so it can't be change by user
          error "atome_id is unalterable "
          #@atome_id = params
        else
          @atome_id
        end
      end

      def atome_id=(params = nil, refresh = true)
        atome_id params, refresh
      end

      def reorder_properties(properties)
        # we re order the hash to puts the atome_id type at the begining to optimise rendering
        type = properties.delete(:type)
        parent = properties.delete(:parent)
        width = properties.delete(:width)
        height = properties.delete(:height)
        content = properties.delete(:content)
        center = properties.delete(:center)
        size = properties.delete(:size)
        {type: type}.merge({parent: parent}).merge({width: width}).merge({height: height}).merge(properties).merge({content: content}).merge({size: size}).merge({center: center})
      end
    end
  end
end
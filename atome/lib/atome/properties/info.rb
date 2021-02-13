# frozen_string_literal: true

# here the methods to add conceptual properties to atome objects
module Nucleon
  module Core
    #this is a module for Atome gem dedicated to non audiovisual apis
    module Neutron
      @@monitor = []

      ## global methods
      ## global property methods
      #def magic_return(method)
      #  # the aim of this method is filter the return of the property,
      #  # so if it found a single content, it only return the value ex : a.color => :red instead of {content: :red}
      #  if method.length == 1 && method.class == hash
      #    method[:content]
      #  else
      #    method
      #  end
      #end
      #
      #def array_parsing(params, method_name)
      #  # this method change the params send by user so each data found in the params is added to the property array
      #  params.each do |param|
      #    if param.class == Hash
      #      param[:add] = true
      #      send(method_name, param)
      #    else
      #      send(method_name, {content: param, add: true})
      #    end
      #  end
      #  {}
      #end
      #
      #def add_parsing(params, method_name)
      #  # this method is used the property hash contain {add: true} key value pair
      #  # when so the hash property is turn into an array so it can accept many times the same property.
      #  # use for gradient or multiple shadows, etc...  ex : color: [{content : red, x: 0},{content : pink, x: 200}]
      #  params.delete(:add)
      #  previous_params = instance_variable_get("@#{method_name}")
      #  if previous_params.empty?
      #    instance_variable_set("@#{method_name}", [params])
      #  else
      #    instance_variable_set("@#{method_name}", [previous_params, params])
      #  end
      #end
      #
      #def reformat_params(params, method_name)
      #  # this method allow user to input simple datas and reformat the incoming datas so it always store a Hash
      #  # if its a string then the datas is put into the property content
      #  #   ex with color property : {color: {content: :red}}
      #  # if it's an array then property itself change from Hash type to array
      #  #   ex with color property{color: [{content: :red}{content: :yellow, x: 200}]}
      #  if params.class == Hash
      #    params
      #  elsif params.class == Array
      #    array_parsing params, method_name
      #  else
      #    {content: params}
      #  end
      #end
      #
      #def method_analysis(params, instance_variable, method_name)
      #  # this method first send the params to the 'reformat_params' method to ensure it return a hash or an array
      #  params = reformat_params params, method_name
      #  # then etheir it parse the params if {add: true} is found, so it add the params to the property hash,
      #  # etheir it add any {key: :value} found to the instance variable property
      #  if params[:add] && params[:add] == true
      #    add_parsing params, method_name
      #  else
      #    params.each do |key, value|
      #      instance_variable[key] = value
      #    end
      #  end
      #  # now we apply the specific treatment according to the property found if the hash is not empty
      #  send(method_name + '_treatment', params) if params != {}
      #end

      # specific methods methods

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
          @type = {content: params}
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

      # specific property methods
      #def type_proc(proc)
      #  # if the object property contain a Proc it'll be processed here
      #  proc
      #end
      #
      #def type_rendering(params)
      #  # if the object property needs to be refresh then I'm your method
      #  Render.render_type(self, params) if params[:refresh].nil? || params[:refresh] == true
      #end
      #
      #def type_processing(properties)
      #  # let's go with the DSP ...
      #  properties
      #end
      #
      #def type_treatment(params)
      #  # here happen the specific treatment for the current property
      #  if params.class == Hash
      #    type_proc params[:proc] if params && params[:proc]
      #    type_processing params
      #    # if prop needs to be refresh we send it to the Render engine
      #    type_rendering params
      #  elsif params.class == Array
      #    # if params is an array is found we send each item of the array to 'type_treatment' as a Hash
      #    params.each do |param|
      #      type_treatment param
      #    end
      #  end
      #  broadcast(atome_id => {type: params})
      #end
      #
      #def type(params = nil)
      #  # This is the entry point for property getter and setter:
      #  # this is the main entry method for the current property treatment
      #  # first we create a hash for the property if t doesnt exist
      #  # we don't create a object init time, to only create property when needed
      #  @type ||= {}
      #  # we send the params to the 'reformat_params' if there's a params
      #  method_analysis params, @type, :type if params
      #  # finally we return the current property using magic_return
      #  if params
      #    self
      #  else
      #    magic_return @type
      #  end
      #end
      #
      #def type=(params = nil)
      #  type(params)
      #end


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
          # we check if the properties store is a string (atome_id),
          #if its an array or an atome when return the raw value
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
          # we check if the properties store is a string (atome-id),
          #if its an array or an atome when return the raw value
          if @child.class == String || @child.class == Symbol
          elsif @child.class == Array
            # now we return an array of atome instead
            atome_child = []
            unless @child.nil?
              @child.each do |child|
                find({value: child, property: :atome_id, scope: :all}).each do |atome|
                  if atome.class == Atome
                    atome_child << grab(child)
                  end
                end
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
          if params.class == String || params.class == Symbol || params.class == Atome
            atome = find_atome_from_params(params)
            params = atome
            # below we store the child list in "child_list_found"
            #variable to re-affect it after the line below(" parent_found.extract(params)")
            #may remove them fixme : find a more oprimised solution maybe rewrite the whole child parent delete clear system
            child_list_found = [params.atome_id]
            @child |= child_list_found
            if params.parent
              previous_parent = params.parent
              # the syntax below allow to add the value only if its present before.
              # if it already exist its replace not store twice
              previous_parent |= [atome_id]
              # we check if the child should be extract from it's ancient parent or not( if we add it)
              unless params.class == Hash && params[:add]
                params.parent.each do |parent_found|
                  parent_found.extract(params)
                end
                # as we don't wont  to add it but move tthe atome, we have to remove it from it's previous parent
                previous_parent = [atome_id]
              end
              @child |= child_list_found
              params.property({property: :parent, value: previous_parent})
            else
              params.property({property: :parent, value: [atome_id]})
            end
            broadcast(atome_id => {insert: params, private: false})
            Render.render_group(self, params) if refresh
            #alert "message :\n(#{params},\n #{params.atome_id},\n #{params.id}\n#{params.x()})
            #from : neutron.rb : 262"
            #params.x(0)
            #params.y(0)
            if params.y
              if y > params.y
                params.y = params.y[:content] + y[:content]
              else
                params.y = params.y[:content] - y[:content]
              end
            end
            if params.x
              if x > params.x
                params.x = x[:content] + params.x[:content]
              else
                params.x = params.x[:content] - x[:content]
              end
            end
          elsif params.class == Array
            params.each do |atome|
              insert(atome)
            end
          end
          self
        end
        self
      end


      #def check_prop_status params, property
      #  #(we want to define property on the fly thast hy wheck very time instead of defining all properties
      #  #at atome initialisation)
      #  if property.class == NilClass || (params.class == Hash && params[:add] == true)
      #    property = []
      #  else
      #    property
      #  end
      #  return property
      #end

      #def reformat_params params , call_from_method
      #  if params.class == String || params.class == Symbol || params.class == Atome
      #
      #  elsif params.class == Array
      #    params.each do |atome|
      #      self.send(call_from_method,atome)
      #    end
      #  end
      #end

      def << params
        self.content(content + params)
        #alert "message :\n#{content}\n from : neutron.rb : 313"
      end

      #def insert(params = nil, refresh = true)
      #  #just to check if child is already defined
      #  @child = check_prop_status(params, @child)
      #  if params || params == false
      #    puts "message :\n#{params}\n from : neutron.rb : 313"
      #
      #    params=reformat_params params, :insert
      #    #if params.class == String || params.class == Symbol || params.class == Atome
      #    #  atome = find_atome_from_params(params)
      #    #  params = atome
      #    #  # below we store the child list in "child_list_found"
      #variable to re-affect it after the line below(" parent_found.extract(params)")
      #may remove them fixme : find a more oprimised solution maybe rewrite the whole child parent delete clear system
      #    #  child_list_found = [params.atome_id]
      #    #  @child |= child_list_found
      #    #  if params.parent
      #    #    previous_parent = params.parent
      #    #    # the syntax below allow to add the value only if its present before.
      #    #    # if it already exist its replace not store twice
      #    #    previous_parent |= [atome_id]
      #    #    # we check if the child should be extract from it's ancient parent or not( if we add it)
      #    #    unless params.class == Hash && params[:add]
      #    #      params.parent.each do |parent_found|
      #    #        parent_found.extract(params)
      #    #      end
      #    #      # as we don't wont  to add it but move tthe atome, we have to remove it from it's
      #previous parent
      #    #      previous_parent = [atome_id]
      #    #    end
      #    #    @child |= child_list_found
      #    #    params.property({property: :parent, value: previous_parent})
      #    #  else
      #    #    params.property({property: :parent, value: [atome_id]})
      #    #  end
      #    #  broadcast(atome_id => {insert: params, private: false})
      #    #  Render.render_group(self, params) if refresh
      #    #  if params.y
      #    #    if y > params.y
      #    #      params.y = params.y[:content] + y[:content]
      #    #    else
      #    #      params.y = params.y[:content] - y[:content]
      #    #    end
      #    #  end
      #    #  if params.x
      #    #    if x > params.x
      #    #      params.x = x[:content] + params.x[:content]
      #    #    else
      #    #      params.x = params.x[:content] - x[:content]
      #    #    end
      #    #  end
      #    #elsif params.class == Array
      #    #  params.each do |atome|
      #    #    insert(atome)
      #    #  end
      #    #end
      #    self
      #  end
      #  self
      #end


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
              # if we detach an atome from the view(as intuition is the parent of the view, and intuition
              #is a reserved zone for tools) we made an exeption to attach the object to the dark matter
              parent = grab(:dark_matter) if parent.atome_id == :intuition
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

      def selection params
        if params
          self.find(property: :select, value: true, recursive: true).each do |atome|
            atome.set(params)
          end
        else
          select_atomes=[]
          self.find(property: :select, value: true, recursive: true).each do |atome|
            select_atomes << atome
          end
          select_atomes
        end

      end

      # def selector(params = nil, refresh = true)
      #   if params || params == false
      #     if params.class == Hash && params[:add]
      #       if @selector.class == Array
      #         @selector << params if !@selector.include? params
      #       else
      #         @selector = [params]
      #       end
      #     else
      #       @selector = [params]
      #     end
      #     Render.render_selector(self, params) if refresh
      #     #  self
      #   else
      #     @selector
      #   end
      # end
      #
      # def selector=(params = nil, refresh = true)
      #   selector(params, refresh)
      # end

      # events
      def touch(params = nil, refresh = true, &proc)
        #alert "message :\n#{params}\n from : neutron.rb : 600"
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
        if proc
          case params
          when nil
            options = {option: :touch, add: false}
          when Hash
            params[:option] = :touch unless params[:option]
            params[:add] = false unless params[:add]
            options = params
          when Array
            error "recursive analysis of array needed here"
          else
            options = {:option => params}
          end
          options = {:content => proc}.merge(options)
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
          Render.render_touch(self, options) if refresh
          self
        else
          @touch
        end
      end

      def touch=(params = nil, refresh = true, &proc)
        touch(params, refresh, &proc)
      end

      ## specific property methods
      #def touch_proc(proc)
      #  # if the object property contain a Proc it'll be processed here
      #  proc
      #end
      #
      #def touch_rendering(params)
      #  # if the object property needs to be refresh then I'm your method
      #  Render.render_touch(self, params) if params[:refresh].nil? || params[:refresh] == true
      #end
      #
      #def touch_processing(properties)
      #  # let's go with the DSP ...
      #  properties
      #end
      #
      #def touch_treatment(params)
      #  # here happen the specific treatment for the current property
      #  if params.class == Hash
      #    touch_proc params[:proc] if params && params[:proc]
      #    touch_processing params
      #    # if prop needs to be refresh we send it to the Render engine
      #    touch_rendering params
      #  elsif params.class == Array
      #    # if params is an array is found we send each item of the array to 'touch_treatment' as a Hash
      #    params.each do |param|
      #      touch_treatment param
      #    end
      #  end
      #  broadcast(atome_id => { touch: params })
      #end
      #
      #def touch(params = nil)
      #  # This is the entry point for property getter and setter:
      #  # this is the main entry method for the current property treatment
      #  # first we create a hash for the property if t doesnt exist
      #  # we don't create a object init time, to only create property when needed
      #  @touch ||= {}
      #  # we send the params to the 'reformat_params' if there's a params
      #  method_analysis params, @touch, :touch if params
      #  # finally we return the current property using magic_return
      #  if params
      #    self
      #  else
      #    magic_return @touch
      #  end
      #end
      #
      #def touch=(params = nil)
      #  touch(params)
      #end

      def drag(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc

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
        elsif (params.class== String || params.class== Symbol ) && refresh
          params= { params: params }
          Render.render_key(self, params)
        else
          @key
        end
      end

      def key=(params = nil, refresh = true, &proc)
        key(params, refresh, &proc)
      end

      def resize(params = nil, refresh = true, &proc)
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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

      #def clear(params = :console, refresh = true, &proc)
      #  if params.class == Hash
      #    if params[:exclude] && params[:exclude].class == Array
      #    elsif params[:exclude]
      #      exclusion_list = if params[:exclude].class == Array
      #                         params[:exclude]
      #                       else
      #                         [params[:exclude]]
      #                       end
      #      exclusion_list.each do |atome_to_keep|
      #        atome_to_keep = find_atome_from_params(atome_to_keep)
      #        grab(:view).child.each do |child_found|
      #          child_found.delete(true) if child_found != atome_to_keep
      #        end
      #      end
      #      #params = :reset_view
      #      #Render.render_clear(self, params)
      #    end
      #  elsif params.to_sym == :all || params.to_sym == :view
      #    alert "message :\n#{get(:view).child}\n from : neutron.rb : 817"
      #    #alert "message :\n#{find({format: :id})}\n from : neutron.rb : 818"
      #    get(:view).child.each do |child_found|
      #      if child_found && child_found.id==:view
      #      #  #alert "message :\n#{"big couille dans le potage"}\n from : neutron.rb : 822"
      #      else
      #      child_found.delete(true) if child_found
      #      end
      #
      #    end
      #  else
      #    child.each do |atome_found|
      #      atome_found.delete(true)
      #    end
      #  end
      #  self
      #end
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
                child_found.delete(true) if child_found != atome_to_keep
              end
            end
          end
        elsif params.to_sym == :all || params.to_sym == :view
          get(:view).child.each do |child_found|
            child_found&.delete(true)
          end
        else
          child.each do |atome_found|
            atome_found&.delete(true)
          end
        end
        self
      end

      # animation

      def play(params = nil, refresh = true, &proc)
        #todo : allow to pass video "start play position" without triggering the video with a touch event
        if params != false
          proc = params[:content] if params && params.class == Hash && params[:content] &&
              params[:content].class == Proc
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
        else
          false
        end
        #self
      end

      def play=(params = nil, refresh = true, &proc)
        play(params, refresh, &proc)
      end

      def pause(params = nil, refresh = true, &proc)
        self.play(false)
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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
            alert :child
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
        proc = params[:content] if params && params.class == Hash && params[:content] &&
            params[:content].class == Proc
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

      # methods to allow creation of object in object
      def image(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:image][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :image, preset: :image, content: content})
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end

      end

      def image=(params = nil, refresh = true)
        image(params, refresh)
      end

      def text(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:text][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :text, preset: :text, content: content})
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]

        end

      end

      def text=(params = nil, refresh = true)
        text(params, refresh)
      end

      def box(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:box][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash

          atome = Atome.new({type: :shape, preset: :box})
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end

      end

      def box=(params = nil, refresh = true)
        box(params, refresh)
      end

      def circle(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:circle][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          atome = Atome.new({type: :shape, preset: :circle})
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end

      end

      def circle=(params = nil, refresh = true)
        circle(params, refresh)
      end

      def user(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:user][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :user, preset: :user, content: content})
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end

      end

      def user=(params = nil, refresh = true)
        user(params, refresh)
      end

      def code(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:code][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :code, preset: :code, content: content})
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end

      end

      def code=(params = nil, refresh = true)
        code(params, refresh)
      end

      def video(params = nil, refresh = true)
        if params
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
          if params && params != true
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
        else
          return self.child[0]
        end

      end

      def video=(params = nil, refresh = true)
        video(params, refresh)
      end

      def audio(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:audio][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :audio, preset: :audio, content: content})
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end
      end

      def audio=(params = nil, refresh = true)
        audio(params, refresh)
      end

      def web(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:web][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :web, preset: :web, content: content})
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end

      end

      def web=(params = nil, refresh = true)
        web(params, refresh)
      end

      def particle(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:particle][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :particle, preset: :particle, content: content}, refresh)
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          end
          atome
        else
          return self.child[0]
        end

      end

      def particle=(params = nil, refresh = true)
        particle(params, refresh)
      end

      def tool(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:tool][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :tool, preset: :tool, content: content}, refresh)
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end

      end

      def tool=(params = nil, refresh = true)
        tool(params, refresh)
      end

      def effect(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:effect][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :effect, preset: :effect, content: content}, refresh)
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end

      end

      def effect=(params = nil, refresh = true)
        effect(params, refresh)
      end

      def constraint(params = nil, refresh = true)
        if params
          params = {content: Atome.presets[:constraint][:content]} unless params
          if params.class == Symbol || params.class == String
            content = {content: params}
            params = content
          end
          params && params.class == Hash
          content = params.delete(:content)
          atome = Atome.new({type: :tag, preset: :constraint, content: content}, refresh)
          insert(atome)
          if params && params != true
            x = params.delete(:x)
            y = params.delete(:y)
            xx = params.delete(:xx)
            yy = params.delete(:yy)
            atome.set(params.merge({center: :true, x: x, y: y, xx: xx, yy: yy}))
          else
            atome.set({center: :true})
          end
          atome
        else
          return self.child[0]
        end
      end

      def constraint=(params = nil, refresh = true)
        constraint(params, refresh)
      end

      # utils

      def pick params
        #allow easily get child of  a certain type. ex : v.pick(:audio).level 0.5 get all child of type :audio
        childs = []
        child.each do |child|
          childs << child if child.type[:content] == params
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


      def virtual_touch(params, &proc)
        #todo : pass ruby code not javascript!!
        Render.render_virtual_touch(self, params)
      end

      # here the user send the atome and the properties he want to monitor
      def monitor(params, &proc)
        # we add the proc to the hash send to the @@monitor
        if params == :clear || params == "clear" || params == :clear || params == "clear" || params == :delete ||
            params == "delete" || params[:reset]
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

      # allow to set property to an object without using Atome's methods, used to assign the property avoiding
      #to use the internal logic of the api
      # usage : b = box() ; b.assign({property: :color, value: :red})
      def property(params)
        instance_variable_set("@" + params[:property], params[:value]) unless params[:property].to_sym == :atome_id
      end

      def property=(params)
        property params
      end


      #private

      def broadcast_all(params, action)
        params.each do |messages|
          if action[:property] == :all
            action[:proc].call(messages)
            # monitor a specific property on any object is monitored
          elsif messages[1][action[:property]]
            action[:proc].call([messages[0], messages[1][action[:property]]])
          end
        end
      end

      def broadcast_object_property(params, action)
        evt = params[action[:atome]][action[:property]]
        action[:proc].call(evt)
      end

      def broadcast_property(params, action)
        evt = params[action[:atome]]
        action[:proc].call(evt)
      end

      def broadcast(params)
        @@monitor.each do |action|
          # monitor any modification on any object is monitored
          if action[:atome] == :all
            broadcast_all(params, action)
            # monitor a specific property on a specific object is monitored
          elsif params[action[:atome]] && params[action[:atome]][action[:property]]
            broadcast_object_property(params, action)
            # monitor any property on a specific object is monitored
          elsif params[action[:atome]] && action[:property] == :all
            broadcast_property(params, action)
          end
        end
      end

      #def atome_id_proc(proc)
      #  # if the object property contain a Proc it'll be processed here
      #  proc
      #end
      #
      #def atome_id_rendering(params)
      #  # if the object property needs to be refresh then I'm your method
      #  Render.render_atome_id(self, params) if params[:refresh].nil? || params[:refresh] == true
      #end
      #
      #def atome_id_processing(properties)
      #  # let's go with the DSP ...
      #  properties
      #end
      #
      #def atome_id_treatment(params)
      #  # here happen the specific treatment for the current property
      #  if params.class == Hash
      #    atome_id_proc params[:proc] if params && params[:proc]
      #    atome_id_processing params
      #    # if prop needs to be refresh we send it to the Render engine
      #    atome_id_rendering params
      #  elsif params.class == Array
      #    # if params is an array is found we send each item of the array to 'atome_id_treatment' as a Hash
      #    params.each do |param|
      #      atome_id_treatment param
      #    end
      #  end
      #  broadcast(atome_id => {atome_id: params})
      #end
      #
      #def atome_id(params = nil)
      #  # This is the entry point for property getter and setter:
      #  # this is the main entry method for the current property treatment
      #  # first we create a hash for the property if t doesnt exist
      #  # we don't create a object init time, to only create property when needed
      #  @atome_id ||= {}
      #  # we send the params to the 'reformat_params' if there's a params
      #  method_analysis params, @atome_id, :atome_id if params
      #  # finally we return the current property using magic_return
      #  if params
      #    self
      #  else
      #    magic_return @atome_id
      #  end
      #end
      #
      #def atome_id=(params = nil)
      #  atome_id(params)
      #end
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

      ################## utilities  ##############
      def reorder_properties(properties)
        # we re order the hash to puts the atome_id type at the begining to optimise rendering
        type = properties.delete(:type)
        parent = properties.delete(:parent)
        width = properties.delete(:width)
        height = properties.delete(:height)
        content = properties.delete(:content)
        center = properties.delete(:center)
        size = properties.delete(:size)
        {type: type}.merge({parent: parent}).merge({width: width}).merge({height: height})
            .merge(properties).merge({content: content}).merge({size: size}).merge({center: center})
      end

      # def batch atomes, properties
      #   atomes.each do |atome|
      #     properties.each do |property, value|
      #       atome.send(property, value)
      #     end
      #   end
      # end

      def batch(*params)
        collector=[]
        params.each do |atome|
          collector <<  atome
        end
        collector({content: collector})
      end

      def recursive_parse_params params, method
        # alert "info.rb line 1925 :  #{params}"
        properties = Atome.presets[method]
        params.each do |key, value|
          properties[key] = value
        end
        properties
      end


      def parse_params params, method
        case params
        when Array
          params_array=[]
          params.each do
            params_array <<  recursive_parse_params(params, method)
          end
          params_array

        when Hash
          recursive_parse_params(params, method)
        when Boolean, :true
          Atome.presets[method]
        when String, Symbol
          params
        end
      end

      def get_proc_content(proc)
        #proc_parser allow to parse a proc
        lines = `String(#{proc})`
        value_found = ""
        proc_content = []
        lines = lines.split("\n")
        lines.shift
        lines.each_with_index do |line|
          line = line.gsub(".$", ".").gsub(";", "")
          unless line.include?('$writer[$rb_minus($writer["length"], 1)]')
            if line.include?("$writer = [")
              value_found = line.sub('$writer = [', "").sub(/]/i, '')
            elsif line.include?("$send(")
              content = line.sub("$send(", "").sub("Opal.to_a($writer))", "")
              content = content.split(",")
              variable = content[0].gsub(" ", "")
              property = content[1].gsub("'", "").gsub(" ", "")
              line = variable + "." + property + value_found
              proc_content << line
            else
              proc_content << line
            end
          end
        end
        return proc_content.join("\n")
      end


    end
  end
end
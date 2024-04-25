# frozen_string_literal: true

# allow to access Atome class using only a uniq atome
class Genesis
  class << self

    def create_particle(element, store, render)
      Atome.define_method "set_#{element}" do |params, &user_proc|
        particle_creation(element, params, store, render, &user_proc)
      end
    end

    def build_particle(particle_name, options = {}, &particle_proc)
      type = options[:type]
      category = options[:category]
      type = :string if options[:type].nil?
      store = options[:store]
      store = true if options[:store].nil?
      render = options[:render]
      render = true if options[:render].nil?

      # we add the new method to the particle's collection of methods
      Universe.add_to_particle_list(particle_name, type, category)
      # the line below create an empty particle method for each renderer, eg: browser_left, headless_width, ...
      # the line below create the corresponding particle method for Batch class
      # particle_method_for_batch(particle_name)
      auto_render_generator(particle_name) if render
      new_particle(particle_name, store, render, &particle_proc)
      # the line below create all alternatives methods such as create 'method='
      additional_particle_methods(particle_name, store, render, &particle_proc)
    end

    def build_atome(atome_name, &atome_proc)
      # we add the new method to the atome's collection of methods
      Universe.add_to_atome_list(atome_name)
      # the method below generate Atome method creation at Object level,
      # so a syntax like : 'text(:hello)' is possible instead of the mandatory : grab(:view).text(:hello)
      atome_method_for_object(atome_name)
      # the line below create the corresponding atome method for Batch class
      # atome_method_for_batch(atome_name)
      unless Essentials.default_params[atome_name]
        # we create default params for the new created atome, adding the hash to : module essential, @default_params
        # FIXME : the hash : attach: [:view] means that newly atome will systematically be attached to the wview instaed of the parent:
        # ex : b.www will attach to view not b!
        Essentials.new_default_params(atome_name => { type: atome_name })
      end

      # the line below create an empty atome method for each renderer, eg: browser_shape, headless_color, ...
      auto_render_generator(atome_name)
      new_atome(atome_name, &atome_proc)

    end

    def build_molecule(molecule_name, &molecule_proc)
      new_molecule(molecule_name, &molecule_proc)
    end

    def auto_render_generator(element)
      Universe.renderer_list.each do |render_engine|
        build_render("#{render_engine}_#{element}",)
      end
    end

    def build_render(renderer_name, &method_proc)
      Atome.define_method renderer_name do |params = nil, &user_proc|
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
      end
    end

    def build_sanitizer(method_name, &method_proc)
      Universe.add_sanitizer_method(method_name.to_sym, &method_proc)
    end

    def build_option(method_name, method_proc)
      Universe.add_optional_method(method_name.to_sym, method_proc)
    end

    def new_particle(element, store, render, &_method_proc)
      # unless @id
      #   alert self.id
      # end

      Atome.define_method element do |params = nil, &user_proc|
        # if @id
        #   alert  "======> #{self.class}"
        @history[element] ||= []
        # else
        #   alert  "======> #{self.inspect}"
        # end
        if (params || params == false) && write_auth(element)
          params = particle_sanitizer(element, params, &user_proc)
          # the line below execute the main code when creating a new particle
          # ex : new({ particle: :my_particle } do....
          # instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
          Genesis.create_particle(element, store, render)
          # TODO: try to optimise and find a better way wo we can remove the condition below
          if @type == :group && !%i[type id collect layout].include?(element)
            collect.each do |collected_found|
              grab(collected_found).send(element, params, &user_proc)
            end
          end

          computed_params = send("set_#{element}", params, &user_proc) # sent to : create_particle / Atome.define_method "set_#{element}"

          # we historicize all write action below
          # we add the changes to the stack that must be synchronised
          # Universe.historicize(@aid, :write, element, params)
          computed_params
        elsif params || params == false
          "send a valid password to write #{element} value"
        elsif read_auth(element)
          # particle getter below
          value_found = instance_variable_get("@#{element}")
          # uncomment below to  historicize all read action
          # Universe.historicize(@id, :read, element, value_found)
          # we add the optional read plugin
          value_found = particle_read(element, value_found, &user_proc)
          value_found
          # TODO : create a fast method to get particle: eg:
          #  Atome.define_method "set_#{element}" ... =>  send("set_#{element}"
        else
          "send a valid password to read #{element} value"
        end
        # else
        #
        #  end
      end
    end

    def additional_particle_methods(element, store, rendering, &method_proc)
      # it allow the creation of method like top=, rotate=, ...
      Atome.define_method "#{element}=" do |params = nil, &user_proc|
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        params = particle_sanitizer(element, params)
        particle_creation(element, params, store, rendering, &user_proc)
      end
    end

    def new_atome(element, &method_proc)

      # the method define below is the slowest but params are analysed and sanitized
      Atome.define_method element do |params = nil, &user_proc|
        instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        if params
          params = atome_sanitizer(element, params, &user_proc)
          atome_processor(element, params, &user_proc)
        else
          # when no params passed whe assume teh user want a getter,
          # as getter should give us all atome of a given within the atome
          # ex : puts a.shape => return all atome with the type 'shape' in this atome
          collected_atomes = []
          # attached.each do |attached_atome|
          #   collected_atomes << attached_atome if grab(attached_atome).type.to_sym == element.to_sym
          # end
          if Universe.applicable_atomes.include?(element)
            # we do the same for apply to be able to retrieve 'color' and other atome that apply instead of being attached
            @apply.each do |attached_atome|
              collected_atomes << attached_atome if grab(attached_atome).type.to_sym == element.to_sym
            end
          else
            # collected_atomes = attached
            # if @attached
            attached.each do |attached_atome|
              collected_atomes << attached_atome if grab(attached_atome).type.to_sym == element.to_sym
            end
            # end

          end
          # TODO/ FIXME : potential problem with group  here"
          # group({ collect: collected_atomes })
          collected_atomes
        end
      end

      # the method define below is the fastest params are passed directly
      Atome.define_method "set_#{element}" do |params, &user_proc|
        # we generate the corresponding module here:
        # Object.const_set(element, Module.new)
        # we add the newly created atome to the list of "child in it's category, eg if it's a shape we add the new atome
        # to the shape particles list : @!atome[:shape] << params[:id]
        # Atome.new(params, &user_proc)

        if Universe.atomes[params[:id]]
          # if atome id already exist we grab the previous one
          # this prevent the creation of new atome if the atome already exist
          previous_atome = grab(params[:id])
          # now we must re-affect affected atomes
          previous_atome.affect(params[:affect])
          previous_atome
        else
          Atome.new(params, &user_proc)
        end
        # Now we return the newly created atome instead of the current atome that is the parent cf: b=box; c=b.circle
      end

    end

    def new_molecule(molecule, &method_proc)

      Molecule.define_method molecule do |params, &user_proc|
        object_to_return = instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
        # new_objet = Object.new
        # # we store the molecule into an instance variable in a basic ruby object
        # new_objet.instance_variable_set(:@molecule, object_to_return)
        # new_objet
        object_to_return
      end

      # # the method define below is the slowest but params are analysed and sanitized
      # Atome.define_method element do |params = nil, &user_proc|
      #   instance_exec(params, user_proc, &method_proc) if method_proc.is_a?(Proc)
      #   if params
      #     params = atome_sanitizer(element, params, &user_proc)
      #     atome_processor(element, params, &user_proc)
      #   else
      #     # when no params passed whe assume teh user want a getter,
      #     # as getter should give us all atome of a given within the atome
      #     # ex : puts a.shape => return all atome with the type 'shape' in this atome
      #     collected_atomes = []
      #     # attached.each do |attached_atome|
      #     #   collected_atomes << attached_atome if grab(attached_atome).type.to_sym == element.to_sym
      #     # end
      #     # TODO : add category for atome( material/physical vs modifier : color, shadow, .. vs shape, image ..)
      #     # then add condition same things fo code in presets/atome atome_common
      #     if %i[color shadow paint border].include?(element)
      #       # we do the same for apply to be able to retrieve 'color' and other atome that apply instead of being attached
      #       @apply.each do |attached_atome|
      #         collected_atomes << attached_atome if grab(attached_atome).type.to_sym == element.to_sym
      #       end
      #     else
      #       # collected_atomes = attached
      #       # if @attached
      #       attached.each do |attached_atome|
      #         collected_atomes << attached_atome if grab(attached_atome).type.to_sym == element.to_sym
      #       end
      #       # end
      #
      #     end
      #     # TODO/ FIXME : potential problem with group  here"
      #     # group({ collect: collected_atomes })
      #     collected_atomes
      #   end
      # end
      #
      # # the method define below is the fastest params are passed directly
      # Atome.define_method "set_#{element}" do |params, &user_proc|
      #   # we generate the corresponding module here:
      #   # Object.const_set(element, Module.new)
      #   # we add the newly created atome to the list of "child in it's category, eg if it's a shape we add the new atome
      #   # to the shape particles list : @!atome[:shape] << params[:id]
      #   # Atome.new(params, &user_proc)
      #
      #   if Universe.atomes[params[:id]]
      #     # if atome id already exist we grab the previous one
      #     # this prevent the creation of new atome if the atome already exist
      #     previous_atome= grab(params[:id])
      #     # now we must re-affect affected atomes
      #     previous_atome.affect(params[:affect])
      #     previous_atome
      #   else
      #     Atome.new(params, &user_proc)
      #   end
      #   # Now we return the newly created atome instead of the current atome that is the parent cf: b=box; c=b.circle
      # end

    end

  end

end

# frozen_string_literal: true

# allow to access Atome class using only a uniq atome
class Genesis
  class << self
    def generator
      Atome.new
    end
  end
end

# Genesis method here
class Atome
  def build_particle(particle_name, options = {}, &particle_proc)
    type = options[:type]
    type = :string if options[:type].nil?
    store = options[:store]
    store = true if options[:store].nil?
    render = options[:render]
    render = true if options[:render].nil?

    # we add the new method to the particle's collection of methods
    Universe.add_to_particle_list(particle_name, type)
    # the line below create an empty particle method for each renderer, eg: browser_left, headless_width, ...
    # the line below create the corresponding particle method for Batch class
    # particle_method_for_batch(particle_name)
    auto_render_generator(particle_name) if render
    new_particle(particle_name, store, render, &particle_proc)
    # the line below create all alternatives methods such as create 'method='
    additional_particle_methods(particle_name, store, render, &particle_proc)
  end

  def build_atome(atome_name, &atome_proc)
    # puts  "--------> atome_name is : #{atome_name}"
    # TODO : atomes should tell the Universe if they're parts of physical category or else
    # we add the new method to the atome's collection of methods
    Universe.add_to_atome_list(atome_name)
    # the method below generate Atome method creation at Object level,
    # so a syntax like : 'text(:hello)' is possible instead of the mandatory : grab(:view).text(:hello)
    atome_method_for_object(atome_name)
    # the line below create the corresponding atome method for Batch class
    # atome_method_for_batch(atome_name)
    unless Essentials.default_params[atome_name]
      # if it doesn't exist
      # we create default params for the new created atome, adding the hash to : module essential, @default_params
      Essentials.new_default_params(atome_name => { type: atome_name, attach: [:view] })
    end

    # the line below create an empty atome method for each renderer, eg: browser_shape, headless_color, ...
    auto_render_generator(atome_name)
    # create_atome(atome_name)
    # Object.const_set("poil", Module.new)
    new_atome(atome_name, &atome_proc)


  end

  def auto_render_generator(element)
    Universe.renderer_list.each do |render_engine|
      build_render("#{render_engine}_#{element}")
    end
  end

  def build_render(renderer_name, &method_proc)
    # puts "==== >#{renderer_name}"

    # if renderer_name.start_with?(:html)
    #   puts "second condition to remove with finish : #{renderer_name}"
    #
    #   puts Universe.atome_list
    # else
      new_render_engine(renderer_name, &method_proc)
    # end

  end

  def build_sanitizer(method_name, &method_proc)
    Universe.add_sanitizer_method(method_name.to_sym, &method_proc)
  end

  def build_option(method_name, &method_proc)
    Universe.add_optional_method(method_name.to_sym, &method_proc)
  end
end

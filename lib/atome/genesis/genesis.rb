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
  def build_particle(particle_name,options={},&particle_proc)
    type = options[:type]
    type = :string if options[:type].nil?
    store = options[:store]
    store = true if options[:store].nil?
    render = options[:render]
    render = true if options[:render].nil?

    # we add the new method to the particle's collection of methods
    Universe.add_to_particle_list(particle_name, type)
    auto_render_generator(particle_name) if render #  automatise the creation of an empty render method for current particle
    new_particle(particle_name,store,render , &particle_proc)
    additional_particle_methods(particle_name, &particle_proc) # create alternative methods such as create 'method='
  end


  def build_atome(atome_name, &atome_proc)
    # we add the new method to the atome's collection of methods
    Universe.add_to_atome_list(atome_name)
    auto_render_generator(atome_name)
    new_atome(atome_name, &atome_proc)
  end

  def auto_render_generator(element)
    Universe.renderer_list.each do |render_engine|
      build_render("#{render_engine}_#{element}")
    end
  end

  def build_render(renderer_name, &method_proc)
    new_render_engine(renderer_name, &method_proc)
  end

  def build_sanitizer(method_name, &method_proc)
    Universe.add_sanitizer_method(method_name.to_sym, &method_proc)
  end

  def build_option(method_name, &method_proc)
    Universe.add_optional_method(method_name.to_sym, &method_proc)
  end
end

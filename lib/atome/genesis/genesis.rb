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
  def build_particle(particle_name, &particle_proc)
    # we add the new method to the particle's collection of methods
    Universe.add_to_particle_list(particle_name)
    auto_render_generator(particle_name)
    new_particle(particle_name, &particle_proc)
    additional_particle_methods(particle_name, &particle_proc)
  end

  def build_atome(atome_name, &atome_proc)
    # we add the new method to the atome's collection of methods
    Universe.add_to_atome_list(atome_name)
    auto_render_generator(atome_name)
    new_atome(atome_name, &atome_proc)
  end

  def auto_render_generator(element)
    Universe.renderer_list.each do |render_engine|
      build_render_method("#{render_engine}_#{element}")
    end
  end

  def build_render_method(renderer_name, &method_proc)
    new_render_engine(renderer_name, &method_proc)
  end

  def build_optional_methods(method_name, &method_proc)
    Universe.add_optionals_methods(method_name.to_sym, &method_proc)
  end
end

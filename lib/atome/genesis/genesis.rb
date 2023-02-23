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
    auto_render_generator(particle_name) if render
    new_particle(particle_name, store, render, &particle_proc)
    # the line below create all alternatives methods such as create 'method='
    additional_particle_methods(particle_name, store, render, &particle_proc)
  end

  # def create_atome(new_atome)
  #   puts "=> new_atome is : #{new_atome}"
  #   Atome.define_method "set_#{new_atome}" do |params, &user_proc|
  #     # we add the newly created atome to the list of "child in it's category, eg if it's a shape we add the new atome
  #     # to the shape particles list : @atome[:shape] << params[:id]
  #     # puts "the problem is below, self: #{id},\n #{new_atome},\nwe need to be sto store new atome's id : #{params}"
  #     puts "we now create anew atome\nthe problem is below : #{atome[:color]}"
  #     # @atome[:color] ||= []
  #     # @atome[:color] << params[:id]
  #     # self.send(new_atome, params, &user_proc)
  #     Atome.new({ new_atome => params }, &user_proc)
  #   end
  # end

  def build_atome(atome_name, &atome_proc)
    # we add the new method to the atome's collection of methods
    Universe.add_to_atome_list(atome_name)
    unless Essentials.default_params[atome_name]
      # if it doesn't exist
      # we create default params for the new created atome, adding the hash to : module essential, @default_params
      Essentials.new_default_params(atome_name => { type: atome_name, children: [], parents: [:view] })
    end

    # the line below create an empty atome method for each renderer, eg: browser_shape, headless_color, ...
    auto_render_generator(atome_name)
    # create_atome(atome_name)
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

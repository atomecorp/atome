# frozen_string_literal: true

# rendering engine below
class Photons
  def x_opal(params)
    params
  end

  def color_opal(params)
    params
  end
end

# use to sanitize and secure user input
module Sanitizer
  @default_params = {
    color: { type: :color, x: 0, y: 0, z: 0, red: 0.6, green: 0.6, blue: 0.6, alpha: 1, diffusion: :linear },
    box: { type: :shape, width: 100, height: 100, x: 100, y: 100,
           color: { x: 0, y: 0, z: 0, red: 0.9, green: 0.9, blue: 0.9, alpha: 1, diffusion: :linear },
           generator: :box, preset: :box },
    shape: { type: :shape, width: 100, height: 100, x: 100, y: 100,
             color: { type: :color, x: 0, y: 0, z: 0, red: 0.9, green: 0.9, blue: 0.9, alpha: 1, diffusion: :linear },
             generator: :manual },
    drm: { type: :drm },
    shadow: { type: :effect }
  }

  def self.default_params
    @default_params
  end

  def security_check(property)
    if @drm[property]
      #  drm found we find out if we are allow to access this property
      true if (@drm[property][:write] & [Atome.current_user, :me]).any?
    else
      # no drm specified for this property
      true
    end
  end

  def validation(property, value)
    allow = false
    if property == :drm
      allow = true if (value[:authorisation][:write] & [Atome.current_user, :me]).any?
      @drm = value
    else
      allow = security_check(property)
    end
    allow
  end

  def atomisation(property, value)
    pre_render_engine = Genesis.get_atome_helper("#{property}_render_pre_proc".to_sym)
    instance_exec('render_pre_proc_options_passed', &pre_render_engine) if pre_render_engine.is_a?(Proc)
    renderer(property, value)
    post_render_engine = Genesis.get_atome_helper("#{property}_render_post_proc".to_sym)
    instance_exec('render_post_proc_options_passed', &post_render_engine) if post_render_engine.is_a?(Proc)
    broadcaster(property, value)
    particularize(property, value)
    historize(property, value)
  end

  def add_essential_properties(params)
    # TO_DO: postpone dna and set it thru a thread to avoid slowing the whole atome creation process
    essential_properties = { id: Atome.identity(self),
                             dna: { creator: Atome.current_user, date: Time.now, software: 987_986,
                                    location: :location }, parent: :view, render: { opal: true }, type: :particle }
    params = essential_properties.merge(params)
    specific_properties = Sanitizer.default_params[params[:type]]
    params = essential_properties.merge(specific_properties).merge(params) if specific_properties
    drm_generated = { drm: add_essential_drm(params) }
    drm_generated.merge(params)
  end

  def add_essential_drm(params)
    essential_drm = { authorisation: { read: [Atome.current_user], write: [Atome.current_user] },
                      atome: { read: [:all], write: [:me] } }
    params[:drm] = if params[:drm]
                     essential_drm.merge(params[:drm])
                   else
                     essential_drm
                   end
  end

  def atome_stack(params)
    # if the creator work for a company the company  the right will be as below
    # using authorisation : :me is the current user and is the one that run the app,
    # the Atome.current_user id a specific user
    # TO_DO  "--------- first we have to create an atome from '#{atome_name}' then we'll attach  '#{params}'
    # if they are atome, else just send to the renderer ---------"
    params = add_essential_properties(params)
    params[:parent] = id
    atomes << Atome.new(params)
    # TO_DO: dont forget to add the current atome as the parent for the new atome
    # TO_DO: reorder particle now
    # TO_DO: recursive test to check there no atome within the params
  end

  def particle_stack(particle_name, value)
    particularize(particle_name, value)
    # if the creator work for a company the company  the right will be as below
    # using authorisation : :me is the current user and is the one that run the app,
    # the Atome.current_user id a specific user
    # TO_DO  "--------- first we have to create an atome from '#{atome_name}' then we'll attach  '#{params}'
    # if they are atome, else just send to the renderer ---------"
    # FIX_ME: find a better solution for DRM
  end
end

# basic atome operations
module Utilities
  def length
    @content.length
  end

  def each(&proc)
    @content.each do |atome|
      atome.instance_exec(&proc) if proc.is_a?(Proc)
    end
  end

  def range_handling(range, &proc)
    if @content[range].instance_of?(Atome)
      @content[range]
    else
      Quark.new(@content[range], &proc)
    end
  end

  def [](range, &proc)
    if @content[range].instance_of? Array
      @content[range].each do |atome|
        atome.instance_exec(&proc) if proc.is_a?(Proc)
      end
    elsif proc.is_a?(Proc)
      @content[range].instance_exec(&proc)
    end
    range_handling(range, &proc)
  end

  def last
    @content.last
  end

  def first
    @content[0]
  end

  def all(&proc)
    range_handling(0..@content.length, &proc)
  end

  def grab(atome_id)
    all_descendant = @children.content.concat @content
    atome_found = nil
    all_descendant.each do |atome|
      atome_found = atome if atome_id.to_s == atome.id.to_s
    end
    atome_found
  end

  def to_s
    @values << @value
    @values.inspect
  end

  def value
    @value
  end

  def values
    @values
  end

  def <<(params)
    @values << params
  end

  # user must ensure all data are passed and correctly formatted
  def add(property, value)
    "#{property} #{value}"
  end

  def delete(params)
    params
  end

  def batch(atomes)
    atomes
  end

  def resurrect(params)
    params
  end

  def broadcaster(property, value)
    "#{property} #{value}"
  end
end

# used to store and retrieve atome optional methods
module Genesis
  def self.set_atome_helper(property_name, &proc)
    @optionals_methods ||= {}
    @optionals_methods[property_name] = proc
  end

  def self.get_atome_helper(method_name)
    @optionals_methods[method_name]
  end

  def self.new_atome_helper(property_name, &proc)
    Genesis.set_atome_helper(property_name, &proc)
  end

  def self.method_equal(method_name)
    method_name
  end

  def self.pluralized(method_name)
    Object.define_method method_name do |params = nil|
      params
      # call the singular method above for each values found
    end
  end

  def self.create_alternates_methods(atome_name)
    method_equal(atome_name)
    pluralized("#{atome_name}s")
  end

  def get_atome(atome_name)
    # TO_DO: add security check for read method here
    getter_stack(instance_variable_get("@#{atome_name}"))
    property_searched = Atome.new
    @value[:atomes].each do |atome|
      property_searched << atome if atome.value[:type] == atome_name
    end
    property_searched
  end

  def self.new_molecule(atome_name, &proc)
    Object.define_method atome_name do |params = nil|
      params = Sanitizer.default_params[atome_name].merge(params)
      Atome.new.instance_exec(params, &proc) if proc.is_a?(Proc)
    end
  end

  def self.new_atome(atome_name, &proc)
    # TO_DO: we just have to pass the atome to attach it to the parent'
    Object.define_method atome_name do |params = nil|
      instance_exec({ options: :options }, &proc) if proc.is_a?(Proc)
      if params
        atome_stack(params)
      else
        get_atome(atome_name)
      end
    end
    create_alternates_methods(atome_name)
  end

  def self.new_particle(particle_name, &proc)
    # TO_DO: "we don't have to pass the atome just add the the atome hash "
    Object.define_method particle_name do |params = nil|
      instance_exec({ options: :options }, &proc) if proc.is_a?(Proc)
      if params
        particle_stack(particle_name, params)
      else
        # TO_DO: add security check for read method here
        @value[particle_name]
      end
    end
  end
end

# main entry below
class Atome
  include Sanitizer
  include Utilities
  include Genesis

  def atomes(params)
    @atomes = params
  end

  def self.current_user
    @user = :jeezs
  end

  def initialize(params = {})
    params.each do |property, value|
      atomisation(property, value)
    end
  end

  def self.identity(_atome)
    @number_of_temp_object = 0 if @number_of_temp_object.instance_of?(NilClass)
    @number_of_temp_object += 1
  end

  def particularize(property, value)
    @value[property] = value
  end

  def historize(property, value)
    "#{property} #{value} "
  end

  def renderer(property, value)
    "rendering : #{property} with value : #{value} engine: "
  end

  def getter_stack(instance_content)
    instance_content
  end
end

# use to batch range
class Quark
  def initialize(params = [])
    @params = params
  end

  private

  def global(params = nil)
    @params.each do |param|
      param.send(:top, params)
    end
  end

  def respond_to_missing?(method_name, include_private = false); end

  def getter_method(name)
    values = []
    @params.each do |atome|
      values << atome.send(name)
    end
    values
  end

  def method_missing(name, *args)
    if args[0]
      @params.each do |param|
        param.send(name, args[0])
      end
    else
      getter_method(name)
    end
  end

  def to_s
    @params.to_s
  end
end

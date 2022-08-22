# frozen_string_literal: true

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

  # def security_check(property)
  #   if @drm[property]
  #     #  drm found we find out if we are allow to access this property
  #     true if (@drm[property][:write] & [Atome.current_user, :me]).any?
  #   else
  #     # no drm specified for this property
  #     true
  #   end
  # end

  def validation(property, value)
    # allow = false
    # if property == :drm
    #   allow = true if (value[:authorisation][:write] & [Atome.current_user, :me]).any?
    #   @drm = value
    # else
    #   allow = security_check(property)
    # end
    # allow
    atomisation(property, value)
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

  def atome_stack(atome_name, params)
    puts "atome_name is : #{atome_name}"
    # if the creator work for a company the company  the right will be as below
    # using authorisation : :me is the current user and is the one that run the app,
    # the Atome.current_user id a specific user
    # TO_DO  "--------- first we have to create an atome from '#{atome_name}' then we'll attach  '#{params}'
    # if they are atome, else just send to the renderer ---------"
    params = add_essential_properties(params)
    params[:parent] = id
    Atome.new(params)
    # instance_variable_set("@#{atome_name}", Atome.new(params))
    # TO_DO: dont forget to add the current atome as the parent for the new atome
    # TO_DO: reorder particle now
    # TO_DO: recursive test to check there no atome within the params
  end

  def particle_stack(particle_name, value)
    puts "particle_stack : #{particle_name}:  #{value}"
    # particularize(particle_name, value)
    # if the creator work for a company the company  the right will be as below
    # using authorisation : :me is the current user and is the one that run the app,
    # the Atome.current_user id a specific user
    # TO_DO  "--------- first we have to create an atome from '#{atome_name}' then we'll attach  '#{params}'
    # if they are atome, else just send to the renderer ---------"
    # FIX_ME: find a better solution for DRM
  end
end

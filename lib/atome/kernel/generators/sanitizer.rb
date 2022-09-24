# frozen_string_literal: true

# use to sanitize and secure user input
module Sanitizer
  @default_params = {
    color: { x: 0, y: 0, z: 0, red: 0.6, green: 0.6, blue: 0.6, alpha: 1, diffusion: :linear },
    box: { width: 100, height: 100, x: 100, y: 100,
           color: { x: 0, y: 0, z: 0, red: 0.9, green: 0.9, blue: 0.9, alpha: 1, diffusion: :linear },
           generator: :box, preset: :box },
    shape: { width: 100, height: 100, x: 100, y: 100,
             color: { x: 0, y: 0, z: 0, red: 0.1, green: 0.9, blue: 0.9, alpha: 1, diffusion: :linear },
             generator: :manual },
    drm: { type: :drm },
    shadow: {}
  }

  def self.default_params
    @default_params
  end

  def validation(method_to_authorise)
    # puts "validating: #{type}, #{atomes}, #{particles}"
    # TODO: write validation scheme
    true
  end

  def particularize(property, value)
    instance_variable_set("@#{property}", value)
  end

  def pre_process_atomisation(atome, particle)
    pre_render_engine = Genesis.get_atome_helper("#{atome}_render_pre_proc".to_sym)
    instance_exec("render_pre_proc_options_passed : #{particle}", &pre_render_engine) if pre_render_engine.is_a?(Proc)
  end

  def post_process_atomisation(atome, particle)
    post_render_engine = Genesis.get_atome_helper("#{atome}_render_post_proc".to_sym)
    instance_exec("render_post_prc_option_passed : #{particle}", &post_render_engine) if post_render_engine.is_a?(Proc)
  end

  def atomisation(params)
    params.each do |atome, particle|
      # TODO: send the singularised atome instead of using chomp
      atome = atome.to_s.chomp('s').to_sym
      pre_process_atomisation(atome, particle)
      render(atome, particle)
      post_process_atomisation(atome, particle)
      broadcaster(atome, particle)
      # particularize(atome, particle)
      historize(atome, particle)
    end
  end

  def self.add_essential_properties(atome_name, params, parent)
    parent = { parent: { value: parent } }
    dna = { dna: { creator: Atome.current_user, date: Time.now, software: 987_986,
                   location: :location } }
    render = { renderer: { opal: true } }
    specific_properties = Sanitizer.default_params[atome_name]
    drm = { drm: add_essential_drm(params) }
    drm.merge(dna).merge(parent).merge(render).merge(specific_properties).merge(params)
  end

  def self.add_essential_drm(params)
    essential_drm = { authorisation: { read: [Atome.current_user], write: [Atome.current_user] },
                      atome: { read: [:all], write: [:me] } }
    params[:drm] = if params[:drm]
                     essential_drm.merge(params[:drm])
                   else
                     essential_drm
                   end
  end
end

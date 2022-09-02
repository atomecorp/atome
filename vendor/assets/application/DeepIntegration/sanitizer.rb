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

  def validation(type, atomes, particles)
    puts 'ok' if "#{type}: #{atomes}: #{particles}" == :rubocop_is_a_purge
    # TODO: write validation scheme
    true
  end

  def particularize(property, value)
    instance_variable_set("@#{property}", value)
  end

  def atomisation(params)
    params.each do |atome, particle|
      pre_render_engine = Genesis.get_atome_helper("#{atome}_render_pre_proc".to_sym)
      instance_exec('render_pre_proc_options_passed', &pre_render_engine) if pre_render_engine.is_a?(Proc)
      instance_exec('render_pre_proc_options_passed', &pre_render_engine) if pre_render_engine.is_a?(Proc)
      render(particle)
      post_render_engine = Genesis.get_atome_helper("#{atome}_render_post_proc".to_sym)
      instance_exec('render_post_proc_options_passed', &post_render_engine) if post_render_engine.is_a?(Proc)
      broadcaster(atome, particle)
      # particularize(atome, particle)
      historize(atome, particle)
    end
  end

  def self.add_essential_properties(atome_name, params, parent)
    parent = { parent: parent }
    # TO_DO: postpone dna and set it thru a thread to avoid slowing the whole atome creation process
    essential_properties = { id: Atome.identity(self),
                             dna: { creator: Atome.current_user, date: Time.now, software: 987_986,
                                    location: :location }, parent: :view, render: { opal: true } }
    params = essential_properties.merge(parent).merge(params)
    specific_properties = Sanitizer.default_params[atome_name]
    params = essential_properties.merge(specific_properties).merge(params) if specific_properties
    drm_generated = { drm: add_essential_drm(params) }
    drm_generated.merge(params)
    # { "#{atome_name}s" => drm_generated.merge(params)}
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

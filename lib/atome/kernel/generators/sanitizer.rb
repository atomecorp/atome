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

  def validation(atome_instance_var)
    # TODO: write validation scheme
    true if atome_instance_var
  end

  def sanitizer(params)
    # TODO: write sanitizer scheme
    params
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

  def add_missing_id(atome_type, params)
    type = params[:type] || atome_type
    params[:id] = "#{type}_#{Universe.atomes.length}"
  end

  def add_essential_properties(atome_type, params)
    # FIXME : inject this in async mode to avoid big lag!
    @dna = "#{Atome.current_user}_#{Universe.app_identity}_#{Universe.atomes.length}"
    # params[:parent] = :view unless params[:parent]
    params[:drm] = add_essential_drm(params) unless params[:drm]
    add_missing_id(atome_type, params) unless params[:id]
    render = Genesis.default_value[:render]
    params[:render] = render unless params[:render]
    params
  end

end

# frozen_string_literal: true

# use to sanitize and secure user input
module Sanitizer
  @default_params = {
    render: [:html],
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
    # we reorder id and place it a the beginning of the hash before render
    # id_found = params.delete(:id)
    # params = { id: id_found }.merge(params)

    # we reorder render and place it a the beginning of the hash
    # render_found = params.delete(:render)
    # { render: render_found }.merge(params)
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

  def check_parent(params)
    parent = [id]|| [:user_view]
    params[:parent] = parent unless params[:parent]
    params
  end

  def add_missing_id(atome_type, params)
    type = params[:type] || atome_type
    "#{type}_#{Universe.atomes.length}"
  end

  def add_essential_properties(atome_type, params)
    # params_to_sanitize={atome: self, params: params}
    params=Genesis.run_optional_methods_helper("#{atome_type}_sanitizer_proc".to_sym, params, self)
      # TODO remove the condition below once the line above works
      params[:id] = add_missing_id(atome_type, params) unless params[:id]
      # FIXME : inject this in async mode to avoid big lag!
      params[:drm] = add_essential_drm(params) unless params[:drm]
      # forcing default render can causes problems and crashes
      # render= Sanitizer.default_params[:render]
      params[:render] = render unless params[:render]
      check_parent(params)

  end
end

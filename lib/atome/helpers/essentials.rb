# frozen_string_literal: true

# use to sanitize and secure user input
module Essentials
  @default_params = {
    render_engines: [:browser],
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

  def self.new_default_params(new_default)
    @default_params.merge!(new_default)
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
end

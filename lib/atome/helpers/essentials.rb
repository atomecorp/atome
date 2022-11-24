# frozen_string_literal: true

# use to sanitize and secure user input
module Essentials
  @default_params = {
    render_engines: [:browser],
    element: { type: :element, renderers: [] },
    box: { renderers: '', id: '', type: :shape, parents: [], children: [], width: 99, height: 99, left: 12, top: 12 },
    circle: { renderers: '', id: '', type: :shape, parents: [], children: [], width: 99, height: 99, left: 12, top: 12,
              smooth: '100%' },
    shape: { renderers: '', id: '', width: 100, type: :shape, height: 100, left: 100, top: 100,
             color: { left: 0, top: 0, z: 0, red: 0.1, green: 0.9, blue: 0.9, alpha: 1, diffusion: :linear },
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

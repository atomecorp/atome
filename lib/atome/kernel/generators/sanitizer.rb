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

  def add_missing(params)
    new_params = if params.instance_of? Hash
                   [params = drms(params).merge(params)]
                 else
                   params
                 end
    # new_params.each do |param|
    #   param[:render] = render unless param[:render]
    # end
    render = Genesis.default_value[:render]
    # new_params={render: render}.merge(new_params)
    # puts new_params
    params
  end

  def particularize(property, value)
    instance_variable_set("@#{property}", value)
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

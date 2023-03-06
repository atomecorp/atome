# frozen_string_literal: true

# use to sanitize and secure user input
module Essentials
  @default_params = {
    render_engines: [:browser],
    collector: { type: :element, parents: [:black_matter] },
    animation: { type: :animation, parents: [:black_matter], attach: [] },
    element: { type: :element, renderers: [], parents: [:black_matter], attach: [:black_matter] },
    matrix: { type: :shape, width: 99, height: 99,
              attached: :matrix_color,
              left: 100, top: 100, clones: [], preset: :matrix, parents: [:view] },
    box: { type: :shape, width: 99, height: 99,
           attached: :box_color, parents: [:view],
           left: 100, top: 100, clones: [], preset: :box },
    circle: { type: :shape, width: 99, height: 99, smooth: '100%',
              attached: :circle_color, parents: [:view],
              left: 100, top: 100, clones: [], preset: :circle },
    shape: { type: :shape, width: 99, height: 99,
             attached: :shape_color, parents: [:view],
             left: 100, top: 100, clones: [] },
    text: { type: :text, visual: { size: 25 },
            attached: :text_color, parents: [:view],
            data: 'this is a text sample', width: 199, height: 33, clones: [] },
    drm: { type: :drm, parents: [:black_matter] },
    shadow: { parents: [:black_matter] },
    color: { parents: [:black_matter], red: 0, green: 0, blue: 0, alpha: 1  }
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

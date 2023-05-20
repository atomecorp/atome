# frozen_string_literal: true

# use to sanitize and secure user input
module Essentials
  @default_params = {
    # Warning :  type must be define first
    render_engines: [:browser],
    # collector: { type: :element, attach: [:black_matter] },
    image: { type: :image, attach: [:view] },
    web: { type: :web, attach: [:view] },
    video: { type: :video, attach: [:view] },
    animation: { type: :animation,  attach: [:black_matter] },
    element: { type: :element, renderers: [], attach: [:black_matter] },
    matrix: { type: :shape, width: 99, height: 99,
              attached: :matrix_color,
              left: 100, top: 100, clones: [], preset: :matrix, attach: [:view] },
    box: { type: :shape, width: 99, height: 99,
           attached: :box_color, attach: [:view],
           left: 100, top: 100, clones: [], preset: :box },
    vector: { type: :shape, width: 99, height: 99,
           attach: [:view],
           left: 100, top: 100, clones: [], preset: :vector },
    circle: { type: :shape, width: 99, height: 99, smooth: '100%',
              attached: :circle_color, attach: [:view],
              left: 100, top: 100, clones: [], preset: :circle },
    shape: { type: :shape, width: 99, height: 99,
             attached: :shape_color, attach: [:view],
             left: 100, top: 100, clones: [] },
    text: { type: :text, visual: { size: 25 },
            attached: :text_color, attach: [:view],
            data: 'this is a text sample', width: 199, height: 33, clones: [] },
    drm: { type: :drm, attach: [:black_matter] },
    shadow: { type: :shadow, attach: [:black_matter] },
    color: {  type: :color,attach: [:black_matter], red: 0, green: 0, blue: 0, alpha: 1  }
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

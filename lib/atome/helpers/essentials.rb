# frozen_string_literal: true

# use to sanitize and secure user input
module Essentials
  corp = <<~STR
    <g transform="matrix(0.0267056,0,0,0.0267056,18.6376,20.2376)">
        <g id="shapePath1" transform="matrix(4.16667,0,0,4.16667,-377.307,105.632)">
            <path d="M629.175,81.832C740.508,190.188 742.921,368.28 634.565,479.613C526.209,590.945 348.116,593.358 236.784,485.002C125.451,376.646 123.038,198.554 231.394,87.221C339.75,-24.111 517.843,-26.524 629.175,81.832Z" style="fill:rgb(201,12,125);"/>
        </g>
        <g id="shapePath2" transform="matrix(4.16667,0,0,4.16667,-377.307,105.632)">
            <path d="M1679.33,410.731C1503.98,413.882 1402.52,565.418 1402.72,691.803C1402.91,818.107 1486.13,846.234 1498.35,1056.78C1501.76,1313.32 1173.12,1490.47 987.025,1492.89C257.861,1502.39 73.275,904.061 71.639,735.381C70.841,653.675 1.164,647.648 2.788,737.449C12.787,1291.4 456.109,1712.79 989.247,1706.24C1570.67,1699.09 1982.31,1234 1965.76,683.236C1961.3,534.95 1835.31,407.931 1679.33,410.731Z" style="fill:rgb(201,12,125);"/>
        </g>
    </g>
  STR

  @default_params = {
    # Warning :  type must be define first
    render_engines: [:html],
    image: { type: :image, attached: [] },
    # FIXME : look at build_atome FIXME to resolve default parent attachment problem
    video: { type: :video, attached: [] },
    animation: { type: :animation, attach: [:black_matter], attached: [] },
    element: { type: :element, renderers: [], attach: [:black_matter], attached: [] },
    # matrix: { type: :shape, width: 99, height: 99,
    #           apply: [:matrix_color],
    #           left: 100, top: 100, clones: [], preset: :matrix },
    box: { type: :shape, width: 99, height: 99,
           apply: [:box_color],
           left: 100, top: 100, clones: [], preset: :box },
    vector: { type: :shape, width: 99, height: 99,
              attached: [],
              left: 100, top: 100, clones: [], preset: :vector, definition: corp },
    circle: { type: :shape, width: 99, height: 99, smooth: '100%',
              apply: [:circle_color],
              left: 100, top: 100, clones: [], preset: :circle },
    shape: { type: :shape, width: 99, height: 99,
             apply: [:shape_color],
             left: 100, top: 100, clones: [] },
    text: { type: :text, component: { size: 66 },
            apply: [:text_color],
            width: :auto, height: :auto, clones: [] },
    drm: { type: :drm, attach: [:black_matter], attached: [] },
    shadow: { type: :shadow, attach: [:black_matter], attached: [] },
    color: { type: :color, attach: [], red: 0, green: 0, blue: 0, alpha: 1, attached: [] }
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

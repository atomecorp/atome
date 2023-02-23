# frozen_string_literal: true

# use to sanitize and secure user input
module Essentials
  @default_params = {
    render_engines: [:browser],
    collector: { type: :element, renderers: [], children: [], parents: [:black_matter] },
    animation: { type: :animation, children: [] , parents: [:black_matter]},
    element: { type: :element, renderers: [], children: [] , parents: [:black_matter]},
    matrix: { renderers: [], id: '', type: :shape, width: 99, height: 99,
              attached: [:matrix_color], children: [],
              left: 100, top: 100, clones: [], preset: :matrix, parents: [:view] },
    box: { renderers: [], id: '', type: :shape,  width: 99, height: 99,
           attached: [:box_color], children: [], parents: [:view],
           left: 100, top: 100, clones: [], preset: :box },
    circle: { renderers: [], id: '', type: :shape,  width: 99, height: 99, smooth: '100%',
              attached: [:circle_color], children: [], parents: [:view],
              left: 100, top: 100, clones: [], preset: :circle },
    shape: { renderers: [], id: '', type: :shape,  width: 99, height: 99,poil: :poilu,
             attached: [:shape_color], children: [], parents: [:view],
             left: 100, top: 100, clones: [] },
    text: { renderers: [], id: '', type: :text, visual: { size: 25 },
            attached: [:text_color], children: [], parents: [:view],
            data: 'this is a text sample', width: 199, height: 33, clones: [] },
    drm: { type: :drm,parents: [:black_matter] },
    shadow: {parents: [:black_matter]},
    color: {parents: [:black_matter]}
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

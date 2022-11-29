# frozen_string_literal: true

generator = Genesis.generator

generator.build_atome(:animation)

generator.build_render_method(:browser_animation) do |_value, _user_proc|
  @browser_type = :web
end

generator.build_particle(:start)
generator.build_particle(:end)

class Atome

  def animation(params = {}, &bloc)
    default_renderer = Essentials.default_params[:render_engines]
    atome_type = :animation
    generated_render = params[:renderers] || default_renderer
    generated_id = params[:id] || "#{atome_type}_#{Universe.atomes.length}"
    generated_parents = params[:parents] || []
    params = atome_common(atome_type, generated_id, generated_render, generated_parents, params)
    Atome.new({ atome_type => params }, &bloc)
  end

end

def animation(params = {}, &proc)
  grab(:view).animation(params, &proc)
end

# b = box({ id: :my_box })
# a = Atome.new(animation: { renderers: [:browser], id: :the_animation1, type: :animation, children: [] })
a = animation({
                children: [:my_box],
                start: {
                  left: 33,


                },
                end: {

                }
              })



# frozen_string_literal: true

# atome sanitizer
class Atome
  private

  def create_color_hash(params)
    rgb_color = Color::CSS[params].css_rgb
    split_data = rgb_color.sub('rgb(', '').sub(')', '').gsub(',', '').split('%')
    { red: split_data[0].to_f / 100, green: split_data[1].to_f / 100, blue: split_data[2].to_f / 100 }
  end

  def found_parents_and_renderers
    if @atome
      parent_found = [@atome[:id]]
      render_found = @atome[:renderers]
    else
      parent_found = []
      render_found = Essentials.default_params[:render_engines]
    end
    { parent: parent_found, renderers: render_found }
  end

  generator = Genesis.generator

  generator.build_sanitizer(:color) do |params|
    parent_found = found_parents_and_renderers[:parent]
    render_found = found_parents_and_renderers[:renderers]
    default_params = { renderers: render_found, id: "color_#{Universe.atomes.length}", type: :color,
                       parents: parent_found,
                       red: 0, green: 0, blue: 0, alpha: 1 }
    params = create_color_hash(params) unless params.instance_of? Hash
    default_params.merge!(params)
  end

  generator.build_sanitizer(:element) do |params|
    parent_found = found_parents_and_renderers[:parent]
    render_found = []
    default_params = { renderers: render_found, id: "element_#{Universe.atomes.length}", type: :element,
                       parents: parent_found }
    default_params.merge!(params)
  end

  generator.build_sanitizer(:id) do |params|
    if @atome[:id] != params
      Universe.update_atome_id(params, self, @atome[:id])
    else
      Universe.add_to_atomes(params, self)
    end
    params
  end
end

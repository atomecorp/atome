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
end

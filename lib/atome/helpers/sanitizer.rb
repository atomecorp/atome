# frozen_string_literal: true

# atome sanitizer
class Atome
  def create_color_hash(params)
    rgb_color = Color::CSS[params].css_rgb
    spited = rgb_color.sub('rgb(', '').sub(')', '').gsub(',', '').split('%')
    { red: spited[0].to_f / 100, green: spited[1].to_f / 100, blue: spited[2].to_f / 100 }
  end

  def sanitize_color(params)
    default_params = { parents: [@atome[:id]], type: :color, render: @atome[:render],
                       id: "color_#{Universe.atomes.length}", red: 0, green: 0, blue: 0, alpha: 1 }
    params = create_color_hash(params) unless params.instance_of? Hash
    default_params.merge(params)
  end
end

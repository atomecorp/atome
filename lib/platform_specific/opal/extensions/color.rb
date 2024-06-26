# frozen_string_literal: true

# rgb utility
class Atome
  def rgb_html(string)
    js_code = <<-JS
  var col = w3color('#{string}');
  var rgb_col = col.toRgb();
  return rgb_col;
    JS

    JS.eval(js_code)
  end

  def to_rgb(string)
    rgb_color = rgb_html(string)

    {
      red: rgb_color[:r] / 255,
      green: rgb_color[:g] / 255,
      blue: rgb_color[:b] / 255,
      alpha: 1
    }
  end
end

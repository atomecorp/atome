# frozen_string_literal: true

# used for styles
class Vie
  # styles

  shadow({
           id: :standard_shadow,
           left: 3, top: 3, blur: 6,
           invert: false,
           red: 0, green: 0, blue: 0, alpha: 0.3
         })
  shadow({
           id: :invert_shadow,
           left: 3, top: 3, blur: 16,
           invert: true,
           red: 0, green: 0, blue: 0, alpha: 0.6
         })

  def vie_size
    {
      icon: 15,
      tool_size: 25,
      buttons: 25,
      basic: 19,
      title_width: 50,
      title_height: 30,
      separator_size: 10,
      basic_size: 25,
      basic_width: 39,
      basic_height: 39,
      margin: 6,
      matrix_min: 192
    }
  end

  def vie_colors
    {
      tool_support: { red: 0.16, green: 0.16, blue: 0.16, alpha: 1 },
      inactive_tool: { red: 0.5, green: 0.5, blue: 0.5, alpha: 1 },
      cells: { red: 0.6, green: 0.3, blue: 0.09, alpha: 1 },
      tool_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      title_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      work_zone: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      filer_bar: { red: 0.15, green: 0.15, blue: 0.15, alpha: 1 },
      inspector: { red: 0.156, green: 0.156, blue: 0.156, alpha: 1 },
      titles: { red: 0.6, green: 0.6, blue: 0.6, alpha: 1 }
    }
  end

  def vie_style_universal
    {
      title_bar: { depth: 1, height: vie_size[:basic_size],
                   width: '100%' },
      filer_bar: { depth: 1,
                   width: vie_size[:basic_size] * 3, height: vie_size[:basic_size], left: 0, top: vie_size[:margin],
                   bottom: vie_size[:margin] },
      tool_bar: { depth: 1, height: vie_size[:basic_size], width: :auto, left: vie_size[:margin], right: vie_size[:margin],
                  top: :auto, bottom: vie_size[:margin] },

      inspector: { depth: 2, overflow: :auto, width: :auto, height: 150, left: vie_size[:margin],
                   right: vie_size[:margin], top: :auto, bottom: vie_size[:basic_size] + vie_size[:margin] * 2,
      },
      work_zone: { overflow: :auto, depth: 0, width: :auto, height: :auto,
                   left: 0 + vie_size[:margin], top: vie_size[:basic_size] + vie_size[:margin],
                   bottom: vie_size[:basic_size] *5+vie_size[:margin]*6, right: vie_size[:margin] }
    }
  end

end

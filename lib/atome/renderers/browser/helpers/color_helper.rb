# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  def self.browser_colorize_color(red, green, blue, alpha, atome)
    ########################### new code ###########################
    id_found = atome[:id]
    # color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
    new_class_content = <<~STR
      .#{id_found} {
        --#{id_found}_r : #{red * 255};
        --#{id_found}_g : #{green * 255};
        --#{id_found}_b : #{blue * 255};
        --#{id_found}_a : #{alpha};
        --#{id_found}_col : rgba(var(--#{id_found}_r ),var(--#{id_found}_g ),var(--#{id_found}_b ),var(--#{id_found}_a ));
        background-color: var(--#{id_found}_col);
        fill:  var(--#{id_found}_col);
        stroke:  var(--#{id_found}_col);
      }
    STR

    atomic_style = BrowserHelper.browser_document['#atomic_style']
    # atomic_style.text = atomic_style.text.gsub(/\.#{id_found}\s*{.*?}/m, new_class_content)

    regex = /(\.#{id_found}\s*{)([\s\S]*?)(})/m
    atomic_style.text = atomic_style.text.gsub(regex, new_class_content)

    ########################### old code ###########################
    #
    #     puts  "the code below may be updated to work with the new class handler :\n\n#{color_updated}\n\n#{atome}"
    #     `
    # document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.backgroundColor = #{color_updated}
    # document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.fill = #{color_updated}
    # document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.stroke = #{color_updated}
    # `
    ########################### new old end ###########################

  end

  def self.browser_colorize_shadow(red, green, blue, alpha, atome)
    # "new shadow color is : #{color_updated}"
    # puts "=====> #{color_updated} : #{atome}"
    # TODO: check if we need to use variable for the color or let it like it is!
    left = atome[:left]
    top = atome[:top]
    blur = atome[:blur]
    direction = atome[:direction]

    # shadow_updated = "#{left}px #{top}px #{blur}px #{color_updated} #{direction}"
    # `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`

    # new code
    id_found = atome[:id]
    class_content = <<~STR
      .#{id_found} {
        --#{id_found}_r : #{red * 255};
        --#{id_found}_g : #{green * 255};
        --#{id_found}_b : #{blue * 255};
        --#{id_found}_a : #{alpha};
        --#{id_found}_col : rgba(var(--#{id_found}_r ),var(--#{id_found}_g ),var(--#{id_found}_b ),var(--#{id_found}_a ));
      
        box-shadow: #{left}px #{top}px #{blur}px var(--#{id_found}_col) #{direction};
      }
    STR

    atomic_style = BrowserHelper.browser_document['#atomic_style']
    # atomic_style.text = atomic_style.text.gsub(/\.#{id_found}\s*{.*?}/m, new_class_content)
    # puts new_class_content
    regex = /(\.#{id_found}\s*{)([\s\S]*?)(})/m
    atomic_style.text = atomic_style.text.gsub(regex, class_content)

    # .view_shadow_17 {
    # box-shadow: 3px 3px 3px  rgba(0,
    #   0,0,1)
    # }
  end

  def self.browser_left_color(_value, _browser_object, _atome)
    # puts 'code to write when implementing gradient'
  end

  def self.browser_right_color(_value, _browser_object, _atome)
    # puts 'code to write when implementing gradient'
  end

  def self.browser_top_color(_value, _browser_object, _atome)
    # puts 'code to write when implementing gradient'
  end

  def self.browser_bottom_color(_value, _browser_object, _atome)
    # puts 'code to write when implementing gradient'
  end
end

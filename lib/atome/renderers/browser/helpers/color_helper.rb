# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  def self.browser_colorize_color(color_updated, atome)
    ########################### new code ###########################
    id_found=atome[:id]
    new_class_content = <<STR
.#{id_found} {
  background-color: #{color_updated};
  fill: #{color_updated};
  stroke: #{color_updated};
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

  def self.browser_colorize_shadow(color_updated, atome)
    "new shadow color is : #{color_updated}"
    puts "=====> #{color_updated} : #{atome}"
    left = atome[:left]
    top = atome[:top]
    blur = atome[:blur]
    direction = atome[:direction]
    # shadow_updated = "#{left}px #{top}px #{blur}px #{color_updated} #{direction}"
    # `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`

    #new code
    id_found= atome[:id]
    class_content = <<STR
.#{id_found} {
  box-shadow: #{left}px #{top}px #{blur}px #{color_updated} #{direction};
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

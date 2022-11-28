# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  def self.browser_blur_style(_browser_object, value, atome)
    b_left = "#{atome[:left]}px"
    b_top = "#{atome[:top]}px"
    b_blur = "#{atome[:blur] = value}px"
    b_red = atome[:red] * 255
    b_green = atome[:green] * 255
    b_blue = (atome[:blue]) * 255
    b_direction = atome[:direction]
    b_alpha = atome[:alpha]

    shadow_updated = "#{b_left} #{b_top} #{b_blur} rgba(#{b_red}, #{b_green}, #{b_blue}, #{b_alpha}) #{b_direction}"
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
  end

  def self.browser_blur_div(browser_object, value, _atome)
    browser_object.style[:filter] = "blur(#{value}px)"
  end
end

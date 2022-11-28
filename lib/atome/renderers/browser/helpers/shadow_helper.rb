# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  # shadow
  def self.browser_left_shadow(value, _browser_object, atome)
    ls_left = "#{atome[:left] = value}px"
    ls_top = "#{atome[:top]}px"
    ls_blur = "#{atome[:blur]}px"
    red = atome[:red] * 255
    green = atome[:green] * 255
    blue = (atome[:blue]) * 255
    direction = atome[:direction]
    alpha = atome[:alpha]

    shadow_updated = "#{ls_left} #{ls_top} #{ls_blur} rgba(#{red}, #{green}, #{blue}, #{alpha}) #{direction}"
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
  end

  def self.browser_top_shadow(value, _browser_object, atome)
    rs_left = "#{atome[:left]}px"
    rs_top = "#{atome[:top] = value}px"
    rs_blur = "#{atome[:blur]}px"
    red = atome[:red] * 255
    green = atome[:green] * 255
    blue = (atome[:blue]) * 255
    direction = atome[:direction]
    alpha = atome[:alpha]

    shadow_updated = "#{rs_left}px #{rs_top}px #{rs_blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}) #{direction}"
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
  end
end

# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  def self.browser_colorize_color(color_updated, atome)
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.backgroundColor = #{color_updated}`
  end

  def self.browser_colorize_shadow(color_updated, atome)
    left = atome[:left]
    top = atome[:top]
    blur = atome[:blur]
    direction = atome[:direction]
    shadow_updated = "#{left}px #{top}px #{blur}px #{color_updated} #{direction}"
    `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
  end

  def self.browser_left_color(_value, _browser_object, _atome)
    puts 'code to write when implementing gradient'
  end

  def self.browser_right_color(_value, _browser_object, _atome)
    puts 'code to write when implementing gradient'
  end

  def self.browser_top_color(_value, _browser_object, _atome)
    puts 'code to write when implementing gradient'
  end

  def self.browser_bottom_color(_value, _browser_object, _atome)
    puts 'code to write when implementing gradient'
  end
end

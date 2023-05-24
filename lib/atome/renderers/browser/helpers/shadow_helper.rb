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
    id_found = atome[:id]
    real = atome[:real]
    # `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
    if real
      drop_shadow_updated = "drop-shadow(#{ls_left} #{ls_top} #{ls_blur} rgba(#{red}, #{green}, #{blue}, #{alpha}))"
      class_content = <<STR
.#{id_found} {

filter: #{drop_shadow_updated};
}
STR
    else
      shadow_updated = "#{ls_left} #{ls_top} #{ls_blur} rgba(#{red}, #{green}, #{blue}, #{alpha}) #{direction}"
      class_content = <<STR
.#{id_found} {
box-shadow: #{shadow_updated};
}
STR
    end

    atomic_style = BrowserHelper.browser_document['#atomic_style']

    return unless atomic_style

    if atomic_style.text.include?(".#{id_found}")
      # if the class exist , update it's content with the new class
      #  alert "before :#{atomic_style.text}"
      regex = /(\.#{id_found}\s*{)([\s\S]*?)(})/m
      atomic_style.text = atomic_style.text.gsub(regex, class_content)
      # alert "after :#{atomic_style.text}"
    else
      # if the class doesn't exist, add it to the end of the tag <style>
      atomic_style.text += class_content
    end

    # alert atomic_style.text
  end

  # .shadow2 {
  #   box-shadow: 3px 9px 9px rgba(0, 0, 0, 1) inset;
  # }
  # .shadow2 {
  # box-shadow: 3px 9px 9px rgba(0, 0, 0, 1) inset)
  # }

  def self.browser_top_shadow(value, _browser_object, atome)
    # rs_left = "#{atome[:left]}px"
    # rs_top = "#{atome[:top] = value}px"
    # rs_blur = "#{atome[:blur]}px"
    # red = atome[:red] * 255
    # green = atome[:green] * 255
    # blue = (atome[:blue]) * 255
    # direction = atome[:direction]
    # alpha = atome[:alpha]
    #
    # shadow_updated = "#{rs_left}px #{rs_top}px #{rs_blur}px rgba(#{red}, #{green}, #{blue}, #{alpha}) #{direction}"
    # `document.getElementById(#{atome[:id]}).sheet.cssRules[0].style.boxShadow = #{shadow_updated}`
    #
  end
end

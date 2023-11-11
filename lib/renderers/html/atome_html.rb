# frozen_string_literal: true

class Atome
  def html(obj = nil)
    if obj
      @html = obj
    else
      @html

    end
    # @html_object = HTML.new(id, self)
  end

  def to_px
    id_found = real_atome[:id]
    property_found = property
    value_get = ''
    `
 div = document.getElementById(#{id_found});
 var style = window.getComputedStyle(div);
 var original_value = style.getPropertyValue(#{property_found});
 #{value_get}= parseInt(original_value);
 `
    value_get
  end
end
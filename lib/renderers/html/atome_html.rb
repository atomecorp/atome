# frozen_string_literal: true

class Atome
  def html(obj = nil)
    if obj
      @html = obj
    else
      @html
    end
  end

    def descendant_of?(ancestor)
      HTML.is_descendant(ancestor, id)
    end

  def to_px(particle)
    ruby_wasm_code = <<-JS
  var div = document.getElementById("#{@id}");
  var style = window.getComputedStyle(div);
  var original_value = style.getPropertyValue("#{particle}");
  var parsed_value = parseInt(original_value);
  return parsed_value;
    JS
    JS.eval(ruby_wasm_code).to_f
  end

  def to_percent(property)
    parent = grab(attach)
    parent_width = parent.to_px(:width)
    parent_height = parent.to_px(:height)
    property_needed_px = to_px(property)
    case property
    when :width, :left
      "#{(property_needed_px / parent_width.to_f) * 100}%"
    when :height, :top
      "#{(property_needed_px / parent_height.to_f) * 100}%"
    else
      raise ArgumentError # unsupported property use left , top, width an height
    end
  end

end
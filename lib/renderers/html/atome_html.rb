# frozen_string_literal: true

class Atome
  def html(obj = nil)
    if obj
      @html = obj
    else
      @html
    end
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
end
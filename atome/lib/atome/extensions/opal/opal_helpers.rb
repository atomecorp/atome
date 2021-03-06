module JSUtils
  def jq_get(atome_id)
    Element.find("#" + atome_id)
  end

  def self.device
    `window`
  end

  def self.document
    `$(document)`
  end

  # helper to get text or any html element real size
  def self.client_height(atome_requested)
    `(document.getElementById(#{atome_requested}).clientHeight + 1)`
  end

  def self.client_width(atome_requested)
    `(document.getElementById(#{atome_requested}).clientWidth + 1)`
  end

  def self.fit_text_width(atome_id)
    `fitTextWidth(#{atome_id}) `
  end

  def self.fit_text_height(atome_id)
    `fitTextHeight(#{atome_id}) `
  end

  # helper to check if we have a tactile device
  def mobile?
    `atome.jsIsMobile()`
  end

  def self.load_opal_parser
    `$.getScript('js/dynamic_libraries/opal/opal_parser.js', function (data, textStatus, jqxhr) {#{@opal_parser = true}})`
    require "opal-parser"
  end

  def self.opal_parser_ready
    @opal_parser
  end

  def self.animator(params)
    $$.animator.animation(params)
  end

  def self.get_object_under_pointer(evt)
    ` atome.jsGet_items_under_pointer(#{evt.to_n})`
  end

  def self.ping(adress, error, success)
    `atome.jsPing(#{adress},#{success}, #{error})`
  end

end

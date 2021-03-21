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

  # helper to check if we have a tactile device
  def is_mobile
    `atome.jsIsMobile()`
  end

  def self.load_opal_parser
    `$.getScript('js/dynamic_libraries/opal/opal_parser.js', function (data, textStatus, jqxhr) {#{@opal_parser = true}})`
  end

  def self.opal_parser_ready
    @opal_parser
  end

end


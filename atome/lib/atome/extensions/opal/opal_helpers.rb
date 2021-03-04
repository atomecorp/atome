module JSUtils
  def jq_get(atome_id)
    Element.find("#" + atome_id)
  end

  def device
    `window`
  end

  def document
    `$(document)`
  end

  # timeout
  def set_timeout(time)
    unless ATOME.content[:time_out]
      ATOME.content[:time_out] = []
    end
    timeout = `setTimeout(function(){ #{yield} }, #{time * 1000})`
    ATOME.add_timeout(timeout)
    timeout
  end

  def add_timeout(timeout)
    @content.read[:time_out] << timeout
  end

  def clear_timeout(params)
    @content.read[:time_out].delete(params)
    `clearTimeout(#{params})`
  end

  def clear_timeouts
    @content.read[:time_out].each do |timeout|
      `clearTimeout(#{timeout})`
    end
    @content.read[:time_out] = []
  end

  # repeat
  def set_interval(delay, repeat)
    unless ATOME.content[:intervals]
      ATOME.content[:intervals] = {}
    end
    interval=""
    interval = `setInterval(function(){ #{yield}, #{interval_countdown(interval)} }, #{delay * 1000})`
    ATOME.add_interval(interval, repeat)
  end

  def interval_countdown(interval)
    counter = ATOME.content[:intervals][interval] - 1
    if counter == 0
      clear_interval(interval)
      ATOME.content[:intervals].delete(interval)
    end
    ATOME.content[:intervals][interval] = counter
  end

  def add_interval(interval, repeat)
    @content.read[:intervals][interval] = repeat
  end

  def clear_interval(interval)
    `clearInterval(#{interval})`
  end

  def clear_intervals
    ATOME.content[:intervals].each do |interval|
      `clearInterval(#{interval})`
    end
    ATOME.content[:intervals] = {}
  end

  # helper to check if we have a tactile device
  def is_mobile
    `atome.jsIsMobile()`
  end

  # code editor below
  def self.load_opal_parser
    `$.getScript('js/dynamic_libraries/opal/opal_parser.js', function (data, textStatus, jqxhr) {#{@opal_parser=true}})`
  end

  def self.opal_parser_ready
    @opal_parser
  end

  def self.set_ide_content(ide_id, content)
    editor_id = "cm_" + ide_id
    `document.getElementById(#{editor_id}).CodeMirror.getDoc().setValue(#{content})`
  end

  def get_ide_content(ide_id)
    editor_id = "cm_" + ide_id
     `document.getElementById(#{editor_id}).CodeMirror.getDoc().getValue("\n")`
  end

  def load_codemirror(atome_id, content)
    `atome.jsLoadCodeEditor(#{atome_id},#{content})`
  end

  def self.reader (filename, &proc)
    `atome.jsReader(#{filename},#{proc})`
  end

end


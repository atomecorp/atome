
module JSUtils
  def jq_get(atome_id)
    Element.find("#" + atome_id)
  end

  def initialize
    @codemirror = []
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
    # clear_timeout(timeout)
    # clear_timeouts
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

  def verification(*params)
    `atome.jsVerification(#{params})`
  end


  # code editor below
  def load_opal_parser
      `
    $.getScript('js/dynamic_libraries/opal/opal_parser.js', function (data, textStatus, jqxhr) {
            });
`
  end

  def opal_parser_ready
    @opal_parser
  end

  def self.set_ide_content ide_id, content
    editor_id= "cm_"+ide_id
    `document.getElementById(#{editor_id}).CodeMirror.getDoc().setValue(#{content})`
  end

  def get_ide_content ide_id
    editor_id= "cm_"+ide_id
    return `document.getElementById(#{editor_id}).CodeMirror.getDoc().getValue("\n")`
  end

  def load_codemirror ide_atome_id, content
    if @codemirror.class!=Array
      @codemirror=[]
    end

    if @codemirror ==[]
      `$('<link/>', {
                                                    rel: 'stylesheet',
                                                    type: 'text/css',
                                                    href: 'css/codemirror.css'
                                                }).appendTo('head');
$.getScript('js/third_parties/ide/codemirror.min.js', function (data, textStatus, jqxhr) {
    $.getScript('js/third_parties/ide/active-line.min.js', function (data, textStatus, jqxhr) {
        $.getScript('js/third_parties/ide/closebrackets.min.js', function (data, textStatus, jqxhr) {
            $.getScript('js/third_parties/ide/closetag.min.js', function (data, textStatus, jqxhr) {
                $.getScript('js/third_parties/ide/dialog.min.js', function (data, textStatus, jqxhr) {
                    $.getScript('js/third_parties/ide/formatting.min.js', function (data, textStatus, jqxhr) {
                        $.getScript('js/third_parties/ide/javascript.min.js', function (data, textStatus, jqxhr) {
                            $.getScript('js/third_parties/ide/jump-to-line.min.js', function (data, textStatus, jqxhr) {
                                $.getScript('js/third_parties/ide/matchbrackets.min.js', function (data, textStatus, jqxhr) {
                                    $.getScript('js/third_parties/ide/ruby.min.js', function (data, textStatus, jqxhr) {
                                        $.getScript('js/third_parties/ide/search.min.js', function (data, textStatus, jqxhr) {
                                            $.getScript('js/third_parties/ide/searchcursor.min.js', function (data, textStatus, jqxhr) {
                                                    #{@codemirror << ide_atome_id}
ide_container_id="#"+#{ide_atome_id}
ide_id='ide_'+#{ide_atome_id}
$(ide_container_id).append("<textarea id="+ide_id+" name='code'></textarea>");
var code_editor = CodeMirror.fromTextArea(document.getElementById(ide_id), {
    lineNumbers: true,
    codeFolding: true,
    styleActiveLine: true,
    indentWithTabs: true,
    matchTags: true,
    matchBrackets: true,
    electricChars: true,
    mode: "ruby",
    lineWrapping: true,
    indentAuto: true,
    autoCloseBrackets: true,
    tabMode: "shift",
    autoRefresh: true
});
new_editor=document.querySelector(".CodeMirror");
// we check all codemirror if they have an id to avoid to reassign an id to already created codemirror
if (($(new_editor).attr('id'))== undefined){
new_editor_id="cm_"+#{ide_atome_id}
$(new_editor).attr('id',new_editor_id )
};
code_editor.setSize("100%", "100%");
code_editor.setOption("theme", "3024-night");
function getSelectedRange() {
    return {
        from: editor.getCursor(true),
        to: editor.getCursor(false)
    };
}
Opal.JSUtils.$set_ide_content(#{ide_atome_id}, #{content})

                                            });
                                        });
                                    });
                                });
                            });
                        });
                    });
                });
            });
        });
    });
});
`
    end
  end

end


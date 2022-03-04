module JSUtils
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

  def codemirror_font_size(font_size)
    code_editor_font_size = "#{font_size}px"
    `$(".CodeMirror").css("fontSize", #{code_editor_font_size})`
  end

end
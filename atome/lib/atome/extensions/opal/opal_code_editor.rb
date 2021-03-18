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
end
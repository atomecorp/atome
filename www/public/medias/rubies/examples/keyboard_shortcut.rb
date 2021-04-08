# keyboard shortcut

grab(:device).key({option: :down}) do |evt|
  if evt.alt_key
    evt.stop_propagation
    evt.stop_immediate_propagation
    evt.prevent_default
    case evt.key_code
    when 65
      #key a
      unless grab(:code_editor)
        code({atome_id: :code_editor, content: :box})
        evt.prevent_default
      end
    when 69
      #key e
      puts('console')
    when 82
      #key r
      if grab(:code_editor)
        evt.stop_propagation
        evt.stop_immediate_propagation
        evt.prevent_default
        clear(:view)
        compile(ATOME.get_ide_content("code_editor_code"))
      end
    when 84
      #key t
    when 89
      #key y
    when 90
      #key z
      if grab(:code_editor)
        grab("code_editor").delete
        evt.prevent_default
      end
    else
    end
  elsif evt.ctrl_key
  else
  end
end
text("alt-a : open ide\nalt-z : close ide\nalt-r : compile code\n")
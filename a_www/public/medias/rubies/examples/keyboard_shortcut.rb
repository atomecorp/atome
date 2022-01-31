# keyboard shortcut

grab(:view).key({options: :down}) do |evt|
  if evt.alt_key
    evt.stop_propagation
    evt.stop_immediate_propagation
    evt.prevent_default
    case evt.key_code
    when 65
      #key a
      unless grab(:code_editor)
        #the restore the  state found in the buffer object
        if grab(:buffer).content[:code_editor]
          code_editor_content = grab(:buffer).content[:code_editor][:content]
          x_position = grab(:buffer).content[:code_editor][:x]
          y_position = grab(:buffer).content[:code_editor][:y]
          width_size = grab(:buffer).content[:code_editor][:width]
          height_size = grab(:buffer).content[:code_editor][:height]
        else
          code_editor_content = :box
          x_position = 0
          y_position = 0
          width_size=150
          height_size=150
        end
        coding({atome_id: :code_editor, content: code_editor_content,
              x: x_position,
              y: y_position,
              width: width_size,
              height: height_size
             })
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
        #the line below store the current state in the buffer object
        grab(:buffer).content = grab(:buffer).content.merge(
          code_editor: {content: ATOME.get_ide_content(:code_editor.to_s + "_code_editor"),
                        x: grab(:code_editor).x,
                        y: grab(:code_editor).y,
                        width: grab(:code_editor).width,
                        height: grab(:code_editor).height})
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
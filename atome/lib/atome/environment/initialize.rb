# we create the recipient that will store all created atomes instances (cant be read using Atome.atomes)
Atome.sparkle
# finally we create an atome constant to access all atomes apis
ATOME = Atome.new({ atome_id: :atome, render: false, content: {} })
# now we create the basic universe for the device and it's forthcoming atomes
Device.new
MESSENGER = (grab(:messenger))
# keyboard short cut
grab(:device).key({ option: :down }) do |evt|
  if evt.alt_key
    evt.stop_propagation
    evt.stop_immediate_propagation
    evt.prevent_default
    case evt.key_code
    when 65
      #key a
      if grab("code_editor")
        #the line below store the current state in the buffer object
        grab(:buffer).content = grab(:buffer).content.merge(
          code_editor: { content: ATOME.get_ide_content(:code_editor.to_s + "_code_editor"),
                         x: grab(:code_editor).x,
                         y: grab(:code_editor).y,
                         width: grab(:code_editor).width,
                         height: grab(:code_editor).height })
        grab("code_editor").delete
        evt.prevent_default
      else
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
          width_size = 150
          height_size = 150
        end
        code({ atome_id: :code_editor, content: code_editor_content,
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
    else
    end
  elsif evt.ctrl_key
  else
  end
end

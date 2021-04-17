def code(value = {atome_id: identity, content: ""})
  JSUtils.load_opal_parser
  container_id = value[:atome_id]
  ide_atome_id = container_id.to_s + "_code_editor"
  # fixme : we have todo .gsub("atome_require","require") twice for some reasons!!!
  content_found = value[:content].gsub("atome_require","require")
  content_found= content_found.gsub("atome_require","require")
  handle_size=24
  container_preset ={atome_id: container_id, parent: :intuition,
                                   width: 500, height: 300,
                                  shadow: {x: 0, y: 0, blur: 6, thickness: 0,
                                           color: {red: 0, green: 0, blue: 0, alpha: 0.6}, invert: false}}.merge(value)
  editor_value = {atome_id: ide_atome_id,width: container_preset[:width], height: container_preset[:height], y: handle_size}

  # we create the code editor container
  container = box(container_preset)
  container.box({x:0, y: 0, width: "100%", height: handle_size, color: :black, atome_id: "handler_"+ide_atome_id})
  code_editor = container.box(editor_value)
  code_editor.type(:machine)
  code_editor.touch({option: :stop}) do |evt|
    evt
  end
  code_editor.size({value: container_preset[:width], option: {'nw': '#nwgrip'}}) do |evt_size|
    evt_size
    container.width = code_editor.width
    container.height = code_editor.height
  end
  ATOME.load_codemirror(ide_atome_id, content_found)
  run = container.circle({width: 20, height: 20, x: 3, y: 3})
  close = container.box({width: 20, height: 20, x: 30, y: 3, color: :gray})
  run.touch do
    clear(:view)
    #the line below store the current state in the buffer object
    grab(:buffer).content=grab(:buffer).content.merge(
        code_editor: {content: ATOME.get_ide_content(ide_atome_id),
                      x: grab(container_id).x,
                      y: grab(container_id).y
        })
    compile(ATOME.get_ide_content(ide_atome_id))
  end
  close.touch do
    #the line below store the current state in the buffer object
    grab(:buffer).content=grab(:buffer).content.merge(
        code_editor: {content: ATOME.get_ide_content(ide_atome_id),
                      x: grab(container_id).x,
                      y: grab(container_id).y,
                      width: grab(container_id).width,
                      height: grab(container_id).height
        })
    grab(container_id).delete
  end
  container.drag({handle: "handler_"+ide_atome_id})
  code_editor

end
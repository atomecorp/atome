# test_project = {
#   name: :my_project,
#   id: 1234,
#
# }
# json_string = test_project.to_json
#
# json_response=grab(:inspector).text(json_string.to_s)
# hash = JSON.parse(json_string)
# hesh_response=grab(:inspector).text(hash.to_s)
# wait 2 do
#   hesh_response.data("hemmo")
#   json_response.data("hello\n")
# end
#
#
#
# alert Universe.particle_list.keys.sort.length

vie_test = Vie.new
vie_test.context[:webview] = :webkit

styles = {
  width: 169,
  height: 22,
  margin: 6,
  shadow: { blur: 9, left: 3, top: 3, id: :cell_shadow, red: 0, green: 0, blue: 0, alpha: 0.6 },
  left: 0,
  color: :yellowgreen
}

element = { width: 169,
            height: 6,
            component: { size: 9 },
            left: 3,
            top: -9,
            color: :black,
            type: :text }

def send_to_webkit(val)
  webkittalk(val)
end

def send_to_chrome(val)
  chrometalk(val)
end

if vie_test.context[:webview] == :webkit
  messengerwanted = :send_to_webkit
elsif vie_test.context[:webview] == :chrome
  messengerwanted = :send_to_chrome
end

listing = [
  { data: 'get modules', message: :get_modules },
  { data: 'new project', message: { new_project: { name: 'xxx' } }},
  { data: 'get projects', message: :get_projects },
  { data: 'load project', message: { load_project: {id: 'xxx'}} },
  { data: 'export project', message: { export_project: {id: 'xxx', path: 'export/path'} } },
  { data: 'import project', message: { import_project: { id: 'xxx', path: 'import/path' } } },
  { data: 'add module',  message: { add_module: {type: 'xxx', position: {x: 0, y: 0, z: 0} } } },
  { data: 'delete module', message: { delete_module: {id: "xxx"} } },
  { data: 'move module', message: { move_module: [{"id": "xxx"}, {x: 0, y: 0, z: 0}] } },
  { data: 'set module name', message: { set_module_name: {id: 'xxx', name: "new name"}} },
  { data: 'set module parameter value', message: {id: 'xxx', parameter_id: 'xxx', value: 'xxx'} },
  { data: 'link slots', message: { link_slots: {source_module_id: :source_slot_id,target_module_id: :target_slot_id } } },
  { data: 'unlink slots', message: { unlink_slots: { source_module_id: :source_slot_id, target_module_id: :target_slot_id } } },
  { data: 'enable slots link', message: { enable_slots_link: { link_slots: {source_module_id: :source_slot_id,target_module_id: :target_slot_id } }} },
  { data: 'disable slots link', message: { disable_slots_link: { source_module_id: :source_slot_id, target_module_id: :target_slot_id }}},
  { data: 'undo', message: :undo },
  { data: 'redo', message: :redo },
  { data: 'duplicate', message: { duplicate: 'new_name' } },

]
grab(:inspector).list({
                        left: 9,
                        top: 9,
                        styles: styles,
                        element: element,
                        listing: listing,
                        action: { touch: :down, method: messengerwanted }
                      })


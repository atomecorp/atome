# frozen_string_literal: true

#
# new({ atome: :editor, type: :hash }) do |params|
#   params
# end
#
# new({ sanitizer: :editor }) do |params|
#   params.merge({ markup: :textarea })
# end

e = editor({ id: :the_ed, code: "def my_script\n
  return 100\n
end", width: 333, height: 333, color: :lightgray, top: 333 })

def create_editor(code_id)
  js_code = <<~JAVASCRIPT
    var editor = CodeMirror.fromTextArea(document.getElementById("#{code_id}"), {
        lineNumbers: true,
        mode: "ruby",
        theme: "monokai"
    });
    editor.getWrapperElement().id = "atome_editor_#{code_id}";
    document.getElementById("atome_editor_#{code_id}").CodeMirrorInstance = editor;
  JAVASCRIPT
  JS.eval(js_code)
end

def set_code(code_id, content)
  js_code = <<~JAVASCRIPT
    var editorWrapper = document.getElementById("atome_editor_#{code_id}");
                 var editorInstance = editorWrapper.CodeMirrorInstance;
                 var newContent = "#{content}";
                 editorInstance.setValue(newContent);
  JAVASCRIPT
  JS.eval(js_code)
end

def get_code(code_id)
  js_code = <<~JAVASCRIPT
    var editorWrapper = document.getElementById("atome_editor_#{code_id}");
       
               var editorInstance = editorWrapper.CodeMirrorInstance;
               return editorInstance.getValue();
  JAVASCRIPT
  JS.eval(js_code)
end

t = text({ id: :the_t, data: :hello })
create_editor("the_ed")

b = box({ left: 99 })

wait 2 do
  editor_id="the_ed"
  set_code(editor_id, "def new_script\\n  puts 'so cool'\\ncircle({top: rand(333), color: :red})\\nend\\nnew_script")

end
b.touch(true) do
  editor_id="the_ed"
  data_found = get_code("the_ed").to_s
  grab(:the_t).code(data_found.to_s)
  atome_before = Universe.user_atomes
  eval(data_found)
  code_editor=grab(editor_id)
  atome_to_delete = code_editor.data
  # now we delete atome created before executing
  atome_to_delete.each do |atome_id_found|
    grab(atome_id_found).delete(false)
  end

  atome_after = Universe.user_atomes
  new_atomes = atome_after - atome_before
  code_editor.data(new_atomes)
end


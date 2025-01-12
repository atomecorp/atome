# frozen_string_literal: true
box
dragger = box({ width: 333, height: 16, top: 0 })
back = box({ width: 333, height: 222, top: dragger.height })
body = back.box({ top: 0, width: '100%', height: '100%', component: { size: 12 }, id: :poil })
code_runner = dragger.circle({ left: 3, top: 3, width: 12, height: 12, color: :red })
code_closer = dragger.circle({ left: :auto ,right: 3, top: 3, width: 12, height: 12, color: :black })

body.editor({ id: :the_ed, code: "def my_script\n
  return 100\n
end", width: 333, height: 192, color: :lightgray, top: 0 })

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

create_editor("the_ed")

wait 1 do
  editor_id = "the_ed"
  set_code(editor_id, "def new_script\\n  puts 'so cool'\\ncircle({top: rand(333), color: :red})\\nend\\nnew_script")
end

code_closer.touch(true) do
  back.delete(true)
  dragger.delete(true)
end

code_runner.touch(true) do
  editor_id = "the_ed"
  data_found = get_code("the_ed").to_s
  grab(:the_t).code(data_found.to_s)
  atome_before = Universe.user_atomes
  eval(data_found)
  code_editor = grab(editor_id)
  atome_to_delete = code_editor.data
  atome_to_delete.each do |atome_id_found|
    grab(atome_id_found).delete(false)
  end
  atome_after = Universe.user_atomes
  new_atomes = atome_after - atome_before
  code_editor.data(new_atomes)
end
dragger.drag(restrict: :view ) do |event|
  view = grab(:view)
  view_width = view.to_px(:width)
  view_height = view.to_px(:height)

  dx = event[:dx]
  dy = event[:dy]

  # Calculer les nouvelles positions
  x = (back.left || 0) + dx.to_f
  y = (back.top || 0) + dy.to_f

  # Contrainte de `x` entre 0 et `view_width`
  if x > 0 && x < view_width - back.width
    back.left(x)
  else
    # Contrainte si `x` dépasse les limites
    x = [0, [x, view_width - back.width].min].max
    back.left(x)
  end

  # Contrainte de `y` pour qu'il soit supérieur à une certaine valeur
  if y > 0 + dragger.height && y < view_height + dragger.height
    back.top(y)
  else
    # Contrainte si `y` dépasse les limites
    y = [0 + dragger.height, [y, view_height + dragger.height].min].max
    back.top(y)
  end
end
back.resize({ size: { min: { width: 120, height: 90 }, max: { width: 3000, height: 3000 } } }) do |event|
  dx = event[:dx]
  # dy = event[:dy]
  x = (dragger.width || 0) + dx.to_f
  # y = (back.top || 0) + dy.to_f
  dragger.width(x)
  # back.top(y)
end

back.shadow({ alpha: 0.6, blur: 16, left: 3, top: 16 })

back.drag(false)
dragger.touch(:double) do
  if back.display == :none
    back.display(:block)
  else
    back.display(:none)
  end
end

# a_list=[]
# Universe.atome_list.each  do |k, v|
#   a_list << k
# end
#
# alert a_list
#
# p_list=[]
#  Universe.particle_list.each  do |k, v|
#    p_list << k
#  end
#
# alert p_list
#
# box(id: :mon_carre, width: 300, height: 300)
alert "pseudo element and trigger absctrator"
def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "6",
    "CodeMirrorInstance",
    "atome_list",
    "box",
    "circle",
    "data",
    "delete",
    "display",
    "drag",
    "each",
    "editor",
    "eval",
    "fromTextArea",
    "getElementById",
    "getValue",
    "getWrapperElement",
    "height",
    "left",
    "particle_list",
    "resize",
    "setValue",
    "shadow",
    "to_f",
    "to_px",
    "to_s",
    "top",
    "touch",
    "user_atomes",
    "width"
  ],
  "6": {
    "aim": "The `6` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `6`."
  },
  "CodeMirrorInstance": {
    "aim": "The `CodeMirrorInstance` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `CodeMirrorInstance`."
  },
  "atome_list": {
    "aim": "The `atome_list` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `atome_list`."
  },
  "box": {
    "aim": "The `box` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `box`."
  },
  "circle": {
    "aim": "The `circle` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `circle`."
  },
  "data": {
    "aim": "The `data` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `data`."
  },
  "delete": {
    "aim": "The `delete` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `delete`."
  },
  "display": {
    "aim": "The `display` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `display`."
  },
  "drag": {
    "aim": "The `drag` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `drag`."
  },
  "each": {
    "aim": "The `each` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `each`."
  },
  "editor": {
    "aim": "The `editor` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `editor`."
  },
  "eval": {
    "aim": "The `eval` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `eval`."
  },
  "fromTextArea": {
    "aim": "The `fromTextArea` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fromTextArea`."
  },
  "getElementById": {
    "aim": "The `getElementById` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getElementById`."
  },
  "getValue": {
    "aim": "The `getValue` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getValue`."
  },
  "getWrapperElement": {
    "aim": "The `getWrapperElement` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `getWrapperElement`."
  },
  "height": {
    "aim": "The `height` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `height`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "particle_list": {
    "aim": "The `particle_list` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `particle_list`."
  },
  "resize": {
    "aim": "The `resize` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `resize`."
  },
  "setValue": {
    "aim": "The `setValue` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `setValue`."
  },
  "shadow": {
    "aim": "The `shadow` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `shadow`."
  },
  "to_f": {
    "aim": "The `to_f` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_f`."
  },
  "to_px": {
    "aim": "The `to_px` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_px`."
  },
  "to_s": {
    "aim": "The `to_s` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `to_s`."
  },
  "top": {
    "aim": "Defines the vertical position of the object in its container.",
    "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
  },
  "touch": {
    "aim": "Handles touch or click events to trigger specific actions.",
    "usage": "Example: `touch(:tap) do ... end` triggers an action when tapped."
  },
  "user_atomes": {
    "aim": "The `user_atomes` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `user_atomes`."
  },
  "width": {
    "aim": "The `width` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `width`."
  }
}
end

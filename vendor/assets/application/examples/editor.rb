# frozen_string_literal: true

#
# new({ atome: :editor, type: :hash }) do |params|
#   params
# end
#
# new({ sanitizer: :editor }) do |params|
#   params.merge({ markup: :textarea })
# end



e = editor({ id: :the_ed, data: "def my_script\n
  return 100\n
end", width: 333, height: 333, color: :lightgray, top: 333 })


js_code = <<~JAVASCRIPT
  // Initialiser CodeMirror et le stocker dans l'élément textarea
        var editor = CodeMirror.fromTextArea(document.getElementById("the_ed"), {
            lineNumbers: true,
            mode: "ruby",
            theme: "monokai"
        });

        // Ajouter un ID unique à l'instance de CodeMirror
        editor.getWrapperElement().id = "codeMirror_the_ed";

        // Stocker l'instance de CodeMirror dans l'élément wrapper
        document.getElementById("codeMirror_the_ed").CodeMirrorInstance = editor;

        // Fonction pour obtenir le contenu de CodeMirror
        function getCode() {
            var editorWrapper = document.getElementById("codeMirror_the_ed");
            if (editorWrapper && editorWrapper.CodeMirrorInstance) {
                var editorInstance = editorWrapper.CodeMirrorInstance;
                alert(editorInstance.getValue());
            } else {
                console.error("L'instance de CodeMirror n'a pas été trouvée.");
            }
        }

        // Fonction pour définir le contenu de CodeMirror
        function setCode() {
            var editorWrapper = document.getElementById("codeMirror_the_ed");
            if (editorWrapper && editorWrapper.CodeMirrorInstance) {
                var editorInstance = editorWrapper.CodeMirrorInstance;
                var newContent = "def new_script\\n  return 200\\nend";
                editorInstance.setValue(newContent);
            } else {
                console.error("L'instance de CodeMirror n'a pas été trouvée.");
            }
        }

        // Utilisation de setTimeout pour définir le contenu après 1 seconde
        setTimeout(setCode, 1000);

        // Utilisation de setTimeout pour obtenir le contenu après 2 secondes
        setTimeout(getCode, 2000);
JAVASCRIPT
#
# js_code2 = <<~JAVASCRIPT
#
#           // Fonction pour définir le contenu de CodeMirror en utilisant l'id de la textarea
#           function setCode(val) {
#               var newContent = val;
#               var editor = CodeMirror.fromTextArea(document.getElementById("the_ed"));
#               editor.setValue(newContent);
#           }
#           setCode('poil')
# JAVASCRIPT
#
# js_code3 = <<~JAVASCRIPT
#
#       function getCode() {
#               var editor = CodeMirror.fromTextArea(document.getElementById("the_ed"));
#               alert(editor.getValue());
#           }
#
#
#           getCode()
# JAVASCRIPT
wait 1 do
  JS.eval(js_code)

  # wait  1 do
  #   JS.eval(js_code2)
  #   wait  1 do
  #     JS.eval(js_code3)
  #   end
  # end
end



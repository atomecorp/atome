# def add_new_class(class_name, tag_name, tag_content)
#
# `
#   var styleTag = document.getElementById("atomic_style");
#   styleTag.innerHTML += "\n."+#{class_name}+'{\n '+#{tag_name}+': '+#{tag_content}+';\n}\n\n\n\n';
# `
# end
#
# add_new_class('new_class', 'background-color','yellow')
# add_new_class('other_class', 'color','red')

# def update_css_tag(tag_name, var_name, value)
#   alert "this code doesn't work with chrome"
#   `
#   var rules = null;
#       var cssRules = document.styleSheets[0].cssRules;
#       for (var i = 0; i < cssRules.length; i++) {
#       var rule = cssRules[i];
#       if (rule.selectorText === '.'+#{tag_name}) {
#         rules = rule;
#         break;
#       }
#       }
#
#       if (rules) {
#
#       rules.style.setProperty(#{var_name}, #{value});
#       }
# `
# end

# update_css_tag('other_class', '--end-color', 'blue')

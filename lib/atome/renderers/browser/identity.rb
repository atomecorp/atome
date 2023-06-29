# frozen_string_literal: true

generator = Genesis.generator


generator.build_render(:browser_type) do |params|
  send("browser_#{params}", user_proc)
end

generator.build_render(:browser_attach) do |parents_found|
  parents_found.each do |parent_found|
    BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
  end
end

generator.build_render(:browser_attached) do |children_found|
  children_found.each do |child_found|
    children_browser_type = grab(child_found).instance_variable_get('@browser_type')
    BrowserHelper.send("browser_attached_#{children_browser_type}", child_found, @browser_object, @atome)
  end
end

generator.build_render(:browser_detached) do |values, _user_proc|
  values.each do |value|
    # FIXME: ugly patch to check if the value passed is an atome must create a more robust global solution for .value
    value = value.value if value.instance_of? Atome
    if grab(value).instance_variable_get('@browser_type') == :style
      @browser_object.remove_class(value)
      ##TODO : factorise code with the one found in borwser/utility/browser_delete
      if definition
        `
            let parser = new DOMParser();
    var divElement = document.querySelector('#'+#{self.id});
// divElement.style.removeProperty('background-color');
//divElement.style.backgroundColor = 'transparent';
    // select the first svg tag inside the div
    let foundSVG  = divElement.querySelector('svg');
     let elements = foundSVG.getElementsByTagName("path");
    Array.from(elements).forEach(el => {
                 el.classList.remove(#{value});
               });
    `
      end

    else
      BrowserHelper.browser_document[value]&.remove
    end
  end
end


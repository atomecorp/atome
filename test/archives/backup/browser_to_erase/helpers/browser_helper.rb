# frozen_string_literal: true

# for browser rendering
module BrowserHelper
  def self.browser_document
    # Work because of the patched version of opal-browser(0.39)
    Browser.window
  end

  def self.browser_attach_(_parents, _html_object, _atome)
    # dummy methods to catch atomes that do not need to be attached to any particular visual atome
  end

  def self.append_div(parents_found, child_found, child_properties)
    child_found.append_to(browser_document[parents_found])
    # # the lines below are used to keep the original position of the attached atome
    # parent_left = child_properties[:left].to_f - grab(parents_found).left.to_f
    # parent_top = child_properties[:top].to_f - grab(parents_found).top.to_f
    # parent_right = child_properties[:right].to_f - grab(parents_found).right.to_f
    # parent_bottom = child_properties[:bottom].to_f - grab(parents_found).bottom.to_f
    # child_found.style[:left] = "#{parent_left}px" if parent_left
    # child_found.style[:top] = "#{parent_top}px" if parent_top
    # child_found.style[:right] = "#{parent_right}px" if parent_right
    # child_found.style[:bottom] = "#{parent_bottom}px" if parent_bottom
  end

  def self.browser_attach_div(parents_found, child_found, child_properties)
    append_div(parents_found, child_found, child_properties)
  end

  def self.browser_attached_div(child_id, _html_object, atome)
    child = grab(child_id)
    child_found = child.browser_object
    parents_found = atome[:id]
    child_properties = child.atome
    append_div(parents_found, child_found, child_properties)
  end

  def self.add_class_to_vector(vector_id, color_id)
    # TODO : Create a class instead of modifying the vector
    # get the content the <style> tag
    # color_class=self.color.last
    # alert color_class
    # alert color_class.class
    # content_style = tag_style.inner_html
    # color_value = content_style[/background-color:\s*([^;}]+)/, 1]
    `
            let parser = new DOMParser();
    var divElement = document.querySelector('#'+#{vector_id});
// divElement.style.removeProperty('background-color');
//divElement.style.backgroundColor = 'transparent';
    // select the first svg tag inside the div
    let foundSVG  = divElement.querySelector('svg');
     let elements = foundSVG.getElementsByTagName("path");
    Array.from(elements).forEach(el => {
                el.classList.add(#{color_id});
            });
    `
  end

  def self.browser_attach_style(parents, _html_object, atome)
    # we test if the atome has a definition ( it means hold some vectors information)
    if grab(parents).atome[:definition]
      # tag_style = $document[atome[:id]]
      # # # get the content the <style> tag
      # # content_style = tag_style.inner_html
      # #  extract the color value
      # alert atome[:id]
      add_class_to_vector(parents, atome[:id])
    else
      browser_document[parents].add_class(atome[:id])
    end
  end

  def self.browser_attached_style(children, _html_object, atome)
    if atome[:definition]
      # alert "yes we arrived here :>\n\n=>#{children}, class:\n=>#{children.class} :\n\n=> #{atome} :\n\n=>  #{_html_object}<:"
      children.each do |child|
        # tag_style = $document[child]
        # alert "(#{atome[:id]}, #{child})"
        add_class_to_vector(atome[:id], child)
        # get the content the <style> tag
        #            content_style = tag_style.inner_html
        #            #  extract the color value
        #            color_value = content_style[/background-color:\s*([^;}]+)/, 1]
        #            `
        #         let parser = new DOMParser();
        # var divElement = document.querySelector('#'+#{atome[:id]});
        # // select the first svg tag inside the div
        # let foundSVG  = divElement.querySelector('svg');
        #  let elements = foundSVG.getElementsByTagName("path");
        # Array.from(elements).forEach(el => {
        #             el.setAttribute("fill", #{color_value});
        #             el.setAttribute("stroke", #{color_value});
        #         });
        # `
      end

    else
      # alert "class added : #{children}"
      # browser_document[atome[:id]].add_class(children)
    end
    browser_document[atome[:id]].add_class(children)
  end

  def self.value_parse(value)
    if value.instance_of?(String)
      value
    else
      "#{value}px"
    end

  end
end

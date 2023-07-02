# frozen_string_literal: true

require 'renderers/html/effect'
require 'renderers/html/event'
require 'renderers/html/geometry'
require 'renderers/html/identity'
require 'renderers/html/spatial'
require 'renderers/html/atome'
require 'renderers/html/utility'

# #html object
class Html
  def initialize
    html = `document.createElement("div")`
    `document.body.appendChild(#{html})`
    `document.body.appendChild(#{html})`
    @html = html
  end

  def add_class(class_to_add)
    `#{@html}.classList.add(#{class_to_add})`
  end

  def attr(attribute, value)
    `#{@html}.setAttribute(#{attribute}, #{value})`
  end

  def style
    # `#{@html}.style`
  end
  def append_shape(parent)
    parent_found = `document.getElementById(#{parent})`
    parent_found
    `#{parent_found}.appendChild(#{@html})`
  end
  def append_color(parent)
     "color : #{parent.class}"
  end
  def append_to(_node)

  end
end

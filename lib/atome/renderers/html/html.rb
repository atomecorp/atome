# frozen_string_literal: true

require 'atome/renderers/html/effect'
require 'atome/renderers/html/event'
require 'atome/renderers/html/geometry'
require 'atome/renderers/html/identity'
require 'atome/renderers/html/spatial'
require 'atome/renderers/html/atome'
require 'atome/renderers/html/utility'

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
    aleputsrt "color : #{parent.class}"
  end
  def append_to(_node)

  end
end

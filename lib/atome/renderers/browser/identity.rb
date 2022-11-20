# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:browser_type) do |params|
  send("browser_#{params}", user_proc)
end

generator.build_render_method(:browser_parents) do |parents_found|
  type_found = @atome[:type]
  parents_found.each do |parent_found|
    BrowserHelper.send("browser_attach_#{type_found}", parent_found, @html_object, @atome)
  end
end

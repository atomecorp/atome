# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:browser_id) do |params|
  browser_object.id=params if @atome[:id] != params
end

generator.build_render_method(:browser_type) do |params|
  send("browser_#{params}", user_proc)
end

generator.build_render_method(:browser_parents) do |parents_found|
  parents_found.each do |parent_found|
    BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
  end
end

generator.build_option(:pre_render_children) do |children_pass|
  children_pass.each do |child_found|
    atome_found = grab(child_found)
    atome_found.parents([@atome[:id]])
  end
end

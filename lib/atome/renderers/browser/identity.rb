# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:browser_id) do |params|
  if @browser_type == :style
    prev_content = @browser_object.inner_html
    new_content = prev_content.sub(@browser_object.id, params)
    @browser_object.inner_html = new_content
  end
  browser_object.id = params if @atome[:id] != params
end

generator.build_render(:browser_type) do |params|
  send("browser_#{params}", user_proc)
end

generator.build_render(:browser_family) do |parents_found|
  BrowserHelper.send("browser_attach_#{@browser_type}", parents_found, @browser_object, @atome)
end

generator.build_render(:browser_attach) do |parents_found|
  parents_found.each do |parent_found|
    BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
  end
end


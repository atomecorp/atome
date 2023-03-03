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

# generator.build_render(:browser_family) do |parents_found|
#   BrowserHelper.send("browser_attach_#{@browser_type}", parents_found, @browser_object, @atome)
# end

generator.build_render(:browser_attach) do |parents_found|
  # puts "parents_found : #{parents_found}, #{parents_found.class}"
  parents_found.each do |parent_found|
    puts ">>>>> model:  browser_type #{@browser_type} parents_found #{parents_found} , @browser_object, #{@browser_object}, self : #{self.id}"
    BrowserHelper.send("browser_attach_#{@browser_type}", parent_found, @browser_object, @atome)
  end
end

generator.build_render(:browser_attached) do |children_found|
  children_found.each do |child_found|
    puts ">>>>>>>>> j'en suis la : browser_type: #{@browser_type},children_found #{children_found},browser_object#{@browser_object}, self : #{self.id}"
    # puts "NNNNNNNNow we render the attached object : #{parents_found}"
    children_browser_type=grab(child_found).instance_variable_get('@browser_type')
    BrowserHelper.send("browser_attached_#{children_browser_type}", children_found, @browser_object, @atome)
  end
end

generator.build_render(:browser_detached) do |value, _user_proc|
  @browser_object.remove_class(value)
end


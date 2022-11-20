# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:html_type) do |params|
  send("html_#{params}", user_proc)
end

generator.build_render_method(:html_parents) do |parents_found|
  type_found = @atome[:type]
  parents_found.each do |parent_found|
    # @html_object.append_to(:hello, :salut)
    # alert parent_found.class
    @html_object.send("append_#{type_found}", parent_found)
    # send("opal_attach_#{type_found}", parent_found)
  end
end

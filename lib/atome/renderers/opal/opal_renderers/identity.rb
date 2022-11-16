# frozen_string_literal: true

# for opal rendering
class Atome
  private

  def opal_attach_shape(parent)
    @html_object.append_to($document[parent])
  end

  def opal_attach_color(parent)
    $document[parent].add_class(@atome[:id])
  end
end

generator = Genesis.generator

generator.build_render_method(:html_type) do |params|
  send("html_#{params}", user_proc)
end

generator.build_render_method(:html_parent) do |parents_found|
  type_found = @atome[:type]
  parents_found.each do |parent_found|
    send("opal_attach_#{type_found}", parent_found)
  end
end

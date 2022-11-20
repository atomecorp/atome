# frozen_string_literal: true

generator = Genesis.generator
generator.build_render_method(:html_bloc)
generator.build_render_method(:html_id)
generator.build_render_method(:html_render)
generator.build_render_method(:html_delete) do
  html_object&.remove
end
generator.build_render_method(:html_clear) do
  @atome[:children].each do |child_found|
    grab(child_found).html_object&.remove
  end
  children([])
end

# frozen_string_literal: true

generator = Genesis.generator
generator.build_render(:html_bloc)
generator.build_render(:html_id)
generator.build_render(:html_render)
generator.build_render(:html_delete) do
  html_object&.remove
end
generator.build_render(:html_clear) do
  @atome[:children].each do |child_found|
    grab(child_found).html_object&.remove
  end
  children([])
end
generator.build_render(:html_schedule)
generator.build_render(:html_reader)

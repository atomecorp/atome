# frozen_string_literal: true

generator = Genesis.generator

generator.build_render_method(:browser_shape) do
  current_atome = @atome
  id_found = current_atome[:id]
  DOM do
    div(id: id_found).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @html_object = BrowserHelper.browser_document[id_found]
end

generator.build_render_method(:browser_color) do |_value|
  # we remove previous unused style tag
  BrowserHelper.browser_document[id]&.remove
  red_found = @atome[:red]
  blue_found = @atome[:blue]
  green_found = @atome[:green]
  alpha_found = @atome[:alpha]
  BrowserHelper.browser_document.head << DOM("<style atome='#{type}'  id='#{id}'>.#{id}{background-color: rgba(#{red_found * 255},
  #{green_found * 255},#{blue_found * 255},#{alpha_found})}</style>")
  # TODO/ use the code below to modify the style tag
  # `document.getElementById(#{id}).sheet.cssRules[0].style.backgroundColor = 'red'`
end

generator.build_render_method(:browser_image) do |_user_prc|
  current_atome = @atome
  id_found = current_atome[:id]
  DOM do
    div(id: id_found).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @html_object = BrowserHelper.browser_document[id_found]
end

generator.build_render_method(:browser_shadow) do
end

generator.build_render_method(:browser_video) do |_value, _user_proc|
  # id_found = id
  # # instance_exec(&proc) if proc.is_a?(Proc)
  # DOM do
  #   video({ id: id_found, autoplay: true ,loop: false, muted: true }).atome
  # end.append_to($document[:user_view])
  # @html_object = $document[id_found]
end

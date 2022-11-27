# frozen_string_literal: true

# TODO : remove the DOM const and the parents methods there's just there to satisfy Rubocop
# start dummy code
DOM = :nil

def parents(_val) end

# end dummy code

generator = Genesis.generator

generator.build_render_method(:browser_shape) do
  @browser_type = :div
  id_found = @atome[:id]
  DOM do
    div(id: id_found).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
  # Render particles below
  # collapse
end

generator.build_render_method(:browser_color) do |_value|
  @browser_type = :style
  id_found = @atome[:id]
  type_found = @atome[:type]
  # we remove previous unused style tag
  BrowserHelper.browser_document[id]&.remove
  red_found = @atome[:red]
  blue_found = @atome[:blue]
  green_found = @atome[:green]
  alpha_found = @atome[:alpha]
  BrowserHelper.browser_document.head << Browser.DOM("<style atome='#{type_found}'
  id='#{id_found}'>.#{id_found}{background-color: rgba(#{red_found * 255},
  #{green_found * 255},#{blue_found * 255},#{alpha_found})}</style>")
  # TODO/ use the code below to modify the style tag
  @browser_object = BrowserHelper.browser_document[id_found]
  # now we just have to attach the color atome
  # parents(@atome[:parents])
  # children(@atome[:children])
  # collapse
end

generator.build_render_method(:browser_shadow) do |_value|
  @browser_type = :style
  id_found = @atome[:id]
  type_found = @atome[:type]
  # we remove previous unused style tag
  BrowserHelper.browser_document[id]&.remove
  red_found = @atome[:red]
  blue_found = @atome[:blue]
  green_found = @atome[:green]
  alpha_found = @atome[:alpha]
  blur = @atome[:blur]
  left = @atome[:left]
  top = @atome[:top]
  inset = @atome[:direction]

  BrowserHelper.browser_document.head << Browser.DOM("<style atome='#{type_found}'
  id='#{id_found}'>.#{id_found}{box-shadow: #{left}px #{top}px #{blur}px #{inset} rgba(#{red_found * 255},
  #{green_found * 255},#{blue_found * 255},#{alpha_found})}</style>")
  # TODO/ use the code below to modify the style tag
  @browser_object = BrowserHelper.browser_document[id_found]
end

generator.build_render_method(:browser_image) do |_user_prc|
  @browser_type = :div
  id_found = id
  DOM do
    img({ id: id_found }).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
  # Render particles below
  # collapse
end

generator.build_render_method(:browser_video) do |_value, _user_proc|
  # @browser_type = :div
  # id_found = id
  # DOM do
  #   video({ id: id_found, autoplay: true, loop: false, muted: true }).atome
  # end.append_to(BrowserHelper.browser_document[:user_view])
  # @browser_object = BrowserHelper.browser_document[id_found]
end

generator.build_render_method(:browser_text) do |_value, _user_proc|
  id_found = id
  DOM do
    div(id: id_found).atome.text
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
  @browser_type = :div
  # Render particles below
  # collapse
end

generator.build_render_method(:browser_web) do
  @browser_type = :web
  id_found = @atome[:id]

  DOM do
    iframe({ id: id_found }).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
  @browser_object.attributes[:allow] = 'accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture'
  @browser_object.attributes[:allowfullscreen] = true
  @html_type = :web
end

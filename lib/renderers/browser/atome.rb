# frozen_string_literal: true

# TODO : remove the DOM const and the parents methods there's just there to satisfy Rubocop
# start dummy code
DOM = :nil

generator = Genesis.generator

generator.build_render(:browser_shape) do
  # if @definition
  #   alert "why we never pass here??????"
  # else
  @browser_type = :div
  id_found = @atome[:id]
  DOM do
    div(id: id_found).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
  # end

end

generator.build_render(:browser_group) do

  # if @definition
  #   alert "why we never pass here??????"
  # else
  @browser_type = :div
  id_found = @atome[:id]
  DOM do
    div(id: id_found).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
  # end

end


generator.build_render(:browser_color) do |_value|
  # puts " @atome[:id] : #{@atome[:id]}"
  @browser_type = :style
  # puts "1 - for the id  : #{id} the browser type is  ::::> #{@browser_type}"
  id_found = @atome[:id]
  # type_found = @atome[:type]
  # we remove previous unused style tag
  BrowserHelper.browser_document[id]&.remove
  red = @atome[:red]
  green = @atome[:green]
  blue = @atome[:blue]
  alpha = @atome[:alpha]
  ########################### old code ###########################
  #   BrowserHelper.browser_document.head << Browser.DOM("<style atome='#{type_found}'
  #   id='#{id_found}'>.#{id_found}{
  # poil
  # //background-color: rgba(#{red_found * 255},#{green_found * 255},#{blue_found * 255},#{alpha_found});
  # //fill: rgba(#{red_found * 255},#{green_found * 255},#{blue_found * 255},#{alpha_found}),
  # //stroke: rgba(#{red_found * 255},#{green_found * 255},#{blue_found * 255},#{alpha_found})
  #
  # }</style>")

  ########################### new code ###########################
  atomic_style = BrowserHelper.browser_document['#atomic_style']

  #   class_content = <<STR
  # .#{id_found} {
  #   --#{id_found}_r : #{red * 255}
  #   --#{id_found}_g : #{green * 255}
  #   --#{id_found}_b : #{blue * 255}
  #   --#{id_found}_a : #{alpha}
  #   --#{id_found}_col : rgba(var(--#{id_found}_r ),var(--#{id_found}_g ),var(--#{id_found}_b ),var(--#{id_found}_a ))
  #
  #   background-color: rgba(#{red * 255}, #{green * 255}, #{blue * 255}, #{alpha});
  #   fill: rgba(#{red * 255}, #{green * 255}, #{blue * 255}, #{alpha});
  #   stroke: rgba(#{red * 255}, #{green * 255}, #{blue * 255}, #{alpha});
  # }
  # STR

  class_content = <<STR
.#{id_found} {
  --#{id_found}_r : #{red * 255};
  --#{id_found}_g : #{green * 255};
  --#{id_found}_b : #{blue * 255};
  --#{id_found}_a : #{alpha};
  --#{id_found}_col : rgba(var(--#{id_found}_r ),var(--#{id_found}_g ),var(--#{id_found}_b ),var(--#{id_found}_a ));
  background-color: var(--#{id_found}_col);
  fill:  var(--#{id_found}_col);
  stroke:  var(--#{id_found}_col);
}
STR

  if atomic_style
    # alert class_content.gsub(/[\n\r]{2,}/, "\n")
    if atomic_style.text.include?(".#{id_found}")
      # if the class exist , update it's content with the new class
      regex = /(\.#{id_found}\s*{)([\s\S]*?)(})/m
      atomic_style.text = atomic_style.text.gsub(regex, class_content)
    else
      # if the class doesn't exist, add it to the end of the tag <style>
      atomic_style.text += class_content
    end
    sanitized_text = atomic_style.text.gsub(/[\n\r]{2,}/, "\n")
    atomic_style.text = sanitized_text

  end
  ########################### new code end ###########################

  # TODO:  use the code below to modify the style tag
  @browser_object = BrowserHelper.browser_document[id_found]
end

generator.build_render(:browser_shadow) do |_value|
  @browser_type = :style
  id_found = @atome[:id]
  # type_found = @atome[:type]
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
  ############ old code
  # BrowserHelper.browser_document.head << Browser.DOM("<style atome='#{type_found}'
  # id='#{id_found}'>.#{id_found}{box-shadow: #{left}px #{top}px #{blur}px #{inset} rgba(#{red_found * 255},
  # #{green_found * 255},#{blue_found * 255},#{alpha_found})}</style>")
  # # TODO/ use the code below to modify the style tag
  # @browser_object = BrowserHelper.browser_document[id_found]

  ########## new code
  atomic_style = BrowserHelper.browser_document['#atomic_style']

  class_content = <<STR
.#{id_found} {
box-shadow: #{left}px #{top}px #{blur}px #{inset} rgba(#{red_found * 255},#{green_found * 255},#{blue_found * 255},
#{alpha_found});
filter: drop-shadow(#{left}px #{top}px #{blur}px rgba(#{red_found * 255},#{green_found * 255},#{blue_found * 255},
#{alpha_found}));
}
STR

  if atomic_style
    if atomic_style.text.include?(".#{id_found}")
      # if the class exist , update it's content with the new class
      regex = /(\.#{id_found}\s*{)([\s\S]*?)(})/m
      atomic_style.text = atomic_style.text.gsub(regex, class_content)
    else
      # if the class doesn't exist, add it to the end of the tag <style>
      atomic_style.text += class_content
    end
  end
  #
  #   @browser_object = BrowserHelper.browser_document[id_found]

end

generator.build_render(:browser_image) do |_user_prc|
  @browser_type = :div
  id_found = @atome[:id]
  DOM do
    img({ id: id_found }).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
end

new({ browser: :text, type: :string }) do |_value, _user_proc|
  id_found = @atome[:id]
  DOM do
    div(id: id_found).atome.text
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
  @browser_type = :div
end

generator.build_render(:browser_web) do
  @browser_type = :div
  id_found = @atome[:id]
  DOM do
    iframe({ id: id_found }).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
  @browser_object.attributes[:allow] = 'accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture'
  @browser_object.attributes[:allowfullscreen] = true
end

generator.build_render(:browser_video) do |_value, _user_proc|
  @browser_type = :div
  id_found = @atome[:id]
  DOM do
    video({ id: id_found, autoplay: false, loop: false, muted: false }).atome
  end.append_to(BrowserHelper.browser_document[:user_view])
  @browser_object = BrowserHelper.browser_document[id_found]
end
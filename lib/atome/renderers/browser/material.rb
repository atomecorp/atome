# frozen_string_literal: true

generator = Genesis.generator

generator.build_render(:red) do |value|
  red = ((@atome[:red] = value) * 255)
  green = @atome[:green] * 255
  blue = @atome[:blue] * 255
  alpha = @atome[:alpha]
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

generator.build_render(:green) do |value|
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  red = @atome[:red] * 255
  green = (@atome[:green] = value) * 255
  blue = @atome[:blue] * 255
  alpha = @atome[:alpha]
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

generator.build_render(:blue) do |value|
  red = @atome[:red] * 255
  green = @atome[:green] * 255
  blue = (@atome[:blue] = value) * 255
  alpha = @atome[:alpha]
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

generator.build_render(:alpha) do |value|
  red = @atome[:red] * 255
  green = @atome[:green] * 255
  blue = @atome[:blue] * 255
  alpha = (@atome[:alpha] = value)
  color_updated = "rgba(#{red}, #{green}, #{blue}, #{alpha})"
  BrowserHelper.send("browser_colorize_#{@atome[:type]}", color_updated, @atome)
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

generator.build_render(:visual) do |value|
  value = BrowserHelper.value_parse(value[:size])
  browser_object.style['font-size'] = value
end

generator.build_render(:browser_edit) do |value|
  if value == true
    caret_color = 'white'
    user_select = 'text'
    selection_color = 'blue'
  else
    caret_color = 'transparent'
    user_select = 'none'
    selection_color = 'transparent'
  end

  @browser_object.attributes[:contenteditable] = value
  @browser_object.style['caret-color'] = caret_color
  @browser_object.style['webkit-user-select'] = user_select
  @browser_object.style['-moz-user-select'] = user_select
  @browser_object.style['user-select'] = user_select
end

generator.build_render(:browser_hide) do |value|
  @browser_object.style[:display] = "none"

end

generator.build_render(:browser_classes) do |value, _user_proc|
  @browser_object.add_class(value)
  # TODO : don't forget to remove class
end

generator.build_render(:browser_remove_classes) do |value, _user_proc|
  @browser_object.remove_class(value)
end

new ({ browser: :opacity }) do |value|
  @browser_object.style['opacity'] = value
end

new ({ browser: :definition }) do |value|
  target=id
  `

var divElement =  document.querySelector('#'+#{target});;
divElement.style.removeProperty('background-color');
divElement.style.backgroundColor = 'transparent';
// select the first svg tag inside the div
var svgElement = divElement.querySelector('svg');

// delete the first svg tag inside the div if it exist
if (svgElement) {
  divElement.removeChild(svgElement);
}


  let svg_content='<svg style="width: 1em; height: 1em;vertical-align: middle;fill: currentColor;overflow: hidden;" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg">'+#{value}+'</svg>'
       let svgContainer = document.getElementById(#{target});
        svgContainer.style.removeProperty('background-color');
        svgContainer.style.backgroundColor = 'transparent';
        let parser = new DOMParser();
        let svgDoc = parser.parseFromString(svg_content, "image/svg+xml");
        let importedSVG = svgDoc.getElementsByTagName("svg")[0];
        importedSVG.style.width =  "100%";
        importedSVG.style.height =  "100%";
        let elements = importedSVG.getElementsByTagName("path");

        svgContainer.appendChild(importedSVG);

`
end

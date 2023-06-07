# frozen_string_literal: true

generator = Genesis.generator
generator.build_render(:browser_bloc)
generator.build_render(:browser_render)
generator.build_render(:browser_delete) do |params|
  if self.instance_variable_get('@browser_type') == :style
    # alert "we have to remove the style and the attached class :\n #{attach.class},\n params : #{params}"
    class_to_remove = self.id
    attach.each do |parent|
      grab(parent).browser_object.remove_class(class_to_remove)
    end
    `
function remove_class(class_name) {
  var styleElement = document.querySelector('style');

  // Vérifiez si l'élément <style> existe
  if (styleElement) {
	// Récupérez le contenu de l'élément <style>
	var styleContent = styleElement.innerHTML;

	// Créez une expression régulière pour supprimer la classe spécifiée avec son contenu
	var regex = new RegExp("\\." + class_name + "\\s*{[^}]+}", "g");
	styleContent = styleContent.replace(regex, '');

	// Mettez à jour le contenu de l'élément <style>
	styleElement.innerHTML = styleContent;
  }
}

remove_class(#{class_to_remove})
`

    # #TODO : factorise code with the one found in identity.rb generator.build_render(:browser_detached)
    #     if definition
    #       `
    #             let parser = new DOMParser();
    #     var divElement = document.querySelector('#'+#{self.id});
    # // divElement.style.removeProperty('background-color');
    # //divElement.style.backgroundColor = 'transparent';
    #     // select the first svg tag inside the div
    #     let foundSVG  = divElement.querySelector('svg');
    #      let elements = foundSVG.getElementsByTagName("path");
    #     Array.from(elements).forEach(el => {
    #                  el.classList.remove(#{self.id});
    #                });
    #     `
    #     end
    # remove_class from parent instead of @browser_object
    # @browser_object.remove_class(self.id)
    #
  end

  browser_object&.remove if params == true
end

# do not use browser_clear
# #
# # generator.build_render(:browser_clear) do
# #   @atome[:attached].each do |child_found|
# #     grab(child_found).browser_object&.remove
# #   end
# # end

generator.build_render(:browser_path) do |value|
  BrowserHelper.send("browser_path_#{@atome[:type]}", value, @browser_object, @atome)
end

generator.build_render(:browser_data) do |data|
  # according to the type we send the data to different operator
  type_found = @atome[:type]
  BrowserHelper.send("browser_data_#{type_found}", data, self)
end

generator.build_render(:browser_schedule) do |format_date, proc|
  years = format_date[0]
  months = format_date[1]
  days = format_date[2]
  hours = format_date[3]
  minutes = format_date[4]
  seconds = format_date[5]
  atome_js.JS.schedule(years, months, days, hours, minutes, seconds, self, proc)
end

generator.build_render(:browser_reader) do |file, proc|
  atome_js.JS.reader(file, self, proc)
end

generator.build_render(:browser_cursor) do |value|
  @browser_object.style[:cursor] = value
end

generator.build_render(:browser_overflow) do |value|
  @browser_object.style[:overflow] = value
end


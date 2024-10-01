# frozen_string_literal: true

#  this class is aimed at html rendering

class HTML

  def self.locate(selector, base_element = JS.global[:document][:body])
    return base_element if selector.empty?

    if selector.has_key?(:id)
      base_element.querySelector("##{selector[:id]}")
    elsif selector.has_key?(:parent)
      parent = base_element.querySelector("##{selector[:parent]}")
      return nil if parent.nil?

      parent.querySelectorAll("*").to_a
    elsif selector.has_key?(:html)
      html_element = selector[:html]
      return nil if html_element.nil?

      html_element.querySelectorAll("*").to_a
    end
  end

  def self.is_descendant(ancestor, descendant)
    JS.eval("return isDescendant('#{ancestor}', '#{descendant}')")
  end

  def initialize(id_found, current_atome)

    @element = JS.global[:document].getElementById(id_found.to_s)
    @id = id_found
    @original_atome = current_atome
    @touch_removed = {}

  end

  def object
    @element
  end

  def hypertext(params)
    current_div = JS.global[:document].getElementById(@id.to_s)
    current_div[:innerHTML] = params
  end

  def add_font_to_css(params)
    font_path = params[:path]
    font_name = params[:name]
    str_to_eval = <<~STRDELIM
      var styleSheet = document.styleSheets[0];
      styleSheet.insertRule(`
      @font-face {
        font-family: '#{font_name}';
        src: url('../medias/fonts/#{font_path}/#{font_name}.ttf') format('truetype');
      }`, styleSheet.cssRules.length);
    STRDELIM
    JS.eval(str_to_eval)
  end

  def add_css_to_atomic_style(css)
    style_element = JS.global[:document].getElementById('atomic_style')
    text_node = JS.global[:document].createTextNode(css)
    style_element.appendChild(text_node)
  end

  def convert_to_css(data)
    conditions = data[:condition]
    apply = data[:alterations]

    # Convert the conditions
    condition_strings = []

    if conditions[:max]
      condition_strings << "(max-width: #{conditions[:max][:width]}px)" if conditions[:max][:width]
      condition_strings << "(max-height: #{conditions[:max][:height]}px)" if conditions[:max][:height]
    end

    if conditions[:min]
      condition_strings << "(min-width: #{conditions[:min][:width]}px)" if conditions[:min][:width]
      condition_strings << "(min-height: #{conditions[:min][:height]}px)" if conditions[:min][:height]
    end

    operator = conditions[:operator] == :and ? 'and' : 'or'

    # Convert properties to apply
    property_strings = []
    apply.each do |key, values|
      inner_properties = []
      values.each do |property, value|
        if property == :color
          inner_properties << "background-color: #{value} !important;"
        else
          inner_properties << "#{property}: #{value}px !important;" if value.is_a?(Integer)
          inner_properties << "#{property}: #{value} !important;" if value.is_a?(Symbol)
        end
      end
      # Prefix each key with "#"
      property_strings << "##{key} {\n#{inner_properties.join("\n")}\n}"
    end

    # let it build
    css = "@media #{condition_strings.join(" #{operator} ")} {\n#{property_strings.join("\n")}\n}"
    add_css_to_atomic_style(css)
    css
  end

  def css_to_data(css)
    data = {
      :condition => {},
      :apply => {}
    }
    # Extract conditions
    media_conditions = css.match(/@media ([^\{]+)/)[1].split(',').map(&:strip)
    media_conditions.each do |condition|
      type = condition.match(/(max|min)-/)[1].to_sym
      property = condition.match(/(width|height)/)[1].to_sym
      value = condition.match(/(\d+)/)[1].to_i

      data[:condition][type] ||= {}
      data[:condition][type][property] = value
    end

    # Extract properties to be applied
    css.scan(/(\w+) \{([^\}]+)\}/).each do |match|
      key = match[0].to_sym
      properties = match[1].split(';').map(&:strip).reject(&:empty?)

      data[:apply][key] ||= {}
      properties.each do |property|
        prop, value = property.split(':').map(&:strip)
        if prop == 'background-color'
          data[:apply][key][:color] = value.to_sym
        elsif value[-2..] == 'px'
          data[:apply][key][prop.to_sym] = value.to_i
        else
          data[:apply][key][prop.to_sym] = value.to_sym
        end
      end
    end

    data
  end

  def extract_properties(properties_string)
    properties_hash = {}
    properties = properties_string.split(';').map(&:strip).reject(&:empty?)
    properties.each do |property|
      key, value = property.split(':').map(&:strip)
      properties_hash[key] = value
    end
    properties_hash
  end

  def get_page_style
    main_view = JS.global[:document].getElementById('view')
    main_view_content = main_view[:innerHTML].to_s
    style_tags = main_view_content.split(/<\/?style[^>]*>/i).select.with_index { |_, index| index.odd? }
    style_tags = style_tags.join('')
    style_tags = style_tags.split("\n")
    hash_result = {}
    inside_media = false
    media_hash = {}

    style_tags.each do |line|
      line = line.strip
      next if line.empty? || line.start_with?('/*')

      if inside_media
        if line == '}'
          hash_result['@media'] << media_hash
          inside_media = false
          next
        end

        selector, properties = line.split('{').map(&:strip)
        next unless properties&.end_with?('}')

        properties = properties[0...-1].strip
        media_hash[selector] = extract_properties(properties)
      elsif line.start_with?('@media')
        media_content = line.match(/@media\s*\(([^)]+)\)\s*{/)
        next unless media_content

        media_query = media_content[1]
        hash_result['@media'] = [media_query]
        inside_media = true
      else
        selector, properties = line.split('{').map(&:strip)
        next unless properties&.end_with?('}')

        properties = properties[0...-1].strip
        hash_result[selector] = extract_properties(properties)
      end
    end
    hash_result
  end

  def markup(new_tag, _usr_bloc)
    element_id = @id.to_s
    js_code = <<~JAVASCRIPT
      let element = document.getElementById('#{element_id}');
      if (!element) {
          console.error(`Element with id "${'#{element_id}'}" not found.`);
          return;
      }
      let newElement = document.createElement('#{new_tag}');

      newElement.style.cssText = element.style.cssText;
      Array.from(element.attributes).forEach(attr => {
          newElement.setAttribute(attr.name, attr.value);
      });
      newElement.innerHTML = element.innerHTML;
      element.parentNode.replaceChild(newElement, element);
    JAVASCRIPT
    JS.eval(js_code)
  end

  def hyperedit(params, usr_bloc)
    html_object = JS.global[:document].getElementById(params.to_s)
    particles_from_style = {}
    # we get all the styles tag present in the page
    get_page_style
    if html_object[:className].to_s
      classes_found = html_object[:className].to_s.split(' ')
      classes_found.each do |class_found|
        if get_page_style[".#{class_found}"]
          particles_from_style = particles_from_style.merge(get_page_style[".#{class_found}"])
        end
      end
    end

    particles_found = {}
    particles_found[:data] = html_object[:innerText].to_s.chomp
    particles_found[:markup] = html_object[:tagName].to_s

    style_found = html_object[:style][:cssText].to_s

    style_found.split(';').each do |pair|
      key, value = pair.split(':').map(&:strip)
      particles_from_style[key.to_sym] = value if key && value
    end

    particles_found = particles_found.merge(particles_from_style)
    usr_bloc.call(particles_found)

  end

  def match(params)
    css_converted = convert_to_css(params)
    css_to_data(css_converted)
  end

  def connect(params, &bloc)
    type = params[:type]
    server = params[:address]

    JS.eval("atomeJS.connect('#{type}','#{server}')")

  end

  def transform_to_string_keys_and_values(hash)
    hash.transform_keys(&:to_s).transform_values do |value|
      if value.is_a?(Hash)
        transform_to_string_keys_and_values(value)
      else
        value.to_s
      end
    end
  end

  def send_message(message)
    # puts "message : #{message}"
    # FIXME  : find why we have to sanitize this message when using ruby wams
    message = transform_to_string_keys_and_values(message)
    JS.eval("atomeJS.ws_sender('#{message}')")
  end

  def close_websocket
    @websocket.close
  end

  # map
  def location(loc_found)
    if loc_found[:longitude] && loc_found[:latitude]
      long_f = loc_found[:longitude]
      lat_f = loc_found[:latitude]
      js_code = <<~JAVASCRIPT
                 const locatorElement = document.getElementById('#{@id}');
        if (!locatorElement._leaflet_map) {
            const map = L.map('#{@id}').setView([51.505, -0.09], 2); // Centrer initialement sur une position par défaut
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);
            locatorElement._leaflet_map = map;

            if ('#{long_f}' === 'auto' || '#{lat_f}' === 'auto') {
                function onLocationFound(e) {
                    const radius = e.accuracy / 2;
                    const locationMarker = L.marker(e.latlng).addTo(map)
                        .bindPopup(`You are within ${radius} meters from this point`).openPopup();

                    // Ajouter un ID au marqueur
                    locationMarker._icon.id = '#{@id}_locator';
                    
                    locationMarker.on('click', function() {
                        alert(`You clicked the location marker at ${e.latlng.toString()}`);
                    });

                    const locationCircle = L.circle(e.latlng, radius).addTo(map);
                    map.setView(e.latlng, map.getZoom()); // Centrer la carte sur la position trouvée en conservant le zoom actuel
                }

                function onLocationError(e) {
                    console.log(e.message);
                }

                map.on('locationfound', onLocationFound);
                map.on('locationerror', onLocationError);

                map.locate({ setView: true }); // Tenter de localiser l'utilisateur sans modifier le zoom
            } else {
                const lat = parseFloat('#{lat_f}');
                const long = parseFloat('#{long_f}');
                map.setView([lat, long], map.getZoom()); // Centrer la carte sur les coordonnées fournies en conservant le zoom actuel

                const locationMarker = L.marker([lat, long]).addTo(map)
                    .bindPopup('This is your point').openPopup();

                // Ajouter un ID au marqueur
                locationMarker._icon.id = '#{@id}_locator';
                
                locationMarker.on('click', function() {
                    alert(`You clicked the location marker at [${lat}, ${long}]`);
                });
            }

            // Ecouter l'événement 'load' de la carte pour rafraîchir l'écran et afficher une alerte
            map.whenReady(function() {
                map.invalidateSize();
        // important setimout re-center the view else the view is incorrect (map.invalidateSize() refresh the view)
        setTimeout(function() {
                map.invalidateSize();
        }, 0001);
            });
        } else {
            const map = locatorElement._leaflet_map;
            if ('#{long_f}' !== 'auto' && '#{lat_f}' !== 'auto') {
                const lat = parseFloat('#{lat_f}');
                const long = parseFloat('#{long_f}');
                map.setView([lat, long], map.getZoom()); // Centrer la carte sur les coordonnées fournies en conservant le zoom actuel

                const locationMarker = L.marker([lat, long]).addTo(map)
                    .bindPopup('This is your point').openPopup();

                // Ajouter un ID au marqueur
                locationMarker._icon.id = '#{@id}_locator';
                
                locationMarker.on('click', function() {
                    alert(`You clicked the location marker at [${lat}, ${long}]`);
                });
            }

            // Ecouter l'événement 'load' de la carte pour rafraîchir l'écran et afficher une alerte
            map.whenReady(function() {
            
        setTimeout(function() {
                map.invalidateSize();
        }, 0001);
            });
        }

        // Ecouter l'événement de redimensionnement de la fenêtre pour réinitialiser la taille de la carte et la vue
        window.addEventListener('resize', () => {
            const map = locatorElement._leaflet_map;
        setTimeout(function() {
                map.invalidateSize();
        }, 0001);
        });



      JAVASCRIPT
      JS.eval(js_code)

    end
  end

  def map_zoom(params)
    js_code = <<~JAVASCRIPT
      const locatorElement = document.getElementById('#{@id}');
            const map = locatorElement._leaflet_map;
                map.setZoom(#{params});
    JAVASCRIPT
    JS.eval(js_code)
  end

  def map_pan(params)
    left_found = params[:left] || 0
    top_found = params[:top] || 0
    js_code = <<~JAVASCRIPT
      const locatorElement = document.getElementById('#{@id}');
            const map = locatorElement._leaflet_map;
                 map.panBy([#{left_found}, #{top_found}], { animate: true });
    JAVASCRIPT
    JS.eval(js_code)
  end

  # meteo
  def meteo_helper(data)
    grab(@id).instance_variable_get('@meteo_code')[:meteo].call(data)
  end

  def meteo(location)
    js_code = <<~JAVASCRIPT
      const url = 'https://api.openweathermap.org/data/2.5/weather?q=#{location},fr&appid=c21a75b667d6f7abb81f118dcf8d4611&units=metric';
      async function fetchWeather() {
          try {
              let response = await fetch(url);

              if (!response.ok) {
                  throw new Error('Erreur HTTP ! statut : ' + response.status);
              }

              let data = await response.json();


      let jsonString = JSON.stringify(data);
      atomeJsToRuby("grab('#{@id}').html.meteo_helper("+jsonString+")");
          } catch (error) {
              console.log('Error getting meteo : ' + error.message);
          }
      }

      fetchWeather();
    JAVASCRIPT
    JS.eval(js_code)
  end

  def attr(attribute, value)
    @element.setAttribute(attribute.to_s, value.to_s)
    self
  end

  def add_class(class_to_add)
    @element[:classList].add(class_to_add.to_s)
    self
  end

  def remove_class(class_to_remove)
    @element[:classList].remove(class_to_remove.to_s)
    self
  end

  def id(id)
    attr('id', id)
    self
  end

  def check_double(id)
    # we remove any element if the id already exist
    element_to_delete = JS.global[:document].getElementById(id.to_s)
    delete(id) unless element_to_delete.inspect == 'null'
  end

  def editor(id)
    check_double(id)
    editor_id = "#{id}_editor"
    check_double(editor_id)
    markup_found = @original_atome.markup || :textarea
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  # def editor(id)
  #   check_double(id)
  #   editor_id = "#{id}_editor"
  #   check_double(editor_id)
  #   markup_found = @original_atome.markup || :div
  #   @element_type = markup_found.to_s
  #   @element = JS.global[:document].createElement(@element_type)
  #  @element.setAttribute('style', 'font-size: 12px;')
  #
  #   JS.global[:document][:body].appendChild(@element)
  #   add_class('atome')
  #   id(id)
  #   textarea = JS.global[:document].createElement('textarea')
  #   textarea.setAttribute('id', editor_id)
  #   wait 0.1 do
  #     @element.appendChild(textarea)
  #   end
  #   self
  # end

  def shape(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :div
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  def draw(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :canvas
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  def text(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :pre
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    id(id)
    self
  end

  def select_text(range)
    # TODO : use atome color object  instead of basic css color
    back_color = grab(:back_selection)
    text_color = grab(:text_selection)

    back_color_rgba = "rgba(#{back_color.red * 255},#{back_color.green * 255},#{back_color.blue * 255}, #{back_color.alpha})"
    text_color_rgba = "rgba(#{text_color.red * 255},#{text_color.green * 255},#{text_color.blue * 255}, #{text_color.alpha})"

    range = JS.global[:document].createRange()
    range.selectNodeContents(@element)
    selection = JS.global[:window].getSelection()
    selection.removeAllRanges()
    selection.addRange(range)
    @element.focus()
    style = JS.global[:document].createElement('style')
    style[:innerHTML] = "::selection { background-color: #{back_color_rgba}; color: #{text_color_rgba}; }"
    JS.global[:document][:head].appendChild(style)
    return unless @element[:innerText].to_s.length == 1

    @element[:innerHTML] = '&#8203;'
  end

  def image(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :img
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)

    self
  end

  def video(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :video
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)
    self
  end

  def audio(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :audio
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)
    self
  end

  def vr(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :div
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    self.id(id)

    self
  end

  def vr_path(objet_path)
    js_code = <<~JAVASCRIPT
      initWithParam('#{objet_path}', '#{@id}', 'method', 'params');
    JAVASCRIPT

    JS.eval(js_code)
    # tags = <<~HTML
    #   <a-scene embedded>
    #     <a-sky src="#{objet_path}" rotation="0 -130 0"></a-sky>
    #     <a-text font="kelsonsans" value="Puy de Sancy, France" width="6" position="-2.5 0.25 -1.5" rotation="0 15 0"></a-text>
    #     <!-- Hotspot -->
    #     <a-sphere id="clickable" color="#FF0000" radius="0.1" position="0 1 -2"
    #               event-set__mouseenter="_event: mouseenter; color: green"
    #               event-set__mouseleave="_event: mouseleave; color: red"></a-sphere>
    #     <!-- Camera with cursor to detect clicks -->
    #   </a-scene>
    # HTML
    # @element[:innerHTML] = tags
    #
    # # Ajouter un écouteur d'événement pour le hotspot
    # cursor = JS.global[:document].getElementById('cursor')
    # cursor.addEventListener('click', -> {
    #   target = cursor.components.cursor.intersectedEl
    #   if target && target.id == 'clickable'
    #     alert :yes
    #   end
    # })

  end

  def www(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || :iframe
    @element_type = markup_found.to_s
    @element = JS.global[:document].createElement(@element_type)
    JS.global[:document][:body].appendChild(@element)
    add_class('atome')
    @element.setAttribute('src', 'https://www.youtube.com/embed/lLeQZ8Llkso?si=MMsGBEXELy9yBl9R')
    self.id(id)
    self
  end

  def raw(id)
    # we remove any element if the id already exist
    check_double(id)
    @element = JS.global[:document].createElement('div')
    add_class('atome')
    self.id(id)
    JS.global[:document][:body].appendChild(@element)
    self
  end

  def svg(id)
    # we remove any element if the id already exist
    check_double(id)
    markup_found = @original_atome.markup || 'svg'
    @element_type = markup_found.to_s
    svg_ns = 'http://www.w3.org/2000/svg'
    @element = JS.global[:document].createElementNS(svg_ns, 'svg')
    JS.global[:document][:body].appendChild(@element)
    @element.setAttribute('viewBox', '0 0 1024 1024')
    @element.setAttribute('version', '1.1')
    add_class('atome')
    self.id(id)
    self
  end

  def svg_data(all_datas)
    all_datas.each do |full_data|
      full_data.each do |type_passed, datas|

        svg_ns = 'http://www.w3.org/2000/svg'
        new_path = JS.global[:document].createElementNS(svg_ns.to_s, type_passed.to_s)
        JS.global[:document][:body].appendChild(new_path)
        datas.each do |property, value|
          new_path.setAttribute(property.to_s, value.to_s)
        end
        @element.appendChild(new_path)
      end
    end
  end

  def update_svg_data(data)
    data.each do |type_passed, datas|
      element_to_update = JS.global[:document].getElementById(type_passed.to_s)
      datas.each do |property, value|
        element_to_update.setAttribute(property.to_s, value.to_s)
      end
    end
  end

  def colorize_svg_data(data)
    command = <<-JS
       let svgElement = document.getElementById("#{@id}");
      if (!svgElement) {
        return [];
      }
      var children = svgElement.children;
      var ids = [];
      for (var i = 0; i < children.length; i++) {
        var element = document.getElementById(children[i].id); // Récupérer l'élément par son ID
        if (element) {
            element.setAttribute('fill', '#{data}'); // Modifier l'attribut fill
            element.setAttribute('stroke', '#{data}'); // Modifier l'attribut stroke
        }
        ids.push(children[i].id);
      }
  return ids
    JS
    JS.eval(command)
  end

  def raw_data(html_string)
    @element[:innerHTML] = html_string
  end

  def video_path(video_path, type = 'video/mp4')
    source = JS.global[:document].createElement('source')
    source.setAttribute('src', video_path)
    source.setAttribute('type', type)
    @element.appendChild(source)
  end

  def sanitize_text(text)
    text.to_s
        .gsub('&', "\&")
        .gsub('<', "\<")
        .gsub('>', "\>")
        .gsub('"', '"')
        .gsub("'", "\'")
  end

  def innerText(data)
    sanitized_data = sanitize_text(data.to_s)
    @element[:innerText] = sanitized_data
  end

  def textContent(data)
    @element[:textContent] = data
  end

  def path(objet_path)
    @element.setAttribute('src', objet_path)
    # below we get image to feed width and height if needed
    @element[:src] = objet_path
    @element[:onload] = lambda do |_event|
      @element[:width]
      @element[:height]
    end
  end

  def transform(property, value = nil)
    transform_needed = "#{property}(#{value}deg)"
    @element[:style][:transform] = transform_needed.to_s
  end

  def style(property, value = nil)
    if value
      @element[:style][property] = value.to_s
    elsif value.nil?
      @element[:style][property]
    else
      # If value is explicitly set to false, remove the property
      command = "document.getElementById('#{@id}').style.removeProperty('#{property}')"
      JS.eval(command)
    end
  end

  def fill(params)
    # we remove previous background
    elements_to_remove = @element.getElementsByClassName('background')

    elements_to_remove = elements_to_remove.to_a
    elements_to_remove.each do |child|
      @element.removeChild(child)
    end
    params.each do |param|
      background_layer = JS.global[:document].createElement("div")
      background_layer[:style][:transform] = "rotate(#{param[:rotate]}deg)" # Applique une rotation de 45 degrés à l'élément
      background_layer[:style][:position] = "absolute"

      if param[:position]
        background_layer[:style][:top] = "#{param[:position][:x]}px"
        background_layer[:style][:left] = "#{param[:position][:y]}px"
      else
        background_layer[:style][:top] = "0"
        background_layer[:style][:left] = "0"
      end

      if param[:size]
        background_layer[:style][:width] = "#{param[:size][:x]}px"
        background_layer[:style][:height] = "#{param[:size][:y]}px"
      else
        background_layer[:style][:width] = "100%"
        background_layer[:style][:height] = "100%"
      end

      atome_path = grab(param[:atome]).path
      background_layer[:style][:backgroundImage] = "url('#{atome_path}')"
      background_layer[:style][:backgroundRepeat] = 'repeat'
      background_layer[:className] = 'background'
      background_layer[:style][:opacity] = param[:opacity]
      if param[:repeat]
        img_width = @original_atome.width / param[:repeat][:x]
        img_height = @original_atome.height / param[:repeat][:y]
        background_layer[:style][:backgroundSize] = "#{img_width}px #{img_height}px"
      else
        background_layer[:style][:backgroundSize] = "#{param[:width]}px #{param[:height]}px"
      end
      @element.appendChild(background_layer)
    end
  end

  def filter(property, value)
    filter_needed = "#{property}(#{value})"
    @element[:style][:filter] = filter_needed
  end

  def backdropFilter(property, value)
    filter_needed = "#{property}(#{value})"
    @element[:style][:"-webkit-backdrop-filter"] = filter_needed
  end

  def currentTime(time)
    @element[:currentTime] = time
  end

  def animation_frame_callback(proc_pass, play_content)
    JS.global[:window].requestAnimationFrame(-> (timestamp) {
      current_time = @element[:currentTime]
      fps = 30
      current_frame = (current_time.to_f * fps).to_i
      @original_atome.instance_exec({ frame: current_frame, time: current_time }, &proc_pass) if proc_pass.is_a? Proc
      # we update play instance variable so if user ask for atome.play it will return current frame
      play_content[:play] = current_frame
      animation_frame_callback(proc_pass, play_content)
    })
  end

  def action(_particle, action_found, option = nil)

    if action_found == :stop
      currentTime(option)
      @element.pause
    elsif action_found == :pause
      @element.pause
    else
      currentTime(option)
      proc_found = @original_atome.instance_variable_get('@play_code')[action_found]
      play_content = @original_atome.instance_variable_get('@play')
      animation_frame_callback(proc_found, play_content)
      @element.play
    end
  end

  def append_to(parent_id_found)
    parent_found = JS.global[:document].getElementById(parent_id_found.to_s)
    parent_found.appendChild(@element)
    self
  end

  def delete(id_to_delete)
    element_to_delete = JS.global[:document].getElementById(id_to_delete.to_s)
    return unless element_to_delete.to_s != 'null'
    return unless element_to_delete
    element_to_delete.remove
  end

  def append(child_id_found)
    child_found = JS.global[:document].getElementById(child_id_found.to_s)
    @element.appendChild(child_found)
    self
  end

  # events handlers
  def on(property, _option)
    property = property.to_s

    if property.start_with?('media:')
      # extract request from property
      media_query = property.split(':', 2).last

      mql = JS.global[:window].matchMedia(media_query)

      event_handler = ->(event) do
        bloc = @original_atome.instance_variable_get('@on_code')[:view_resize]
        proc_content = bloc.call({ matches: event[:matches] }) if event_validation(bloc)
        if proc_content.instance_of? Hash
          proc_content.each do |k, v|
            @original_atome.send(k, v)
          end
        end
      end

      # add a listener to matchMedia object
      mql.addListener(event_handler)

    elsif property == 'resize'
      unless @on_resize_already_set
        event_handler = ->(event) do
          width = JS.global[:window][:innerWidth]
          height = JS.global[:window][:innerHeight]
          blocs = @original_atome.instance_variable_get('@on_code')[:view_resize]
          blocs.each do |bloc|
            proc_content = bloc.call({ width: width, height: height }) if event_validation(bloc)
            if proc_content.instance_of? Hash
              proc_content.each do |k, v|
                @original_atome.send(k, v)
              end
            end
          end
        end

        JS.global[:window].addEventListener('resize', event_handler)
      end
      @on_resize_already_set = true
    elsif property == 'remove'
      alert 'ok'
      @original_atome.instance_variable_get('@on_code')[:view_resize] = []
    else
      event_handler = ->(event) do
        proc_content = bloc.call(event) if event_validation(bloc)
        if proc_content.instance_of? Hash
          proc_content.each do |k, v|
            @original_atome.send(k, v)
          end
        end
      end
      @element.addEventListener(property, event_handler)
    end
  end

  def keyboard_press(_option)
    @keyboard_press = @original_atome.instance_variable_get('@keyboard_code')[:press]

    keypress_handler = ->(native_event) do

      event = Native(native_event)
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      proc_content = @keyboard_press.call(event) if event_validation(@keyboard_press)
      if proc_content.instance_of? Hash
        proc_content.each do |k, v|
          @original_atome.send(k, v)
        end
      end
    end
    @element.addEventListener('keypress', keypress_handler)
  end

  def keyboard_down(_option)
    @keyboard_down = @original_atome.instance_variable_get('@keyboard_code')[:down]

    keypress_handler = ->(event) do
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      proc_content = @keyboard_down.call(event) if event_validation(@keyboard_down)
      if proc_content.instance_of? Hash
        proc_content.each do |k, v|
          @original_atome.send(k, v)
        end
      end
    end
    @element.addEventListener('keydown', keypress_handler)
  end

  def keyboard_up(_option)
    @keyboard_up = @original_atome.instance_variable_get('@keyboard_code')[:up]

    keypress_handler = ->(event) do
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      proc_content = @keyboard_up.call(event) if event_validation(@keyboard_up)
      if proc_content.instance_of? Hash
        proc_content.each do |k, v|
          @original_atome.send(k, v)
        end
      end
    end
    @element.addEventListener('keyup', keypress_handler)
  end

  def keyboard_remove(option)
    case option
    when :down
      @keyboard_down = ''
    when :up
      @keyboard_up = ''
    when :down
      @keyboard_press = ''
    else
      @keyboard_down = ''
      @keyboard_up = ''
      @keyboard_press = ''
    end
  end

  # def drag_code(params = nil)
  #   # FIXME : this method is an ugly patch when refreshing an atome twice, else it crash
  #   # and lose it's drag
  #   drag_move(params)
  # end

  def event(action, variance, option = nil)
    send("#{action}_#{variance}", option)
  end

  def restrict_movement(restricted_x, restricted_y)
    @original_atome.left(restricted_x)
    @original_atome.top(restricted_y)
  end

  def drag_move(_option)

    unless @drag_move_already_set
      # the condition below prevent drag accumulation
      interact = JS.eval("return interact('##{@id}')")

      unless @draggable
        interact.draggable({
                             drag: true,
                             inertia: { resistance: 12,
                                        minSpeed: 200,
                                        endSpeed: 100 },
                           })
        unless @first_drag
          interact.on('dragmove') do |native_event|
            drag_moves = @original_atome.instance_variable_get('@drag_code')[:move]

            # the use of Native is only for Opal (look at lib/platform_specific/atome_wasm_extensions.rb for more infos)
            event = Native(native_event)
            # we use .call instead of instance_eval because instance_eval bring the current object as context
            # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
            # group etc..
            drag_moves.each do |drag_move|
              proc_content = drag_move.call(event) if event_validation(drag_move)
              if proc_content.instance_of? Hash
                proc_content.each do |k, v|
                  @original_atome.send(k, v)
                end
              end
            end

            Universe.allow_tool_operations = false
            dx = event[:dx]
            dy = event[:dy]
            x = (@original_atome.left || 0) + dx.to_f
            y = (@original_atome.top || 0) + dy.to_f
            @original_atome.left(x)
            @original_atome.top(y)
          end

        end
      end
      @first_drag = true
      @draggable = true
    end
    @drag_move_already_set = true

  end

  def drag_restrict(option)

    unless @drag_restrict_already_set
      interact = JS.eval("return interact('##{@id}')")
      interact.draggable({
                           drag: true,
                           inertia: { resistance: 12,
                                      minSpeed: 200,
                                      endSpeed: 100 },
                         })

      if option.instance_of? Hash
        max_left = grab(:view).to_px(:width)
        max_top = grab(:view).to_px(:height)
        min_left = 0
        min_top = 0

        if option[:max]
          max_left = option[:max][:left] || max_left
          max_top = option[:max][:top] || max_top
        else
          max_left
          max_top
        end
        if option[:min]
          min_left = option[:min][:left] || min_left
          min_top = option[:min][:top] || min_top
        else
          min_left
          min_top
        end
      else
        parent_found = grab(option)
        min_left = parent_found.left
        min_top = parent_found.top
        parent_width = parent_found.compute({ particle: :width })[:value]
        parent_height = parent_found.compute({ particle: :height })[:value]
        original_width = @original_atome.width
        original_height = @original_atome.height
        max_left = min_left + parent_width - original_width
        max_top = min_top + parent_height - original_height
      end

      interact.on('dragmove') do |native_event|
        drag_moves = @original_atome.instance_variable_get('@drag_code')[:restrict]

        # the use of Native is only for Opal (look at lib/platform_specific/atome_wasm_extensions.rb for more infos)
        event = Native(native_event)
        # we use .call instead of instance_eval because instance_eval bring the current object as context
        # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
        # group etc..
        drag_moves.each do |drag_move|
          proc_content = drag_move.call(event) if event_validation(drag_move)
          if proc_content.instance_of? Hash
            proc_content.each do |k, v|
              @original_atome.send(k, v)
            end
          end
        end

        dx = event[:dx]
        dy = event[:dy]
        x = (@original_atome.left || 0) + dx.to_f
        y = (@original_atome.top || 0) + dy.to_f
        restricted_x = [[x, min_left].max, max_left].min
        restricted_y = [[y, min_top].max, max_top].min
        restrict_movement(restricted_x, restricted_y)
      end
    end
    @drag_restrict_already_set = true

  end

  def drag_start(_option)
    unless @drag_start_already_set
      interact = JS.eval("return interact('##{@id}')")
      interact.on('dragstart') do |native_event|
        drag_starts = @original_atome.instance_variable_get('@drag_code')[:start]
        event = Native(native_event)
        # we use .call instead of instance_eval because instance_eval bring the current object as context
        # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
        # group etc..
        drag_starts.each do |drag_start|
          proc_content = drag_start.call(event) if event_validation(drag_start)
          if proc_content.instance_of? Hash
            proc_content.each do |k, v|
              @original_atome.send(k, v)
            end
          end
        end
      end
    end
    @drag_start_already_set = true
  end

  def drag_end(_option)

    unless @drag_end_already_set
      interact = JS.eval("return interact('##{@id}')")
      interact.on('dragend') do |native_event|
        drag_ends = @original_atome.instance_variable_get('@drag_code')[:end]
        event = Native(native_event)
        # we use .call instead of instance_eval because instance_eval bring the current object as context
        # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
        # group etc..
        drag_ends.each do |drag_end|
          proc_content = drag_end.call(event) if event_validation(drag_end)
          if proc_content.instance_of? Hash
            proc_content.each do |k, v|
              @original_atome.send(k, v)
            end
          end
        end

      end
    end
    @drag_end_already_set = true

  end

  def drag_locked(_option)
    unless @drag_locked_already_set
      interact = JS.eval("return interact('##{@id}')")
      interact.draggable({
                           drag: true,
                           inertia: { resistance: 12,
                                      minSpeed: 200,
                                      endSpeed: 100 }
                         })

      interact.on('dragmove') do |native_event|
        drag_locks = @original_atome.instance_variable_get('@drag_code')[:locked]
        # the use of Native is only for Opal (look at lib/platform_specific/atome_wasm_extensions.rb for more infos)
        event = Native(native_event)
        # we use .call instead of instance_eval because instance_eval bring the current object as context
        # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
        # group etc..
        drag_locks.each do |drag_lock|
          proc_content = drag_lock.call(event) if event_validation(drag_lock)
          if proc_content.instance_of? Hash
            proc_content.each do |k, v|
              @original_atome.send(k, v)
            end
          end
        end
      end
    end
    @drag_locked_already_set = true

  end

  def remove_this_drag(option)
    @original_atome.instance_variable_get('@drag_code')[option] = [] if @original_atome.instance_variable_get('@drag_code')
  end

  def drag_remove(_opt)

    interact = JS.eval("return interact('##{@id}')")
    if @original_atome.instance_variable_get('@drag_code')
      options = @original_atome.instance_variable_get('@drag_code')[:remove]
    else
      options = false
    end

    options.each do |option|
      if option.instance_of? Array
        option.each do |opt|
          remove_this_drag(opt)
        end
        return false
      end
      @element[:style][:cursor] = 'default'

      @draggable = nil
      case option
      when :start
        remove_this_drag(:start)
      when :end, :stop
        remove_this_drag(:end)
        remove_this_drag(:stop)
      when :move
        remove_this_drag(:move)
      when :locked
        remove_this_drag(:locked)
      when :restrict
        remove_this_drag(:restrict)
      else
        interact.draggable(false)

      end
    end

  end

  def drop_common(method, native_event)
    event = Native(native_event)
    draggable_element = event[:relatedTarget][:id].to_s
    dropzone_element = event[:target][:id].to_s
    # we use .call instead of instance_eval because instance_eval bring the current object as context
    # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
    # group etc..
    proc_contents = @original_atome.instance_variable_get('@drop_code')[method]
    proc_contents.each do |proc_content|
      proc_content = proc_content.call({ source: draggable_element, destination: dropzone_element }) if event_validation(proc_content)
      return unless proc_content.instance_of? Hash
      proc_content.each do |k, v|
        @original_atome.send(k, v)
      end
    end
  end

  def drop_activate(_option)
    unless @drop_activate_already_set
      interact = JS.eval("return interact('##{@id}')")
      interact.dropzone({
                          accept: nil, # Accept any element
                          overlap: 0.75,
                          ondropactivate: lambda do |native_event|
                            drop_common(:activate, native_event)
                          end
                        })
    end

    @drop_activate_already_set = true
  end

  def drop_dropped(_option)
    unless @drop_dropped_already_set
      interact = JS.eval("return interact('##{@id}')")
      interact.dropzone({
                          overlap: 0.75,
                          # FIXME : remove because os an opal bug since 1.8 reactivate when opal will be debbuged
                          ondrop: lambda do |native_event|
                            drop_common(:dropped, native_event)
                          end
                        })

    end
    @drop_dropped_already_set = true
  end

  def drop_enter(_option)
    unless @drop_enter_already_set
      interact = JS.eval("return interact('##{@id}')")
      interact.dropzone({
                          overlap: 0.001,
                          # FIXME : remove because os an opal bug since 1.8 reactivate when opal will be debbuged
                          ondragenter: lambda do |native_event|
                            drop_common(:enter, native_event)
                          end
                        })
    end
    @drop_enter_already_set = true
  end

  def drop_leave(_option)
    unless @drop_leave_already_set
      interact = JS.eval("return interact('##{@id}')")
      interact.dropzone({
                          # FIXME : remove because os an opal bug since 1.8 reactivate when opal will be debbuged
                          ondragleave: lambda do |native_event|
                            drop_common(:leave, native_event)
                          end
                        })
    end

    @drop_leave_already_set = true

  end

  def drop_deactivate(_option)
    unless @drop_remove_already_set

      interact = JS.eval("return interact('##{@id}')")
      interact.dropzone({
                          # accept: nil, # Accept any element
                          # FIXME : remove because os an opal bug since 1.8 reactivate when opal will be debbuged
                          ondropdeactivate: lambda do |native_event|
                            drop_common(:deactivate, native_event)
                          end
                        })

    end
    @drop_remove_already_set = true
  end

  def drop_remove(option)
    case option
    when :activate
      @original_atome.instance_variable_get('@drop_code')[:activate] = []
    when :deactivate
      @original_atome.instance_variable_get('@drop_code')[:deactivate] = []
    when :dropped
      @original_atome.instance_variable_get('@drop_code')[:dropped] = []
    when :enter
      @original_atome.instance_variable_get('@drop_code')[:enter] = []
    when :leave
      @original_atome.instance_variable_get('@drop_code')[:leave] = []
    else
      drop_remove(:activate)
      drop_remove(:deactivate)
      drop_remove(:dropped)
      drop_remove(:enter)
      drop_remove(:leave)
    end

  end

  def resize(params, options)
    interact = JS.eval("return interact('##{@id}')")

    # Désactiver explicitement le déplacement
    # interact.draggable(false)

    if params == :remove
      @resize = ''
      interact.resizable(false)
    else
      min_width = options[:min][:width] || 10
      min_height = options[:min][:height] || 10
      max_width = options[:max][:width] || 3000
      max_height = options[:max][:height] || 3000
      @resize = @original_atome.instance_variable_get('@resize_code')[:resize]

      interact.resizable({
                           edges: { left: true, right: true, top: true, bottom: true },
                           inertia: true,
                           modifiers: [],
                           listeners: {
                             move: lambda do |native_event|
                               Universe.allow_tool_operations = false

                               event = Native(native_event)
                               proc_content = @resize.call(event) if event_validation(@resize)
                               if proc_content.instance_of? Hash
                                 proc_content.each do |k, v|
                                   @original_atome.send(k, v)
                                 end
                               end

                               x = (@element[:offsetLeft].to_i || 0)
                               y = (@element[:offsetTop].to_i || 0)
                               width = event[:rect][:width]
                               height = event[:rect][:height]

                               # Translate when resizing from any corner
                               x += event[:deltaRect][:left].to_f
                               y += event[:deltaRect][:top].to_f

                               @original_atome.width width.to_i if width.to_i.between?(min_width, max_width)
                               @original_atome.height height.to_i if height.to_i.between?(min_height, max_height)
                               @original_atome.left(x)
                               @original_atome.top(y)
                             end,
                           },
                         })

    end

  end

  def overflow(params, bloc)
    style(:overflow, params)
    @overflow = @original_atome.instance_variable_get('@overflow_code')[:overflow]
    @element.addEventListener('scroll', lambda do |native_event|
      scroll_top = @element[:scrollTop].to_i
      scroll_left = @element[:scrollLeft].to_i
      # we use .call instead of instance_eval because instance_eval bring the current object as context
      # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
      # group etc..
      @overflow.call({ left: scroll_left, top: scroll_top }) if event_validation(@overflow)

      proc_content = @overflow.call({ left: scroll_left, top: scroll_top }) if event_validation(@overflow)
      if proc_content.instance_of? Hash
        proc_content.each do |k, v|
          @original_atome.send(k, v)
        end
      end
    end)
  end

  def over_over(_option)
    return if @over_over_already_set
    @element.addEventListener('mouseover') do |native_event|
      over_options = @original_atome.instance_variable_get('@over_code')[:flyover]
      event = Native(native_event)
      over_options.each do |over_option|
        proc_content = over_option.call(event) if event_validation(over_option)
        if proc_content.instance_of? Hash
          proc_content.each do |k, v|
            @original_atome.send(k, v)
          end
        end
      end
    end
    @over_over_already_set = true
    # unless @over_over_already_set
    #   interact = JS.eval("return interact('##{@id}')")
    #   over_overs = @original_atome.instance_variable_get('@over_code')[:flyover]
    #   # return unless over_overs
    #   over_overs.each do |over_over|
    #     interact.on('mouseover') do |native_event|
    #       over_over_event = Native(native_event)
    #       # we use .call instead of instance_eval because instance_eval bring the current object as context
    #       # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
    #       # group etc..
    #
    #       proc_content = over_over.call(over_over_event) if event_validation(over_over)
    #       if proc_content.instance_of? Hash
    #         proc_content.each do |k, v|
    #           @original_atome.send(k, v)
    #         end
    #       end
    #     end
    #   end
    # end
    # @over_over_already_set = true
  end

  def over_enter(_option)
    return if @over_enter_already_set
    @element.addEventListener('mouseenter') do |native_event|
      over_options = @original_atome.instance_variable_get('@over_code')[:enter]
      event = Native(native_event)
      over_options.each do |over_option|
        proc_content = over_option.call(event) if event_validation(over_option)
        if proc_content.instance_of? Hash
          proc_content.each do |k, v|
            @original_atome.send(k, v)
          end
        end
      end
    end
    @over_enter_already_set = true
    # unless @over_enter_already_set
    #   over_enters = @original_atome.instance_variable_get('@over_code')[:enter]
    #   # return unless over_enters
    #
    #   over_enters.each do |over_enter|
    #     @over_enter_callback = lambda do |event|
    #       # we use .call instead of instance_eval because instance_eval bring the current object as context
    #       # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
    #       # group etc..
    #       proc_content = over_enter.call(event) if event_validation(over_enter)
    #       if proc_content.instance_of? Hash
    #         proc_content.each do |k, v|
    #           @original_atome.send(k, v)
    #         end
    #       end
    #     end
    #     @element.addEventListener('mouseenter', @over_enter_callback)
    #
    #   end
    #
    # end
    # @over_enter_already_set = true

  end

  def over_leave(_option)
    return if @over_leave_already_set
    @element.addEventListener('mouseleave') do |native_event|
      over_leaves = @original_atome.instance_variable_get('@over_code')[:leave]
      event = Native(native_event)
      over_leaves.each do |over_leave|
        proc_content = over_leave.call(event) if event_validation(over_leave)
        if proc_content.instance_of? Hash
          proc_content.each do |k, v|
            @original_atome.send(k, v)
          end
        end
      end
    end
    @over_leave_already_set = true
  end

  def over_remove(option)
    case option
    when :enter
      @original_atome.instance_variable_get('@over_code')[:enter] = []
    when :leave
      @original_atome.instance_variable_get('@over_code')[:leave] = []
    when :over
      @original_atome.instance_variable_get('@over_code')[:flyover] = []
    else
      over_remove(:enter)
      over_remove(:leave)
      over_remove(:over)
    end
  end

  def event_validation(action_proc)
    action_proc.is_a?(Proc) && (!Universe.edit_mode || @original_atome.tag[:system])
  end

  def setup_touch_event(event_type, _option)
    instance_variable = "@touch_#{event_type}_already_set"
    unless instance_variable_get(instance_variable)
      @element[:style][:cursor] = 'pointer'
      interact = JS.eval("return interact('##{@id}')")
      interact.on(event_type) do |native_event|
        touch_event = Native(native_event)
        touch_needed = @original_atome.instance_variable_get('@touch_code')[event_type.to_sym]

        touch_needed.each do |proc_found|
          proc_content = proc_found.call(touch_event) if event_validation(proc_found)
          alert proc_content.class
          if proc_content.instance_of? Hash
            proc_content.each do |k, v|

              @original_atome.send(k, v)
            end
          end
        end
      end
    end
    instance_variable_set(instance_variable, true)
  end

  def touch_down(option)
    setup_touch_event('down', option)
  end

  def touch_up(option)
    setup_touch_event('up', option)
  end

  def touch_tap(option)
    setup_touch_event('tap', option)
  end

  def touch_double(option)
    setup_touch_event('doubletap', option)
  end

  def touch_long(option)
    setup_touch_event('hold', option)
  end

  # def touch_double(_option)
  #   @element[:style][:cursor] = 'pointer'
  #   interact = JS.eval("return interact('##{@id}')")
  #   @touch_double = @original_atome.instance_variable_get('@touch_code')[:double]
  #   # unless @touch_removed[:double]
  #   interact.on('doubletap') do |native_event|
  #     # we use an instance variable below instead of a local variable to be able to kill the event
  #     @touch_double_event = Native(native_event)
  #     # we use .call instead of instance_eval because instance_eval bring the current object as context
  #     # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
  #     # group etc..
  #     proc_content = @touch_double.call(@touch_double_event) if event_validation(@touch_double)
  #     if proc_content.instance_of? Hash
  #       proc_content.each do |k, v|
  #         @original_atome.send(k, v)
  #       end
  #     end
  #   end
  #
  # end

  # def touch_long(_option)
  #   @element[:style][:cursor] = 'pointer'
  #   @touch_long = @original_atome.instance_variable_get('@touch_code')[:long]
  #   interact = JS.eval("return interact('##{@id}')")
  #   # unless @touch_removed[:long]
  #   interact.on('hold') do |native_event|
  #     @touch_long_event = Native(native_event)
  #     # we use .call instead of instance_eval because instance_eval bring the current object as context
  #     # and it's lead to a problem of context and force the use of grab(:view) when suing atome method such as shape ,
  #     # group etc..
  #     proc_content = @touch_long.call(@touch_long_event) if event_validation(@touch_long)
  #     if proc_content.instance_of? Hash
  #       proc_content.each do |k, v|
  #         @original_atome.send(k, v)
  #       end
  #     end
  #   end
  # end
  def remove_this_touch(option)
    @original_atome.instance_variable_get('@touch_code')[option] = [] if @original_atome.instance_variable_get('@touch_code')
  end

  def touch_remove(_opt)
    if @original_atome.instance_variable_get('@touch_code')
      option = @original_atome.instance_variable_get('@touch_code')[:remove]
    else
      option = false
    end

    @element[:style][:cursor] = 'default'
    case option
    when :double
      remove_this_touch(:double)
    when :down
      remove_this_touch(:down)
    when :long
      remove_this_touch(:long)
    when :tap
      remove_this_touch(:tap)
    when :touch
      remove_this_touch(:touch)
    when :up
      remove_this_touch(:up)
    else
      remove_this_touch(:double)
      remove_this_touch(:down)
      remove_this_touch(:long)
      remove_this_touch(:touch)
      remove_this_touch(:double)
      remove_this_touch(:up)
    end

  end

  def internet
    JS.eval('return navigator.onLine')
  end

  def terminal(id, cmd)
    if Atome.host == 'tauri'
      JS.eval("terminal('#{id}','#{cmd}')")
    else
      JS.eval("distant_terminal('#{id}','#{cmd}')")
    end
  end

  def read(id, file)
    if Atome.host == 'tauri'
      JS.eval("readFile('#{id}','#{file}')")
    else
      puts 'read file in progress in server mode'
    end
  end

  def browse(id, file)
    if Atome.host == 'tauri'
      JS.eval("browseFile('#{id}','#{file}')")
    else
      puts 'browse file in progress in server mode'
    end
  end

  def handle_input
    @original_atome.instance_variable_set('@data', @element[:innerText].to_s)
  end

  # this method update the data content of the atome
  def update_data(params)
    # we update the @data of the atome
    @input_listener ||= lambda { |event| handle_input }
    if params
      @element.addEventListener('input', &@input_listener)
    else
      @element.removeEventListener('input', &@input_listener)
    end
  end

  # animation below
  def animate(animation_properties)
    prop = animation_properties[:particle]
    command = <<~JS
                var target_div = document.getElementById('#{@id}');
                window.currentAnimation = popmotion.animate({
                  from: #{animation_properties[:from]},
                  to: #{animation_properties[:to]},
                  duration: #{animation_properties[:duration]},
                  onUpdate: function(v) {
      atomeJsToRuby("grab('#{@id}').animation_callback('#{prop}', "+v+")")
            atomeJsToRuby("grab('#{@id}').#{prop}("+v+")")
                  },
                  onComplete: function(v) {
                    window.currentAnimation = null;
      atomeJsToRuby("grab('#{@id}').animation_callback('#{prop}_end')")
                  }
                });
    JS
    JS.eval(command)
  end

  def stop_animation
    JS.eval('if (window.currentAnimation) window.currentAnimation.stop();')
  end

  # Table manipulation

  def table(data)

    table_html = JS.global[:document].createElement('table')
    thead = JS.global[:document].createElement('thead')

    max_length = data.max_by { |row| row.keys.length }.keys.length

    if @original_atome.option[:header]
      header_row = JS.global[:document].createElement('tr')

      max_length.times do |i|
        th = JS.global[:document].createElement('th')
        th[:textContent] = data.map { |row| row.keys[i].to_s }.compact.first || ''
        header_row.appendChild(th)
      end

      thead.appendChild(header_row)
    end

    table_html.appendChild(thead)
    tbody = JS.global[:document].createElement('tbody')
    data.each_with_index do |row, _row_index|
      tr = JS.global[:document].createElement('tr')

      max_length.times do |cell_index|
        td = JS.global[:document].createElement('td')
        cell_size = set_td_style(td)
        cell_height = cell_size[:cell_height]

        cell_value = row.values[cell_index]
        if cell_value.instance_of? Atome
          cell_value.fit(cell_height)
          html_element = JS.global[:document].getElementById(cell_value.id.to_s)
          td.appendChild(html_element)
          html_element[:style][:transformOrigin] = 'top left'
          html_element[:style][:position] = 'relative'
          cell_value.top(0)
          cell_value.left(0)
        else
          td[:textContent] = cell_value.to_s
        end
        tr.appendChild(td)
      end

      tbody.appendChild(tr)
    end
    table_html.appendChild(tbody)
    JS.global[:document].querySelector("##{@id}").appendChild(table_html)
  end

  # Helper function to handle Atome objects
  def handle_atome(atome, td_element)
    atome.fit(cell_height)
    html_element = JS.global[:document].getElementById(atome.id.to_s)
    td_element.appendChild(html_element)
    html_element[:style][:transformOrigin] = 'top left'
    html_element[:style][:position] = 'relative'
    atome.top(0)
    atome.left(0)
  end

  def refresh_table(_params)
    # first we need to extact all atome from the table or they will be deleted by the table refres
    data = @original_atome.data
    data.each do |row|
      row.each do |k, v|
        v.attach(:view) if v.instance_of? Atome
      end
    end
    table_element = JS.global[:document].querySelector("##{@id} table")
    if table_element.nil?
      puts 'Table not found'
      return
    end
    (table_element[:rows].to_a.length - 1).downto(1) do |i|
      table_element.deleteRow(i)
    end

    max_cells = data.map { |row| row.keys.length }.max

    data.each do |row|
      new_row = table_element.insertRow(-1)
      max_cells.times do |i|
        key = row.keys[i]
        value = row[key]
        cell = new_row.insertCell(-1)
        if value.instance_of? Atome
          html_element = JS.global[:document].getElementById(value.id.to_s)
          cell.appendChild(html_element)
        else
          cell[:textContent] = value.to_s
        end
        set_td_style(cell)
      end
    end
  end

  def set_td_style(td)
    cell_height = @original_atome.component[:height]
    cell_width = @original_atome.component[:width]
    td[:style][:backgroundColor] = 'white'
    td[:style][:width] = "#{cell_width}px"
    td[:style]['min-width'] = "#{cell_width}px"
    td[:style]['max-width'] = "#{cell_height}px"
    td[:style]['min-height'] = "#{cell_height}px"
    td[:style]['max-height'] = "#{cell_height}px"
    td[:style][:height] = "#{cell_height}px"
    td[:style][:overflow] = 'hidden'
    { cell_height: cell_height, cell_width: cell_width }
  end

  def insert_cell(params)
    row_index, cell_index = params[:cell]
    new_content = params[:content]
    container = JS.global[:document].getElementById(@id.to_s)

    table = container.querySelector('table')
    if table.nil?
      puts 'No table found in the container'
      return
    end

    row = table.querySelectorAll('tr')[row_index]
    if row.nil?
      puts "Row at index #{row_index} not found"
      return
    end

    cell = row.querySelectorAll('td')[cell_index]
    if cell.nil?
      puts "Cell at index #{cell_index} in row #{row_index} not found"
      return
    end

    if new_content.instance_of? Atome
      cell.innerHTML = ''
      html_element = JS.global[:document].getElementById(new_content.id.to_s)
      cell.appendChild(html_element)
    else
      cell[:textContent] = new_content.to_s
    end
  end

  def insert_row(params)
    insert_at_index = params[:row]
    table_element = JS.global[:document].querySelector("##{@id} table")

    if table_element.nil?
      puts 'Tableau non trouvé'
      return
    end

    tbody = table_element.querySelector('tbody')

    header_row = table_element.querySelector('thead tr')
    column_count = header_row ? header_row.querySelectorAll('th').to_a.length : 0

    new_row = JS.global[:document].createElement('tr')
    column_count.times do |cell_index|
      td = JS.global[:document].createElement('td')
      set_td_style(td)
      new_row.appendChild(td)
    end

    if insert_at_index.zero?
      tbody.insertBefore(new_row, tbody.firstChild)
    else
      reference_row = tbody.querySelectorAll('tr').to_a[insert_at_index]
      tbody.insertBefore(new_row, reference_row)
    end

  end

  def insert_column(params)
    insert_at_index = params[:column]
    table_element = JS.global[:document].querySelector("##{@id} table")
    if table_element.nil?
      puts 'Table not found'
      return
    end
    rows = table_element.querySelectorAll('tr').to_a
    rows.each_with_index do |row, index|
      unless index == 0
        new_cell = JS.global[:document].createElement('td')
        new_cell[:innerText] = ''
        set_td_style(new_cell)
        if insert_at_index.zero?
          row.insertBefore(new_cell, row.firstChild)
        else
          child_nodes = row.querySelectorAll('td').to_a

          if insert_at_index < child_nodes.length
            reference_cell = child_nodes[insert_at_index]
            row.insertBefore(new_cell, reference_cell)
          else
            row.appendChild(new_cell)
          end
        end
      end

    end

  end

  def table_insert(params)
    if params[:cell]
      insert_cell(params)
    elsif params[:row]
      insert_row(params)
    elsif params[:column]
      insert_column(params)
    end

  end

  def remove(params)
    # TODO: FIXME:  "html : must create a case here  #{params} (#{@original_atome.id})"
    case params
    when Hash
      params.each do |k, v|
        case k
        when :row
          row_index = params[:row]
          table_element = JS.global[:document].querySelector("##{@id} table")

          if table_element.nil?
            puts 'Table not found'
            return
          end

          rows = table_element.querySelectorAll('tbody tr').to_a

          if row_index >= rows.length
            puts "row not found : #{row_index}"
            true
          end
          row_to_remove = rows[row_index]

          row_to_remove[:parentNode].removeChild(row_to_remove)

          rows.each_with_index do |row, i|
            next if i <= row_index
          end
        when :column
          column_index = params[:column]
          table_element = JS.global[:document].querySelector("##{@id} table")

          if table_element.nil?
            puts 'Table not found'
            true
          end

          rows = table_element.querySelectorAll('tbody tr').to_a
          rows.each do |row|
            cells = row.querySelectorAll('td').to_a
            if column_index < cells.length
              cell_to_remove = cells[column_index]
              cell_to_remove[:parentNode].removeChild(cell_to_remove)
            end
          end
        when :all
          case v
          when :paint
            style(:background, 'none')
          when :color
            #
          when :shadow
            style('box-shadow', 'none')
            style('text-shadow', 'none')
            style("filter", 'none')
          else
            #
          end
        end
      end
    else
      @original_atome.apply.delete(params)
      style(:background, 'none')
      style('box-shadow', 'none')
      style('text-shadow', 'none')
      style("boxShadow", 'none')
      style("filter", 'none')
      @original_atome.apply(@original_atome.apply)
    end

  end

  def table_remove(params)
    if params[:row]
      #
    elsif params[:column]
      #
    end
  end

  # atomisation!
  def atomized(html_object)
    @element = html_object
  end

  def center(options, attach)
    @center_options = options

    @parent = grab(attach)

    apply_centering(@center_options, @parent)

    return unless @center_options[:dynamic]
    event_handler = ->(event) do
      apply_centering(@center_options, @parent)
    end
    JS.global[:window].addEventListener('resize', event_handler)

  end

  def record_audio(params)
    duration = params[:duration] * 1000
    name = params[:name]
    JS.eval("recordAudio(#{duration},'#{@id}', '#{name}')")
  end

  def record_video(params)
    duration = params[:duration] * 1000
    name = params[:name]
    JS.eval("recordVideo(#{duration},'#{@id}', '#{name}')")
  end

  def stop_video_preview(id)
    JS.eval("stopPreview('#{id}')")
  end

  def video_preview(id, video, audio)
    JS.eval("create_preview('#{id}','#{video}','#{audio}')")
  end

  def stop_media_recorder(id)
    JS.eval("writeatomestore('#{id}', 'record', 'stop')")
  end

  private

  def apply_centering(options, parent)
    if options[:x]
      x_position = calculate_position(options[:x], parent.to_px(:width), @original_atome.to_px(:width))
      @original_atome.left(x_position)
    end

    return unless options[:y]
    y_position = calculate_position(options[:y], parent.to_px(:height), @original_atome.to_px(:height))
    @original_atome.top(y_position)

  end

  def calculate_position(option, parent_dimension, self_dimension)
    if option.is_a?(String) && option.end_with?('%')
      percent = option.chop.to_f / 100.0
      (parent_dimension - self_dimension) * percent
    elsif option == 0
      (parent_dimension - self_dimension) / 2.0
    else
      option
    end
  end

end



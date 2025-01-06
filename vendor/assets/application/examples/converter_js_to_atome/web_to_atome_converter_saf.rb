require 'nokogiri'
require 'open-uri'

# Sanitize IDs to make them Atome-compliant
def sanitize_id(id)
  id = id.to_s.strip.gsub(/[^a-zA-Z0-9_]/, '_') # Nettoyer les caractères non conformes
  ":#{id}" # Retourner en tant que chaîne avec préfixe `:`
end

# Map CSS properties to Atome-compatible attributes
def convert_css_property(prop, value)
  case prop
  when 'width', 'height', 'top', 'left', 'margin', 'padding'
    [prop.to_sym, value.gsub('px', '').to_i] # Convert px to integer
  when 'background-color'
    color_value = value.start_with?('#') ? value : ":#{value.strip.downcase}" # Convertir les couleurs nommées en symboles préfixés
    [:color, color_value]
  when 'border'
    convert_border(value) # Gérer les bordures comme objets Atome
  when 'box-shadow'
    [:shadow, value] # Convert box-shadow
  when 'animation'
    [:animation, value] # Convert animation as-is
  else
    nil # Ignore unsupported properties
  end
end

# Convert border CSS property to Atome-compatible attributes
# Convert border CSS property to Atome-compatible attributes
def convert_border(border_value)
  parts = border_value.split
  thickness = parts[0].gsub('px', '').to_i
  pattern = parts[1].to_sym
  color = parts[2].start_with?('#') ? parts[2] : ":#{parts[2].strip.downcase}"

  # Crée un hash pour la bordure et retourne une paire clé-valeur
  [
    :border,
    {
      thickness: thickness,
      pattern: pattern,
      red: color.include?('#') ? color[1..2].hex / 255.0 : 0,
      green: color.include?('#') ? color[3..4].hex / 255.0 : 0,
      blue: color.include?('#') ? color[5..6].hex / 255.0 : 0,
      alpha: color.include?('#') ? 1.0 : 0
    }
  ]
end



# Map CSS properties to Atome-compatible attributes
# Convert box-shadow CSS property to Atome-compatible attributes
def convert_box_shadow(box_shadow_value)
  parts = box_shadow_value.split(' ')
  left = parts[0].gsub('px', '').to_i
  top = parts[1].gsub('px', '').to_i
  blur = parts[2].gsub('px', '').to_i
  rgba = parts[3].match(/rgba?\((\d+),\s*(\d+),\s*(\d+),\s*([\d.]+)\)/)

  if rgba
    red, green, blue, alpha = rgba[1..4].map(&:to_f)
    alpha = alpha > 1 ? alpha / 255.0 : alpha
  else
    red = green = blue = 0
    alpha = 1.0
  end

  # Retourner un objet ombre au format Atome
  {
    id: ":shadow_#{rand(1000..9999)}",
    left: left,
    top: top,
    blur: blur,
    red: red / 255.0,
    green: green / 255.0,
    blue: blue / 255.0,
    alpha: alpha
  }
end

# Map CSS properties to Atome-compatible attributes
def convert_css_property(prop, value)
  case prop
  when 'width', 'height', 'top', 'left', 'margin', 'padding'
    [prop.to_sym, value.gsub('px', '').to_i] # Convert px to integer
  when 'background-color'
    color_value = value.start_with?('#') ? value : ":#{value.strip.downcase}" # Convertir les couleurs nommées en symboles préfixés
    [:color, color_value]
  when 'border'
    convert_border(value) # Gérer les bordures comme objets Atome
  when 'box-shadow'
    [:shadow, convert_box_shadow(value)] # Convertir box-shadow en objet Atome
  when 'animation'
    [:animation, value] # Convert animation as-is
  else
    nil # Ignore unsupported properties
  end
end



# Determine the type or preset for the HTML element
def determine_preset(element)
  case element.name
  when 'div'
    element['style']&.include?('border-radius') ? 'circle' : 'box'
  when 'img'
    'image'
  when 'p', 'span', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6'
    'text'
  else
    puts "Unsupported element: #{element.name}" # Log the unsupported element
    nil # Ignore unsupported elements
  end
end

# Generate Atome-compatible code for a single HTML element
def generate_atome_code(element, styles = {})
  id = sanitize_id(element['id'] || "generated_id_#{rand(1000..9999)}") # Toujours une chaîne avec préfixe
  preset = determine_preset(element)
  return nil if preset.nil? # Ignore elements without a valid preset

  # Si l'élément semble être un "circle" via l'ID ou border-radius, appliquer des valeurs par défaut
  if id.include?("circle") || styles[:smooth]
    styles[:smooth] ||= 50
    styles[:width] ||= 50
    styles[:height] ||= 50
    styles[:color] ||= ":gray"
  end

  # Ajouter des valeurs par défaut pour les éléments sans position ou taille
  styles[:width] ||= 50
  styles[:height] ||= 50
  styles[:left] ||= 0
  styles[:top] ||= 0

  attributes = { id: id }.merge(styles)

  # Convert the attributes into a hash-style representation
  attributes_code = attributes.map do |key, value|
    "#{key}: #{value.is_a?(Symbol) || value.is_a?(Integer) ? value : "#{value}"}"
  end.join(', ')

  # Générer le code final basé sur le type ou le preset
  "#{preset}({ #{attributes_code} })"
end

# Parse CSS and generate Atome-compatible styles
def parse_css(css_content)
  rules = css_content.scan(/(.*?)\s*\{(.*?)\}/m) # Extraire les règles CSS
  styles = {}

  rules.each do |selector, declarations|
    sanitized_id = sanitize_id(selector.strip.gsub('#', ''))
    declarations_hash = {}

    declarations.split(';').each do |declaration|
      next if declaration.strip.empty? # Ignorer les lignes vides
      property, value = declaration.strip.split(':', 2) # Séparer en deux parties maximum
      if property && value
        declarations_hash[property.strip] = value.strip
      else
        puts "Ignored invalid declaration: #{declaration.strip}" # Log des déclarations invalides
      end
    end

    styles[sanitized_id] = declarations_hash.map do |prop, value|
      convert_css_property(prop, value)
    end.compact.to_h
  end

  styles
end

# Fetch external CSS and combine styles
def fetch_external_css(doc)
  css_content = ''
  doc.css('link[rel="stylesheet"]').each do |link|
    begin
      css_content += URI.open(link['href']).read
    rescue StandardError => e
      puts "Could not fetch external CSS: #{link['href']} - #{e.message}"
    end
  end
  css_content
end

# Parse HTML and convert it into Atome-compatible code
def parse_html(file_path)
  doc = Nokogiri::HTML(File.read(file_path))
  local_css = doc.css('style').map(&:content).join("\n")
  external_css = fetch_external_css(doc)

  # Combine local and external CSS
  combined_css = "#{local_css}\n#{external_css}"
  styles = parse_css(combined_css)

  atome_code = []

  doc.at('body').css('*').each do |element|
    id = sanitize_id(element['id'] || "generated_id_#{rand(1000..9999)}") # Retourne une chaîne avec préfixe
    styles_for_element = styles[id] || {}
    code = generate_atome_code(element, styles_for_element)
    atome_code << code unless code.nil?
  end

  atome_code.join("\n")
end

# Write the converted code to a file
def convert_to_atome(input_file, output_file)
  converted_code = parse_html(input_file)
  File.write(output_file, converted_code)
  puts "Conversion terminée. Fichier généré : #{output_file}"
end

# Convert example.html to atome_converted.rb
convert_to_atome('example.html', 'atome_converted.rb')

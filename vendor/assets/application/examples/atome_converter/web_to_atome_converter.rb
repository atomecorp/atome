require 'nokogiri'

def convert_html_to_atome(html_content)
  document = Nokogiri::HTML(html_content)

  def element_to_atome(element, global_styles)
    tag = element.name
    attributes = element.attributes
    styles = merge_styles(global_styles, attributes["style"]&.value)
    validate_styles(styles)
    puts "DEBUG: Styles combinés pour l'élément #{element.name} : #{styles.inspect}"
    id = attributes["id"]&.value || "generated_#{rand(1000)}"

    case tag
    when "div"
      "box({ id: :#{id}#{format_styles(styles)} })"
    when "p", "span", "h1", "h2", "h3", "h4", "h5", "h6"
      "text({ id: :#{id}, data: #{element.text.inspect}#{format_styles(styles)} })"
    when "img"
      src = attributes["src"]&.value
      "image({ id: :#{id}, path: #{src.inspect}#{format_styles(styles)} })"
    else
      "# Balise non supportée : #{tag}"
    end
  end

  def merge_styles(global_styles, inline_styles)
    combined_styles = global_styles.merge(parse_inline_styles(inline_styles))
    puts "DEBUG: Styles après fusion : #{combined_styles.inspect}"
    combined_styles # Retourne le style fusionné directement
  end

  def parse_inline_styles(styles)
    return {} unless styles

    styles.split(";").filter_map do |s|
      key, value = s.strip.split(":", 2)
      [key.strip, value.strip] if key && value
    end.to_h
  end

  def validate_styles(styles)
    # Validation finale des styles essentiels
    styles["left"] = styles.fetch("left", "0px").strip
    styles["top"] = styles.fetch("top", "0px").strip
    styles["width"] ||= "100px"
    styles["height"] ||= "100px"
  end

  def format_styles(styles)
    formatted = styles_to_atome(styles)
    formatted.empty? ? "" : ", #{formatted}"
  end

  def styles_to_atome(styles)
    styles.map do |key, value|
      next nil if value.strip.empty? # Ignorer les styles vides
      case key.strip
      when "width", "height", "top", "left"
        "#{key.strip}: #{value.strip.gsub(/[a-z%]+/, '')}"
      when "background-color", "color"
        "color: #{convert_color(value.strip)}"
      when "border"
        parts = value.strip.split(" ")
        thickness = parts[0].gsub('px', '')
        color = convert_color(parts[-1])
        "border: { thickness: #{thickness}, color: #{color} }"
      when "border-radius"
        "smooth: #{value.strip.gsub('%', '').gsub('px', '')}"
      when "box-shadow"
        x, y, blur, *rgba = value.strip.split(" ")
        rgba = rgba.join(" ").gsub("rgba(", "").gsub(")", "").split(",").map(&:strip)
        "shadow: { left: #{x.gsub('px', '')}, top: #{y.gsub('px', '')}, blur: #{blur.gsub('px', '')}, red: #{rgba[0].to_f / 255}, green: #{rgba[1].to_f / 255}, blue: #{rgba[2].to_f / 255}, alpha: #{rgba[3]} }"
      else
        nil
      end
    end.compact.join(", ")
  end

  def convert_color(value)
    if value.start_with?("#")
      hex_to_rgb(value)
    elsif value.start_with?("rgba")
      rgba_to_atome(value)
    elsif value.start_with?("rgb")
      rgb_to_atome(value)
    else
      ":#{value}"
    end
  end

  def hex_to_rgb(hex)
    hex = hex.delete_prefix("#")
    r, g, b = hex.scan(/../).map { |color| color.to_i(16) / 255.0 }
    "{ red: #{r.round(2)}, green: #{g.round(2)}, blue: #{b.round(2)}, alpha: 1 }"
  end

  def rgba_to_atome(rgba)
    rgba_values = rgba.gsub("rgba(", "").gsub(")", "").split(",").map(&:strip)
    r = rgba_values[0].to_f / 255
    g = rgba_values[1].to_f / 255
    b = rgba_values[2].to_f / 255
    a = rgba_values[3].to_f
    "{ red: #{r.round(2)}, green: #{g.round(2)}, blue: #{b.round(2)}, alpha: #{a} }"
  end

  def rgb_to_atome(rgb)
    rgb_values = rgb.gsub("rgb(", "").gsub(")", "").split(",").map(&:strip)
    r = rgb_values[0].to_f / 255
    g = rgb_values[1].to_f / 255
    b = rgb_values[2].to_f / 255
    "{ red: #{r.round(2)}, green: #{g.round(2)}, blue: #{b.round(2)}, alpha: 1 }"
  end

  global_styles = document.css("style").each_with_object({}) do |style, result|
    style.content.split("}").each do |rule|
      selector, declarations = rule.split("{")
      next unless selector && declarations

      selector.strip.split(",").each do |sel|
        sel = sel.strip
        result[sel] ||= {}
        result[sel].merge!(parse_inline_styles(declarations))
      end
    end
  end
  puts "DEBUG: Styles globaux : #{global_styles.inspect}"

  document.css("body *").map do |element|
    applicable_styles = global_styles[element["class"]&.split&.map { |c| ".#{c}" }&.join(",") || ""] || {}
    element_to_atome(element, applicable_styles)
  end.join("\n")
end

# Exemple de contenu HTML
html_content = <<-HTML
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exemple HTML</title>
    <style>
        /* Styles globaux */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        /* Divs arrondies */
        .rounded {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #007bff;
            margin: 10px auto;
        }

        /* Avec ombre et bordure */
        .rounded.shadow {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            border: 2px solid #0056b3;
        }

        /* Animation simple */
        .animate {
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .animate:hover {
            transform: scale(1.1);
            background-color: #0056b3;
        }

        /* Interactions */
        .interactive {
            cursor: pointer;
        }

        .interactive:active {
            background-color: #003f7f;
        }

        /* Typage et styles via balise CSS */
        .text {
            font-size: 18px;
            color: #333;
            margin: 20px 0;
        }

        .highlight {
            color: #ff5722;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Exemple de page HTML</h1>
        <p class="text">Voici un <span class="highlight">exemple</span> de texte avec un style appliqué via une balise CSS.</p>

        <!-- Div arrondie simple -->
        <div class="rounded"></div>

        <!-- Div arrondie avec ombre et bordure -->
        <div class="rounded shadow"></div>

        <!-- Div avec animation et interactions -->
        <div class="rounded shadow animate interactive"></div>
    </div>
</body>
</html>
HTML

# Conversion du contenu HTML
converted_code = convert_html_to_atome(html_content)

# Sauvegarde du fichier généré
if File.write("./file_converted.rb", converted_code)
  puts "Le fichier file_converted.rb a été créé avec succès !"
else
  puts "Erreur lors de la création du fichier."
end

# Affichage du code généré
puts converted_code

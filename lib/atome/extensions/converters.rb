# frozen_string_literal: true


class Svg_to_atome
  def convert(svg_content)
    # Extraction of SVG elements
    svg_elements = extract_svg_elements(svg_content)

    # Converting elements to data hash
    data_hash = {}

    # Take the first element for the main hash
    if !svg_elements.empty?
      first_element = svg_elements.first
      type_key, element_hash = convert_element_to_hash(first_element)
      data_hash[type_key] = element_hash

      # Calculate the optimal viewBox for this element
      optimal_viewbox = calculate_optimal_viewbox(first_element)
    else
      optimal_viewbox = "0 0 100 100" # Default viewBox if no elements
    end

    # Return an array with the hash and optimal viewBox
    [data_hash, optimal_viewbox]
  end

  # Version that returns an array of elements with viewBox
  def convert_to_array(svg_content)
    # Extraction of SVG elements
    svg_elements = extract_svg_elements(svg_content)

    # Converting elements to array of hashes
    data_array = svg_elements.map do |element|
      type_key, element_hash = convert_element_to_hash(element)
      { type_key => element_hash }
    end

    # Calculate the optimal viewBox for all elements
    optimal_viewbox = calculate_optimal_viewbox_for_multiple(svg_elements)

    # Return the array of hashes and the optimal viewBox
    [data_array, optimal_viewbox]
  end

  private

  def extract_svg_elements(svg_content)
    elements = []

    # Cleaning spaces and comments
    cleaned_svg = svg_content.gsub(/<!--.*?-->/m, '')
                             .gsub(/\s+/, ' ')
                             .gsub(/>\s+</, '><')

    # Types of SVG elements to extract
    svg_tags = ['path', 'circle', 'rect', 'ellipse', 'line', 'polyline', 'polygon', 'text']

    # Extract self-closing elements
    svg_tags.each do |tag|
      pattern = /<#{tag}\s+([^>]*?)\/>/
      cleaned_svg.scan(pattern) do |match|
        attrs = parse_attributes(match[0])
        elements << {type: tag, attributes: attrs}
      end
    end

    # Extract elements with closing tags
    svg_tags.each do |tag|
      pattern = /<#{tag}\s+([^>]*?)>(.*?)<\/#{tag}>/m
      cleaned_svg.scan(pattern) do |match|
        attrs = parse_attributes(match[0])
        inner_content = match[1]
        elements << {type: tag, attributes: attrs, inner_content: inner_content}
      end
    end

    elements
  end

  def parse_attributes(attr_string)
    attributes = {}

    # Extraction of key-value pairs
    attr_pattern = /(\w+(?:\-\w+)?)=["']([^"']*)["']/
    attr_string.scan(attr_pattern) do |key, value|
      attributes[key] = value
    end

    attributes
  end

  def calculate_optimal_viewbox(element)
    case element[:type]
    when 'circle'
      attrs = element[:attributes] || {}
      cx = (attrs['cx'] || '0').to_f
      cy = (attrs['cy'] || '0').to_f
      r = (attrs['r'] || '0').to_f
      stroke_width = (attrs['stroke-width'] || '0').to_f

      # Calculate boundaries for the circle
      min_x = cx - r - (stroke_width / 2)
      min_y = cy - r - (stroke_width / 2)
      width = 2 * r + stroke_width
      height = 2 * r + stroke_width

      # Round values to the nearest integer
      "#{min_x.floor} #{min_y.floor} #{width.ceil} #{height.ceil}"

    when 'rect'
      attrs = element[:attributes] || {}
      x = (attrs['x'] || '0').to_f
      y = (attrs['y'] || '0').to_f
      width = (attrs['width'] || '0').to_f
      height = (attrs['height'] || '0').to_f
      stroke_width = (attrs['stroke-width'] || '0').to_f

      # Calculate boundaries for the rectangle
      min_x = x - (stroke_width / 2)
      min_y = y - (stroke_width / 2)
      total_width = width + stroke_width
      total_height = height + stroke_width

      "#{min_x.floor} #{min_y.floor} #{total_width.ceil} #{total_height.ceil}"

    when 'ellipse'
      attrs = element[:attributes] || {}
      cx = (attrs['cx'] || '0').to_f
      cy = (attrs['cy'] || '0').to_f
      rx = (attrs['rx'] || '0').to_f
      ry = (attrs['ry'] || '0').to_f
      stroke_width = (attrs['stroke-width'] || '0').to_f

      # Calculate boundaries for the ellipse
      min_x = cx - rx - (stroke_width / 2)
      min_y = cy - ry - (stroke_width / 2)
      width = 2 * rx + stroke_width
      height = 2 * ry + stroke_width

      "#{min_x.floor} #{min_y.floor} #{width.ceil} #{height.ceil}"

    when 'line'
      attrs = element[:attributes] || {}
      x1 = (attrs['x1'] || '0').to_f
      y1 = (attrs['y1'] || '0').to_f
      x2 = (attrs['x2'] || '0').to_f
      y2 = (attrs['y2'] || '0').to_f
      stroke_width = (attrs['stroke-width'] || '0').to_f

      # Calculate boundaries for the line
      min_x = [x1, x2].min - (stroke_width / 2)
      min_y = [y1, y2].min - (stroke_width / 2)
      width = (x1 - x2).abs + stroke_width
      height = (y1 - y2).abs + stroke_width

      "#{min_x.floor} #{min_y.floor} #{width.ceil} #{height.ceil}"

    when 'path', 'polygon', 'polyline'
      # For complex paths, we would need to analyze the points/commands
      # As a simplification, we use a default viewBox or
      # try to extract dimensions from the parent svg element
      "0 0 100 100"

    else
      # Default viewBox for other types
      "0 0 100 100"
    end
  end

  def calculate_optimal_viewbox_for_multiple(elements)
    # If no elements, return a default viewBox
    return "0 0 100 100" if elements.empty?

    # Initialize boundaries with extreme values
    min_x = Float::INFINITY
    min_y = Float::INFINITY
    max_x = -Float::INFINITY
    max_y = -Float::INFINITY

    # Traverse all elements and find global boundaries
    elements.each do |element|
      # Get boundaries for this element
      viewbox_str = calculate_optimal_viewbox(element)
      next if viewbox_str == "0 0 100 100" # Ignore elements with default viewBox

      # Parse the viewBox string
      vb_min_x, vb_min_y, vb_width, vb_height = viewbox_str.split(' ').map(&:to_f)
      vb_max_x = vb_min_x + vb_width
      vb_max_y = vb_min_y + vb_height

      # Update global boundaries
      min_x = [min_x, vb_min_x].min
      min_y = [min_y, vb_min_y].min
      max_x = [max_x, vb_max_x].max
      max_y = [max_y, vb_max_y].max
    end

    # If no valid boundaries were found, use the default viewBox
    if min_x == Float::INFINITY || min_y == Float::INFINITY
      return "0 0 100 100"
    end

    # Calculate final width and height
    width = max_x - min_x
    height = max_y - min_y

    # Return the optimal viewBox for all elements
    "#{min_x.floor} #{min_y.floor} #{width.ceil} #{height.ceil}"
  end

  def convert_element_to_hash(element)
    case element[:type]
    when 'path'
      attrs = element[:attributes] || {}
      path_d = attrs['d'] || ''

      stroke = attrs['stroke'] || 'black'
      stroke_width = attrs['stroke-width'] || '1'
      fill = attrs['fill'] || 'none'

      hash = {
        d: path_d,
        stroke: color_to_symbol(stroke),
        'stroke-width': stroke_width.to_i,
        fill: color_to_symbol(fill)
      }

      return :path, hash

    when 'circle'
      attrs = element[:attributes] || {}
      cx = attrs['cx'] || '0'
      cy = attrs['cy'] || '0'
      r = attrs['r'] || '0'

      stroke = attrs['stroke'] || 'black'
      stroke_width = attrs['stroke-width'] || '1'
      fill = attrs['fill'] || 'none'

      hash = {
        cx: cx.to_i,
        cy: cy.to_i,
        r: r.to_i,
        stroke: color_to_symbol(stroke),
        'stroke-width': stroke_width.to_i,
        fill: color_to_symbol(fill)
      }

      return :circle, hash

    when 'rect'
      attrs = element[:attributes] || {}
      x = attrs['x'] || '0'
      y = attrs['y'] || '0'
      width = attrs['width'] || '0'
      height = attrs['height'] || '0'

      stroke = attrs['stroke'] || 'black'
      stroke_width = attrs['stroke-width'] || '1'
      fill = attrs['fill'] || 'none'

      hash = {
        x: x.to_i,
        y: y.to_i,
        width: width.to_i,
        height: height.to_i,
        stroke: color_to_symbol(stroke),
        'stroke-width': stroke_width.to_i,
        fill: color_to_symbol(fill)
      }

      return :rect, hash

    when 'ellipse'
      attrs = element[:attributes] || {}
      cx = attrs['cx'] || '0'
      cy = attrs['cy'] || '0'
      rx = attrs['rx'] || '0'
      ry = attrs['ry'] || '0'

      stroke = attrs['stroke'] || 'black'
      stroke_width = attrs['stroke-width'] || '1'
      fill = attrs['fill'] || 'none'

      hash = {
        cx: cx.to_i,
        cy: cy.to_i,
        rx: rx.to_i,
        ry: ry.to_i,
        stroke: color_to_symbol(stroke),
        'stroke-width': stroke_width.to_i,
        fill: color_to_symbol(fill)
      }

      return :ellipse, hash

    when 'line'
      attrs = element[:attributes] || {}
      x1 = attrs['x1'] || '0'
      y1 = attrs['y1'] || '0'
      x2 = attrs['x2'] || '0'
      y2 = attrs['y2'] || '0'

      stroke = attrs['stroke'] || 'black'
      stroke_width = attrs['stroke-width'] || '1'

      hash = {
        x1: x1.to_i,
        y1: y1.to_i,
        x2: x2.to_i,
        y2: y2.to_i,
        stroke: color_to_symbol(stroke),
        'stroke-width': stroke_width.to_i
      }

      return :line, hash

    when 'polyline'
      attrs = element[:attributes] || {}
      points = attrs['points'] || ''

      stroke = attrs['stroke'] || 'black'
      stroke_width = attrs['stroke-width'] || '1'
      fill = attrs['fill'] || 'none'

      hash = {
        points: points,
        stroke: color_to_symbol(stroke),
        'stroke-width': stroke_width.to_i,
        fill: color_to_symbol(fill)
      }

      return :polyline, hash

    when 'polygon'
      attrs = element[:attributes] || {}
      points = attrs['points'] || ''

      stroke = attrs['stroke'] || 'black'
      stroke_width = attrs['stroke-width'] || '1'
      fill = attrs['fill'] || 'none'

      hash = {
        points: points,
        stroke: color_to_symbol(stroke),
        'stroke-width': stroke_width.to_i,
        fill: color_to_symbol(fill)
      }

      return :polygon, hash

    when 'text'
      attrs = element[:attributes] || {}
      x = attrs['x'] || '0'
      y = attrs['y'] || '0'
      content = element[:inner_content] || ''

      font_family = attrs['font-family'] || 'sans-serif'
      font_size = attrs['font-size'] || '12'
      fill = attrs['fill'] || 'black'

      hash = {
        x: x.to_i,
        y: y.to_i,
        content: content,
        'font-family': font_family,
        'font-size': font_size.to_i,
        fill: color_to_symbol(fill)
      }

      return :text, hash

    else
      # Unknown element
      return :unknown, { type: element[:type] }
    end
  end

  def color_to_symbol(color)
    # Converts a CSS color to Ruby symbol
    # Removes # from hexadecimal colors
    color = color.to_s.gsub('#', '')

    # Handling common named colors
    common_colors = {
      'none' => :none,
      'black' => :black,
      'white' => :white,
      'red' => :red,
      'green' => :green,
      'blue' => :blue,
      'yellow' => :yellow,
      'cyan' => :cyan,
      'magenta' => :magenta,
      'gray' => :gray,
      'grey' => :gray,
      'transparent' => :transparent
    }

    if common_colors[color]
      common_colors[color]
    else
      # If it's a hexadecimal color or other, convert it to a symbol
      color.to_sym
    end
  end
end



# if __FILE__ == $0
#   if ARGV.empty?
#     puts "Usage: ruby #{$0} input.svg [--array]"
#     exit 1
#   end
#
#   svg_file = ARGV[0]
#   svg_content = File.read(svg_file)
#
#   converter = SVGToDataConverter.new
#
#   if ARGV.include?('--array')
#     result = converter.convert_to_array(svg_content)
#   else
#     result = converter.convert(svg_content)
#   end
#
#   puts result.inspect
# end
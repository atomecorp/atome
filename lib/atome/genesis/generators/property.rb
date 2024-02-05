# frozen_string_literal: true

def extract_rgb_alpha(color_string)
  match_data = color_string.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+(?:\.\d+)?))?\)/)
  red = match_data[1].to_i
  green = match_data[2].to_i
  blue = match_data[3].to_i
  alpha = match_data[4] ? match_data[4].to_f : nil
  { red: red, green: green, blue: blue, alpha: alpha }
end

new({ particle: :red, category: :property, type: :string }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :green, category: :property, type: :string }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :blue, category: :property, type: :string }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :alpha, category: :property, type: :string }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
new({ particle: :diffusion, category: :property, type: :string }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end


new({ particle: :clean, category: :property, type: :boolean }) do |params|
  cell = params[:cell]
  row_nb = cell[0]
  column_nb = cell[1]
  data[row_nb][data[row_nb].keys[column_nb]] = "" # we remove the data from the cell
  params
end

new({ particle: :insert, category: :property, type: :string }) do |params|
  # cell
  if params[:cell]
    content = params[:content]
    cell = params[:cell]
    row_nb = cell[0]
    column_nb = cell[1]
    data[row_nb][data[row_nb].keys[column_nb]] = content # we remove the data from the cell
  elsif params[:row]
    position_to_insert = params[:row]
    data.insert(position_to_insert, {})
  elsif params[:column]
  end

  params
end

new({ particle: :remove, category: :property, type: :boolean }) do |params|

  if params[:row]
    data.delete_at(params[:row])

  elsif params[:column]
    column = params[:column]
    data.map do |hash|
      hash.delete(hash.keys[column]) if hash.keys[column]
      hash
    end
  end
  params
end


new({ particle: :sort, category: :property, type: :int }) do |params|
  column = params[:column]
  method = params[:method]

  if column.nil? || method.nil?
    puts "Column and method parameters are required."
    return
  end

  @data.sort_by! do |row|
    value = row.values[column - 1]
    if value.instance_of? Atome
      0
    else
      case method
      when :alphabetic
        value.to_s
      when :numeric
        if value.is_a?(Numeric)
          value
        elsif value.respond_to?(:to_i)
          value.to_i
        else
          0
        end
      else
        value
      end
    end
  end

  params
end

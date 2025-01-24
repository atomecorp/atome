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
# FIXME  we have to apply both at post and after to make it work
# used to refresh all affected atomes
new({ after: :red }) do |params|
  a = affect.dup #  FIXME  we have to dup else some items in the array array other duplicated
  a.each do |atome_to_refresh|
    grab(atome_to_refresh).apply(id)
  end if a
  params
end

new({ particle: :green, category: :property, type: :string }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

# used to refresh all affected atomes
new({ after: :green }) do |params|
  a = affect.dup #  FIXME  we have to dup else some items in the array array other duplicated
  a.each do |atome_to_refresh|
    grab(atome_to_refresh).apply(id)
  end if a
  params
end

new({ particle: :blue, category: :property, type: :string }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end

# used to refresh all affected atomes
new({ after: :blue }) do |params|
  a = affect.dup #  FIXME  we have to dup else some items in the array array other duplicated
  a.each do |atome_to_refresh|
    grab(atome_to_refresh).apply(id)
  end if a
  params
end
new({ particle: :alpha, category: :property, type: :string }) do
  # we return self to allow syntax of the type : a.color(:black).red(1).green(0.3)
  self
end
# used to refresh all affected atomes
new({ after: :alpha }) do |params|
  a = affect.dup #  FIXME  we have to dup else some items in the array array other duplicated
  a.each do |atome_to_refresh|
    grab(atome_to_refresh).apply(id)
  end if a
  params
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
    #
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

new({ particle: :inside, render: false,category: :property, type: :string  })
new({ initialized: :inside }) do |params, &user_proc|
  render(:inside, params, &user_proc)
end
new({ particle: :margin,category: :property, type: :int  })

new({ particle: :value ,category: :property, type: :string }) do |val|
  pro_f = behavior[:value]
  instance_exec(val, &pro_f) if pro_f.is_a?(Proc)
  val
end

new({ particle: :behavior, type: :symbol, category: :property })

new({ particle: :orientation, type: :symbol, category: :property })

new({ particle: :align, type: :symbol, category: :property })

new({particle: :context, category: :property, type: :string }) # used to store the context of the object ex (edit mode,insert mode , read mode ..  )

new({ particle: :actor, store: false, category: :property , type: :string }) do |params|
  @actor ||= {}
  if params[:remove]
    params[:remove].each do |atome_id, role|
      @actor[role].delete(atome_id)
    end
  else
    params.each do |atome_id, role|
      grab(atome_id).role(role)
      @actor[role] ||= []
      @actor[role] << atome_id
    end
  end
end

new({ particle: :role, store: false, category: :property , type: :string }) do |params|
  if params.instance_of? Hash
    if params.keys[0] == :remove
      @role.delete(params.values[0])
    end
  else
    @role ||= []
    @role << params
  end
end
new({ particle: :blink, category: :property, type: :symbol }) do |params|
  @prev_color = color.last
  @new_color = params
  color(@new_color)
  wait 0.1 do
    apply(@prev_color)
  end
end

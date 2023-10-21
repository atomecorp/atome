#  frozen_string_literal: true

#########################################


def convert_to_css(data)
  conditions = data[:condition]
  apply = data[:alterations]

  # Convertir les conditions
  condition_strings = []
  if conditions[:max]
    condition_strings << "(max-width: #{conditions[:max][:width]}px)" if conditions[:max][:width]
    condition_strings << "(max-height: #{conditions[:max][:height]}px)" if conditions[:max][:height]
  end
  if conditions[:min]
    condition_strings << "(min-width: #{conditions[:min][:width]}px)" if conditions[:min][:width]
    condition_strings << "(min-height: #{conditions[:min][:height]}px)" if conditions[:min][:height]
  end

  # Convertir les propriétés à appliquer
  property_strings = []
  apply.each do |key, values|
    inner_properties = []
    values.each do |property, value|
      if property == :color
        inner_properties << "background-color: #{value};"
      else
        inner_properties << "#{property}: #{value}px;" if value.is_a?(Integer)
        inner_properties << "#{property}: #{value};" if value.is_a?(Symbol)
      end
    end
    property_strings << "#{key} {\n#{inner_properties.join("\n")}\n}"
  end

  # Assembler le tout
  css = "@media #{condition_strings.join(", ")} {\n#{property_strings.join("\n")}\n}"

  css
end

def css_to_data(css)
  data = {
    :condition => {},
    :apply => {}
  }
  # Extraire les conditions
  media_conditions = css.match(/@media ([^\{]+)/)[1].split(',').map(&:strip)
  media_conditions.each do |condition|
    type = condition.match(/(max|min)-/)[1].to_sym
    property = condition.match(/(width|height)/)[1].to_sym
    value = condition.match(/(\d+)/)[1].to_i

    data[:condition][type] ||= {}
    data[:condition][type][property] = value
  end

  # Extraire les propriétés à appliquer
  css.scan(/(\w+) \{([^\}]+)\}/).each do |match|
    key = match[0].to_sym
    properties = match[1].split(';').map(&:strip).reject(&:empty?)

    data[:apply][key] ||= {}
    properties.each do |property|
      prop, value = property.split(':').map(&:strip)
      if prop == "background-color"
        data[:apply][key][:color] = value.to_sym
      elsif value[-2..] == "px"
        data[:apply][key][prop.to_sym] = value.to_i
      else
        data[:apply][key][prop.to_sym] = value.to_sym
      end
    end
  end

  data
end

########################################

new({particle: :transform}) do |params|
   # params='kjh'
end

new({sanitizer: :transform }) do |params, bloc|
  result = bloc.call

result={alterations: result}
  params= params.merge(result)
  # alert params
  puts css_converted=convert_to_css(params)
  puts '----'
  puts css_to_data(css_converted)
  params
end
new({particle: :condition})

box({color: :red, width: :auto , left: 120, right: 120, id: :box_1 })
circle({left: 33, top:200, id: :circle_1})
circle({left: 200, top:200, id: :circle_2})
circle({left: 400, top:200, id: :circle_3})
circle({left: 600, top:200, id: :circle_4})
text({data: 'welcome to my beautifully website', id: :my_text})


# def A.transform(params)
#   if block_given?
#     styles = yield
#     alert styles
#     # Convertir 'styles' en CSS ou effectuer d'autres traitements
#     # ...
#   end
# end

A.transform({condition:{max: {width: 300}, min: {height: 120} }})  do
{
  circle_1: { color: :red , width: 23},
  circle_2: { color: :red , width: 23, top: 12},
  box_1: { width: 123, left: 222}
}
end



transformer(atomes: [:box_1,:circle_1,:circle_2,:circle_3,:circle_4,:my_text],
            condition:{max: {width: 300}, min: {height: 120} } ,
            )

# alert A.transform

def atome_methods
  communication = %i[share]
  effect = %i[blur shadow smooth]
  event = %i[touch drag over]
  geometry = %i[width height size rotation]
  helper = %i[tactile display]
  hierarchy = %i[parent child insert]
  identity = %i[atome_id id type language private can]
  spatial = %i[x xx y yy z center]
  media = %i[content video box circle text image audio info example]
  utility = %i[edit record enliven selector render preset]
  material = %i[color opacity border overflow]
  {spatials: spatial, helpers: helper, materials: material, geometries: geometry, effects: effect, medias: media, hierarchies: hierarchy, utilities: utility, communications: communication, identities: identity, events: event}
end


FileUtils.mkdir_p "atome/lib/atome/generated_properties"

def need_pre_processing
  %i[atome_id private can box circle text image video audio parent child]

end

def need_processing
  %i[]
end

def getter_need_processing
  %i[private can box circle text image video audio parent child]
end

def no_rendering
  %i[box circle text image video audio parent child info example]
end

batch_methods = []

atome_methods.each do |property_type, property|
  category = []
  property.each do |method_name|
    # atome properties generator
    if need_pre_processing.include?(method_name)
      pre_processor = "#{method_name}_pre_processor(value)"
    else
      set_instance_variable = "@#{method_name} = atomise(:#{method_name},value)"
    end
    if need_processing.include?(method_name)
      processor = "#{method_name}_processor(value)"
    end
    if getter_need_processing.include?(method_name)
      getter_processor = "#{method_name}_getter_processor(value)"
    else
      getter_processor = "@#{method_name}&.read"
    end
    unless no_rendering.include?(method_name)
      rendering = "#{method_name}_html(@#{method_name})"
    end

    method_content = <<STRDELIM
  def #{method_name}(value = nil, &proc)
    if value.nil? && !proc
      #{getter_processor}
    else
      value = properties_common(value, &proc)
      #{pre_processor}
      #{set_instance_variable}
      #{processor}
      #{rendering}
    end
  end 

 def #{method_name}=(value, &proc)
  #{method_name}(value, &proc)
 end
STRDELIM
    category << method_content.each_line.reject { |x| x.strip == "" }.join
  end

  category = <<STRDELIM
module Properties
#{category.join("\n")}
end
STRDELIM
  File.write("atome/lib/atome/generated_properties/#{property_type}.rb", category)
# now we create the method for batch object
  property.each do |method_name|
    batch_method = <<STRDELIM
      def #{method_name}(value, &proc)
        read.each do |atome|
          grab(atome).send(:#{method_name}, value, &proc)
        end
      end
STRDELIM
    batch_methods << batch_method
  end

end


batch = <<STRDELIM
module Batch
#{batch_methods.join("\n")}
end
STRDELIM
File.write("atome/lib/atome/generated_properties/batch.rb", batch)

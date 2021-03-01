def self.atome_methods
  audio = %i[contour reverb delay saturation]
  communication = %i[share]
  effect = %i[blur shadow smooth]
  event = %i[touch drag over]
  geometry = %i[width height rotation]
  helper = %i[tactile display]
  hierarchy = %i[parent child insert]
  identity = %i[atome_id id type language private can]
  spatial = %i[width height size x xx y yy z center]
  media = %i[content video box circle text image audio]
  utility = %i[edit record enliven selector render preset]
  material = %i[color opacity border overflow]
  {audios: audio, spatials: spatial, helpers: helper, materials: material, geometries: geometry, effects: effect, medias: media, hierarchies: hierarchy, utilities: utility, communications: communication, identities: identity, events: event}

end

def self.setter_need_pre_processing
  %i[atome_id private can box circle text image video audio]
end

def self.getter_need_processing
  %i[private can box circle text image video audio]
end

def self.no_rendering
  %i[box circle text image video audio]
end

FileUtils.mkdir_p "atome/lib/atome/generated_properties"
atome_methods.each do |property_type, property|
  category = []
  property.each do |method_name|
    if setter_need_pre_processing.include?(method_name)
      processor = "#{method_name}_processor(value)"
    else
      set_instance_variable = "@#{method_name} = atomise(value)"
    end
    if getter_need_processing.include?(method_name)
      getter_processor = "#{method_name}_getter_processor(value)"
    end
    unless no_rendering.include?(method_name)
      rendering = "#{method_name}_html(@#{method_name})"
    end

    method_content = <<STRDELIM
  def #{method_name}(value = nil, &proc)
    if value.nil? && !proc
      #{getter_processor}
      @#{method_name}&.read
    else
      value = properties_common(value, &proc)
       #{processor}
      #{set_instance_variable}
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
end

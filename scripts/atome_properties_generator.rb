def atome_methods
  analyser = %i[listen]
  communication = %i[share]
  effect = %i[blur shadow smooth mask clip noise hue]
  event = %i[touch drag over key scale drop virtual_event]
  geometry = %i[width height size ratio]
  generator = %i[say]
  helper = %i[tactile display orientation status]
  hierarchy = %i[parent child]
  identity = %i[atome_id id type language]
  spatial = %i[x xx y yy z center rotate position alignment disposition]
  media = %i[content particle group container video shape box star circle sphere text
             image audio web  path info example cell name visual active inactive]
  inputs = %i[camera microphone midi keyboard read write]
  utility = %i[edit record enliven tag selector preset monitor selectable dynamic condition treatment render engine pay
               code exec cursor data parameter list action]
  misc = %i[map calendar]
  material = %i[color opacity border overflow fill blend]
  behaviour = %i[animation animator]
  { analysers: analyser, spatials: spatial, helpers: helper, materials: material, geometries: geometry, effects: effect,
    inputs: inputs, medias: media, hierarchies: hierarchy, utilities: utility, communications: communication,
    identities: identity, events: event, generators: generator, miscs: misc, behaviors: behaviour }
end

def types
  %i[user machine shape image video audio input text midi virtual group container particle cell]
end

FileUtils.mkdir_p "atome/lib/atome/generated_methods"

def is_atome
  # in this case presets are used to create atome using their types with specific settings
  # so it add the methods in the atome_object_creator methods
  # the generated property will then return the result of the method instead of object itself
  %i[particle container shape box star web circle sphere text image video audio camera microphone midi group cell list]
end

def need_pre_processing
  %i[atome_id particle group container shape box star web circle sphere text camera microphone midi
  text image video audio  cell parent child type shadow size drag visual noise say content]
end

def need_processing
  %i[monitor active inactive render read write]
end

def getter_need_processing
  %i[parent child content action].concat(is_atome)
end

def no_rendering
  %i[atome_id group container orientation status shape box star web circle sphere text image video audio  parent child info example
     selector tag monitor type alignment camera microphone midi shadow ratio size name dynamic condition path treatment
     particle cell visual language active inactive noise engine render id preset say content read write data parameter action]
end

batch_delete = <<STRDELIM
  def delete(value, &proc)
		collected_atomes=[]
		if q_read.instance_of?(Array)
		  q_read.each do |atome|
			grab(atome).send(:delete, value, &proc)
			collected_atomes << atome
		  end
		else
		  grab(q_read).send(:delete, value, &proc)
		  collected_atomes << q_read
		end
	# we return and atomise collected atomes in case of chain treatment
	ATOME.atomise(:batch, collected_atomes)
  end
STRDELIM

batch_methods = [batch_delete]
atome_methods_list = []
atome_methods.each do |property_type, property|
  category = []
  property.each do |method_name|
    atome_methods_list << method_name
    # atome properties generator
    if need_pre_processing.include?(method_name)
      pre_processor = "#{method_name}_pre_processor(value,password, &proc)"
    else
      set_instance_variable = "@#{method_name} = atomise(:#{method_name},value)"
    end
    if need_processing.include?(method_name)
      processor = "#{method_name}_processor(value,password)"
    end
    if getter_need_processing.include?(method_name)
      getter_processor = "#{method_name}_getter_processor(value)"
    else
      getter_processor = "@#{method_name}&.q_read"
    end

    unless no_rendering.include?(method_name)

      rendering = <<STRDELIM
# lambda below to avoid mthod in method
send_to_#{method_name}_renderer = -> (renderer,value,password) do
case renderer
      when :html
      #{method_name}_html(value,password)
      when :fabric
     #{method_name}_fabric(value,password)
      when :headless
         #{method_name}_headless(value,password)
      when :speech
       #{method_name}_speech(value,password)
      when :three
   #{method_name}_three(value,password)
      when :zim
    #{method_name}_zim(value,password)
    else
      #{method_name}_html(value,password)
    end
end

if $default_renderer.nil?
  #{method_name}_html(value,password)
elsif $default_renderer.instance_of?(Array)
  $default_renderer.each do |renderer|
send_to_#{method_name}_renderer.call(renderer,value,password)
  end
else
send_to_#{method_name}_renderer.call($default_renderer,value,password)

end

STRDELIM
      # rendering = "#{method_name}_html(value,password)"
    end
    unless is_atome.include?(method_name)
      method_return = "self"
    end
    method_content = <<STRDELIM
  def #{method_name}(value =nil ,password=nil, &proc)
    if self.authorization && password!=self.authorization[:password] && :#{method_name} != :type && :#{method_name} != :atome_id
          authorization_pre_processor(:#{method_name},value, self.authorization, &proc)
    else
      if value.nil? && !proc
        #{getter_processor}
      else
if "#{method_name}"== "atome_id"
save= {value.to_s =>  {genesis: value, time: Time.now.to_f}}
else
save= {atome_id => {#{method_name}: value, time: Time.now.to_f}}
end
Quark.time(save)

        value = properties_common(value, &proc)
        #{pre_processor}
        #{set_instance_variable}
        #{processor}
        #{rendering}
        #{method_return}

      end
    end
  end#{' '}

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
  File.write("atome/lib/atome/generated_methods/#{property_type}.rb", category)
  # now we create the method for batch object
  property.each do |method_name|
    batch_method = <<STRDELIM
      def #{method_name}(value, &proc)
        collected_atomes=[]
        if q_read.instance_of?(Array)
          q_read.each do |atome|
            grab(atome).send(:#{method_name}, value, &proc)
            collected_atomes << atome
          end
        else
          grab(q_read).send(:#{method_name}, value, &proc)
          collected_atomes << q_read
        end
        # we return and atomise collected atomes in case of chain treatment
        ATOME.atomise(:batch, collected_atomes)
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
File.write("atome/lib/atome/generated_methods/batch.rb", batch)

methods_list = <<STRDELIM
module AtomeHelpers
  def methods
    #{atome_methods_list.sort}
  end

  def methods_categories
    #{atome_methods}
  end

  def types
    #{types.sort}
  end
end
STRDELIM
File.write("atome/lib/atome/generated_methods/atome_methods.rb", methods_list)

methods_to_create = []
is_atome.each do |object_list|
  #   if object_list == :tool
  #     methods_created = <<STRDEILM
  # def #{object_list}(value = {})
  #   grab(:intuition).#{object_list}(value)
  # end
  # STRDEILM
  #   else
  methods_created = <<STRDEILM
def #{object_list}(value = {})
  grab(:view).#{object_list}(value)
end
STRDEILM
  # end

  methods_to_create << methods_created
end

objects_list_creator = <<STRDELIM
    #{methods_to_create.join("\n")}
STRDELIM
File.write("atome/lib/atome/generated_methods/atome_object_creator.rb", objects_list_creator)
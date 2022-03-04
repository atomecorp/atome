save_path = "atome/lib/atome/generated_methods"

FileUtils.mkdir_p save_path

def atome_methods
  analyser = %i[listen]
  communication = %i[share]
  effect = %i[blur shadow smooth mask clip noise hue]
  event = %i[touch drag over key scale drop virtual_event]
  geometry = %i[width height size ratio]
  generator = %i[say]
  helper = %i[tactile display orientation status fullscreen system]
  hierarchy = %i[parent child]
  identity = %i[atome_id id type language]
  spatial = %i[x xx y yy z center rotate position alignment disposition]
  media = %i[content particle group container video shape box star circle sphere text
                image audio web path info example cell name visual active inactive]
  inputs = %i[camera microphone midi keyboard read write]
  utility = %i[edit record enliven tag selector preset monitor selectable dynamic condition treatment render engine pay
                  code exec cursor data parameter list action]
  misc = %i[map calendar]
  material = %i[color opacity border overflow fill blend]
  behaviour = %i[animation play]
  { analysers: analyser, spatials: spatial, helpers: helper, materials: material, geometries: geometry, effects: effect,
    inputs: inputs, medias: media, hierarchies: hierarchy, utilities: utility, communications: communication,
    identities: identity, events: event, generators: generator, miscs: misc, behaviors: behaviour }
end

def types
  %i[user machine shape image video audio input text midi virtual group container particle cell]
end

def need_new_atome
  # in this case presets are used to create atome using their types with specific settings
  # so it add the methods in the atome_object_creator methods
  # the generated property will then return the result of the method instead of object itself
  %i[particle container shape box star web circle sphere text image video audio camera microphone midi group cell list]
end

def need_pre_processing
  %i[atome_id particle group container shape box star web circle sphere text camera microphone midi
     text image video audio cell parent child type shadow size drag visual noise say content animation]
end

def pre_processor_dont_store_the_property
  %i[noise animation]
end

def need_post_processing
  %i[monitor active inactive render read write]
end

def getter_need_processing
  %i[parent child content action].concat(need_new_atome)
end

def no_rendering
  %i[atome_id group container orientation status shape box star web circle sphere text image video audio parent child
      info example selector tag monitor type alignment camera microphone midi shadow ratio size name dynamic condition path
      treatment particle cell visual language active inactive engine id preset say content read write data
      parameter system action animation]
end

batch_delete = <<STRDELIM
  def delete(value,option={remove_from_parent: true}, &proc)
		collected_atomes=[]
		if q_read.instance_of?(Array)
		  q_read.each do |atome|
			grab(atome)&.send(:delete, value,option, &proc)
			collected_atomes << atome
		  end
		else
		  grab(q_read)&.send(:delete, value,option, &proc)
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
    if need_pre_processing.include?(method_name) && pre_processor_dont_store_the_property.include?(method_name)
      pre_processor = "value = #{method_name}_pre_processor(value,password, &proc)\n@#{method_name} = atomise(:#{method_name}, value)"
    elsif need_pre_processing.include?(method_name)
      pre_processor = "#{method_name}_pre_processor(value,password, &proc)"
    else
      atomiser = "@#{method_name} = atomise(:#{method_name},value)"
    end
    post_processor = "#{method_name}_processor(value,password)" if need_post_processing.include?(method_name)
    getter_processor = if getter_need_processing.include?(method_name)
                         "#{method_name}_getter_processor(value)"
                       else
                         "@#{method_name}&.q_read"
                       end
    unless no_rendering.include?(method_name)

      rendering = <<~STRDELIM
        send_to_render_engine(:#{method_name},value,password)
      STRDELIM
    end
    method_return = "self" unless need_new_atome.include?(method_name)

    method_content = <<~STRDELIM
                   def #{method_name}(value =nil ,password=nil, &proc)
                  	 if authorization && password!= authorization[:password] && :#{method_name} != :type && :#{method_name} != :atome_id
                  		   authorization_pre_processor(:#{method_name},value, self.authorization, &proc)
                  	 else
                  	   if value.nil? && !proc
                  		 #{getter_processor}
                  	   else
      # the code below break child and parent apis
      #             		   value= atome_format_sanitizer(:#{method_name},value, &proc)
                  		 if "#{method_name}"== "atome_id"
                  		   save= {value.to_s =>  {genesis: value, time: Time.now.to_f}}
                  		 else
                  		   save= {atome_id => {#{method_name}: value, time: Time.now.to_f}}
                  		 end
                  		 Quark.time(save)
                  		  # unless :#{method_name} ==:atome_id
                  			value = format_parameters_to_hash(value, &proc)
# puts "msg from atome_script_generator/method_content : "+value.to_s
                  		  # end
                  		 #{pre_processor}
                  		 #{atomiser}
                  		 #{post_processor}
                  		 #{rendering}
                  		 #{method_return}
                  	   end
                  	 end
                   end

                  def #{method_name}=(value, &proc)
                   #{method_name}(value, &proc)
                  end

    STRDELIM
    category << method_content.each_line.reject { |x| x.strip == "" }.join
  end

  category = <<~STRDELIM
    module Properties
    #{category.join("\n")}
    end
  STRDELIM
  File.write("#{save_path}/#{property_type}.rb", category)
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

batch = <<~STRDELIM
  module Batch
  #{batch_methods.join("\n")}
  end
STRDELIM

File.write("#{save_path}/batch.rb", batch)

methods_list = <<~STRDELIM
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

File.write("#{save_path}/atome_methods.rb", methods_list)

methods_to_create = []

need_new_atome.each do |object_list|
  methods_created = <<~STRDEILM
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
File.write("#{save_path}/atome_object_creator.rb", objects_list_creator)
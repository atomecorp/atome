class Atome

  def atomes(full_list = false)
    atomes_found = []
    system_atomes = [:atome, :preset, :black_hole, :device, :intuition, :view, :messenger, :authorization, :buffer, "UI"]
    @@atomes.each do |atome_identity, atome_content|
      if full_list
        atomes_found << atome_identity
      else
        if !system_atomes.include?(atome_identity)
          atomes_found << atome_identity
        end
      end
    end
    atomes_found
  end

  def identity
    "a_" + object_id.to_s + "_" + Atome.atomes.length.to_s + "_" + Time.now.strftime("%Y%m%d%H%M%S")
  end

  def identity_generator
    { a_id: identity }
  end

  def format_parameters_to_hash(value, &proc)
    formatted_value = value
    if proc && (value.instance_of?(String) || value.instance_of?(Symbol) || value == true)
      property = {}
      property[:proc] = proc
      property[:options] = value
      # property[value] = true
      formatted_value = property
    elsif [true, false].include?(value)
      formatted_value = { value: value, proc: proc }
    elsif proc && value.instance_of?(Hash)
      formatted_value = value.merge(proc: proc)
    elsif proc && (value.instance_of?(Integer))
      formatted_value = { value: value, proc: proc }
    elsif proc
      formatted_value = { proc: proc }
    end

    # puts "value #{value} is not formatted, class is : #{value.class}" unless formatted_value.instance_of?(Hash) ||formatted_value.instance_of?(Array)
    # unless formatted_value.instance_of?(Hash) || formatted_value.instance_of?(Array)
    #   # formatted_value = { value: formatted_value }
    #   if formatted_value.instance_of?(TrueClass)
    #     formatted_value = { value: formatted_value }
    #   end
    # end
    formatted_value
  end


  # def atome_format_sanitizer property, value, &proc
  #   puts "msg from extensions atome_helpers atome_format_sanitizer : #{property}"
  #   sanitized_values = []
  #   generated_id = identity_generator
  #   case value
  #
  #   when String, Symbol, TrueClass, FalseClass, Number, Integer, Float
  #     sanitized_values = [generated_id.merge({ data: value })]
  #
  #     # puts "single value passed : #{sanitized_values}"
  #
  #   when Array
  #
  #   else
  #     # we assume it's a Hash
  #     sanitized_values = generated_id.merge(value)
  #   end
  #
  #   # values_array.each_with_index do |prop_value, index|
  #   #   new_stack_item_id = "#{atome_id}_#{property}_stacked_#{index}"
  #   #   if prop_value.class == String
  #   #     prop_value = { value: prop_value, id: new_stack_item_id }
  #   #   else
  #   #     unless prop_value[:atome_id]
  #   #       prop_value[:atome_id] = new_stack_item_id
  #   #     end
  #   #   end
  #   #   sanitized_array << prop_value
  #   # end
  #   sanitized_values
  # end

  def address(&proc)
    address_html(&proc)
  end

  def reboot
    reboot_html
  end

end

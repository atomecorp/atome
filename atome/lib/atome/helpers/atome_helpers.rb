module AtomeHelpers
  def delete
    if Atome.atomes.key?(atome_id)
      # we remove the atome fom the Atome.atomes's hash
      delete_atome = Atome.atomes.delete(atome_id)
      # adding the deleted atome to the black_hole for later retrieve
      grab(:black_hole).content[atome_id] = delete_atome
      # now we remove the atome from view if it is rendered
      unless delete_atome.render == false
        delete_html
      end
    end
  end

  def properties(params = nil)
    if params || params == false
      error("info is read only!! for now")
    else
      properties = {}
      instance_variables.map do |attribute|
        properties[attribute.sub("@".to_sym, "") ] = instance_variable_get(attribute).read
      end
      properties
    end
  end

  def inspect
    properties
  end

  def play(options, &proc)
   play_html(options, &proc)
  end
end
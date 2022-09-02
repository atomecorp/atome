# frozen_string_literal: true

# atome helpers
module Helper

  def add_helper(atome,particle, type_found )
    send(atome).add(particle.merge(type_found))
    atomisation({ atome: atome, type_found => particle })
  end

  def add_helper_no_id(params)
    params[:id] = "atome_#{instance_variables.length}" unless params[:id]
    atome_id = params.delete(:id)
    self.class.send(:attr_accessor, atome_id)
    new_atome = Atome.new
    new_atome.content(params.merge({ id: atome_id }))
    instance_variable_set("@#{atome_id}", new_atome)
    atomisation({ atome: atome_id}.merge(params))

  end

  def replace_helper(targets, new_atome)
    atome_found = send(targets)
    new_content = atome_found.content
    new_content = new_content.merge(new_atome)
    atome_found.content(new_content)
  end

  def activate_hash_deletion(property_targeted, atome_targeted, property)
    atome_targeted.remove_instance_variable(property_targeted)
    atomisation(delete: { property => property_targeted })
  end

  def activate_symbol_deletion(params)
    remove_instance_variable("@#{params}")
    atomisation(delete: params)
  end

  def delete_atome_symbol(params)
    activate_symbol_deletion(params) if validation(:atome, :delete, params)
  end

  def activate_else_deletion_helper(index)
    Utilities.users_atomes.delete_at(index)
    atome_found = Utilities.users_atomes[index]
    atomisation(delete: { atome: atome_found })
  end

  def activate_else_deletion(atome_found, index)
    activate_else_deletion_helper(index) if atome_found.id == id
  end

  def delete_hash_helper(property_targeted, atome_targeted, property)
    activate_hash_deletion(property_targeted, atome_targeted, property)
  end

  def delete_atome_hash_validation(property, index)
    atome_targeted = send(property)
    property_targeted = if index.instance_of?(Symbol || String)
                          "@#{index}"
                        else
                          atome_targeted.instance_variables[index]
                        end
    delete_hash_helper(property_targeted, atome_targeted, property) if validation(:atome, :delete, property_targeted)
  end

  def delete_atome_hash(params)
    params.each do |property, index|
      delete_atome_hash_validation(property, index)
    end
  end

  def delete_atome_array(params)
    params.each do |param|
      delete(param)
    end
  end

  def delete_atome_else
    Utilities.users_atomes.each_with_index do |atome_found, index|
      activate_else_deletion(atome_found, index) if validation(:atome, :delete, { atome_found => index })
    end
  end
end

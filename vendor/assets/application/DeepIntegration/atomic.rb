# frozen_string_literal: true

require './photons'
require './genesis'
require './sanitizer'
require './utilities'

# main entry
class Atome
  include Sanitizer
  include Utilities
  include Genesis

  def initialize(params = {})
    @id = params.delete(:id) if params[:id]
    params.each do |atomes, particles|
      send(atomes, particles)
    end
    Utilities.users_atomes(self)
  end

  def validate_set(atome_found, params, new_content)
    found_type = send(instance_variables[0].to_s.sub('@', '')).content[:type]
    send(atome_found.to_s.sub('@', '')).content(new_content) if validation(:atomes, found_type, params)
  end

  def set(params = nil)
    instance_variables.each do |atome_found|
      new_content = send(atome_found.to_s.sub('@', '')).content.merge(params)
      # TODO: searching for type highly unreliable,we may had a type to pluralized methods and exclude it when reading
      validate_set(atome_found, params, new_content)
    end
  end

  def add_helper(params)
    params[:id] = "atome_#{instance_variables.length}" unless params[:id]
    atome_id = params.delete(:id)
    self.class.send(:attr_accessor, atome_id)
    new_atome = Atome.new
    new_atome.content(params.merge({ id: atome_id }))
    instance_variable_set("@#{atome_id}", new_atome)
  end

  def add(params = {})
    if id
      type_found = { type: params.keys[0].to_s.chomp('s') }
      params.each do |atome, particle|
        send(atome).add(particle.merge(type_found))
      end
    else
      add_helper(params)
    end
  end

  def replace_helper(targets, new_atome)
    atome_found = send(targets)
    new_content = atome_found.content
    new_content = new_content.merge(new_atome)
    atome_found.content(new_content)
  end

  def replace_array(targets, new_atome)
    targets.each do |target|
      replace(target, new_atome)
    end
  end

  def replace(targets, new_atome)
    case targets
    when Integer
      atome_id_found = instance_variables[targets]
      atome_to_replace = atome_id_found.to_s.sub('@', '')
      replace_helper(atome_to_replace, new_atome)
    when Array
      replace_array(targets, new_atome)
    else
      replace_helper(targets, new_atome)
    end
  end

  def render(params)
    # puts "rendering : #{params}"
  end

  def delete_helper_hash(params)
    params.each do |property, index|
      atome_targeted = send(property)
      if index.instance_of?(Symbol || String)
        atome_targeted.remove_instance_variable("@#{index}")
      else
        property_targeted = atome_targeted.instance_variables[index]
        atome_targeted.remove_instance_variable(property_targeted)
      end
    end
  end

  def delete_helper_array(params)
    params.each do |param|
      delete(param)
    end
  end

  def delete_helper_else
    Utilities.users_atomes.each_with_index do |atome_found, index|
      Utilities.users_atomes.delete_at(index) if atome_found.id == id
    end
  end

  def delete(params = nil)
    case params
    when Symbol
      remove_instance_variable("@#{params}")
    when Hash
      delete_helper_hash(params)
    when Array
      delete_helper_array(params)
    else
      delete_helper_else
    end
  end
end

# puts "we must integrate the file : atomeDeepIntegration \n check new tests\n
# methods modified :  id, colors, color, parent, particle_setter_helper, top "

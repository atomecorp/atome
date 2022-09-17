# frozen_string_literal: true

require './helper'
require './photons'
require './genesis'
require './sanitizer'
require './utilities'

# main entry
class Atome
  include Sanitizer
  include Utilities
  include Genesis
  include Helper
  include Photons

  def initialize(params = {})
    if params[:id]
      @id = params.delete(:id)
      # else
      # @id = Atome.generate_identity unless params[:id]
    end
    params.each do |atomes, particles|
      # TODO: get the correct parent not always the view
      check_params(atomes, particles)
      send(atomes, particles)
    end
    Utilities.users_atomes(self)
  end

  def check_params(atomes, particles)
    particles.each do |particle_id, particle|
      # TODO : we must send the singularised atomes not rename it!
      singular_atome = atomes.to_s.chomp('s').to_sym
      new_particle = Sanitizer.add_essential_properties(singular_atome, particle, id)
      particle = new_particle.merge(particle)
      particles[particle_id] = particle
    end
  end

  def self.current_user
    @user = :jeezs
  end

  def self.generate_identity
    @number_of_temp_object = 0 if @number_of_temp_object.instance_of?(NilClass)
    "a_#{@number_of_temp_object += 1}"
  end

  def validate_set(atome_found, params, found_type)
    atomisation({ atome: atome_found, found_type => params })
    new_content = send(atome_found.to_s.sub('@', '')).content.merge(params)
    send(atome_found.to_s.sub('@', '')).content(new_content)
  end

  def set(params = nil)
    instance_variables.each do |atome_found|
      # TODO: searching for type highly unreliable,we may had a type to pluralized methods and exclude it when reading
      found_type = send(instance_variables[0].to_s.sub('@', '')).content[:type]
      validate_set(atome_found, params, found_type) if validation(:atome, found_type, params)
    end
  end

  def add(params = {})
    type_found = :none
    if id
      type_found = { type: params.keys[0].to_s.chomp('s') }
      params.each do |atome, particle|
        add_helper(atome, particle, type_found) if validation(:atomes, type_found, params)
      end
    elsif validation(:atomes, type_found, params)
      add_helper_no_id(params)
    end
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

  def delete(params = nil)
    case params
    when Symbol
      delete_atome_symbol(params)
    when Hash
      delete_atome_hash(params)
    when Array
      delete_atome_array(params)
    else
      delete_atome_else
    end
  end

  def historize(property, value)
    Utilities.history({ @id => { property => value } })
  end
end

# puts "we must integrate the file : atomeDeepIntegration \n check new tests\n
# methods modified :  id, colors, color, parent, particle_setter_helper, top "

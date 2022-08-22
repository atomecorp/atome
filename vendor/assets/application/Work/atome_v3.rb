# frozen_string_literal: true

# v0.1
# rendering engine below

require './photons'
require './genesis'
require './sanitizer'
require './utilities'
require './quark'

# main entry below
class Atome
  include Sanitizer
  include Utilities
  include Genesis
  @atomes = []
  @particles = []
  # Atome.class_variable_set('@@atomes', [])
  # Atome.class_variable_set('@@particles', [])

  def history
    Utilities.instance_variable_get('@history')
  end

  def initialize(params = {})
    params.each do |property, value|
      validation(property, value)
    end
  end

  def self.atomes(atome = nil)
    # this method is used to hold all available type of atomes
    if atome
      # class_variable_get('@@atomes').push(atome)
      instance_variable_get('@atomes').push(atome)
    else
      # class_variable_get('@@atomes')
      instance_variable_get('@atomes')
    end
  end

  def self.particles(particle = nil)
    # this method is used to hold all available type of particles
    if particle
      # class_variable_get('@@atomes').push(atome)
      instance_variable_get('@particles').push(particle)
    else
      # class_variable_get('@@atomes')
      instance_variable_get('@particles')
    end
  end

  def self.current_user
    @user = :jeezs
  end

  def self.identity(_atome)
    @number_of_temp_object = 0 if @number_of_temp_object.instance_of?(NilClass)
    @number_of_temp_object += 1
  end

  def particularize(property, value)
    instance_variable_set("@#{property}", value)
  end

  def renderer(property, value)
    "rendering : #{property} with value : #{value} engine: "
  end

  def getter_stack(instance_content)
    instance_content
  end

  def historize(property, value)
    Utilities.history({ @id => { property => value } })
  end
end

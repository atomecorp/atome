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

  def history
    Utilities.instance_variable_get('@history')
  end

  # def set(params)
  #   # Atome.new(params)
  #   # puts self
  # end

  def initialize(params = {})
    params.each do |property, values|
      validation(property, values)
    end
  end

  def self.atomes(atome = nil)
    # this method is used to hold all available type of atomes
    if atome
      instance_variable_get('@atomes').push(atome)
    else
      instance_variable_get('@atomes')
    end
  end

  def self.particles(particle = nil)
    # this method is used to hold all available type of particles
    if particle
      instance_variable_get('@particles').push(particle)
    else
      instance_variable_get('@particles')
    end
  end

  def self.current_user
    @user = :jeezs
  end

  def self.identity(_atome)
    @number_of_temp_object = 0 if @number_of_temp_object.instance_of?(NilClass)
    "a_#{@number_of_temp_object += 1}"
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

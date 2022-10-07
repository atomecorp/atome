# frozen_string_literal: true

# Utilities
module Utilities
  @history = {}
  @atomes = []
  @particles = []
  @active_atomes = []

  def self.history(params = nil)
    instance_variable_get('@history')[Time.now] = params
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



  def self.grab(params)
    atome_found=nil
    Universe.atomes.each do |atome|
      atome_found = atome if atome.id == params
    end
    atome_found
  end
end

# frozen_string_literal: true

# Utilities
module Utilities
  @atome_list = []
  @particle_list = []
  @renderer_list = [:html, :headless, :server]


  def self.renderer_list(atome = nil)
    @renderer_list
  end
  def self.atome_list(atome = nil)
    # this method is used to hold all available type of atomes
    if atome
      instance_variable_get('@atome_list').push(atome)
    else
      instance_variable_get('@atome_list')
    end
  end

  #
  def self.particle_list(particle = nil)
    # this method is used to hold all available type of particles
    if particle
      instance_variable_get('@particle_list').push(particle)
    else
      instance_variable_get('@particle_list')
    end
  end

  def self.grab(params)
    Universe.atomes[params]
  end




end

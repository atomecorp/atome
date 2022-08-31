# frozen_string_literal: true

# basic atome operations
module Utilities
  @history = {}
  @atomes = []
  @particles = []
  @users_atomes = []

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

  def self.users_atomes(atome = nil)
    # this method is used to hold all available type of atomes
    if atome
      instance_variable_get('@users_atomes').push(atome)
    else
      instance_variable_get('@users_atomes')
    end
  end

  def read
    content = []
    instance_variables.each do |property_found|
      content << send(property_found.to_s.gsub('@', ''))
    end
    content
  end

  # def length
  #   @content.length
  # end
  #
  # def each(&proc)
  #   @content.each do |atome|
  #     atome.instance_exec(&proc) if proc.is_a?(Proc)
  #   end
  # end

  # def range_handling(range, &proc)
  #   if @content[range].instance_of?(Atome)
  #     @content[range]
  #   else
  #     Quark.new(@content[range], &proc)
  #   end
  # end

  def [](range)
    if instance_variables[range].instance_of?(Array)
      instance_variables[range].each do |id|
        send(id.to_s.sub('@', ''))
      end
    else
      send(instance_variables[range].to_s.sub('@', ''))
    end
  end

  def grab(params)
    Utilities.atomes.each do |atome|
      return atome if atome.id == params
    end
  end

  # def last
  #   @content.last
  # end
  #
  # def first
  #   @content[0]
  # end
  #
  # def all(&proc)
  #   range_handling(0..@content.length, &proc)
  # end

  # def grab(atome_id)
  #   all_descendant = @childs.content.concat @content
  #   atome_found = nil
  #   all_descendant.each do |atome|
  #     atome_found = atome if atome_id.to_s == atome.id.to_s
  #   end
  #   atome_found
  # end

  def to_s
    inspect.to_s
  end

  # user must ensure all data are passed and correctly formatted
  # def add(property, value)
  #   "#{property} #{value}"
  # end
  #
  # def delete(params)
  #   params
  # end

  # def batch(atomes)
  #   atomes
  # end
  #
  # def resurrect(params)
  #   params
  # end

  def broadcaster(property, value)
    "#{property} #{value}"
  end

  def id(params = nil)
    if params
      @id = params
    else
      @id
    end
  end

  def content(params = nil)
    if params
      @content = params
    else
      @content
    end
  end
end

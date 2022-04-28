# frozen_string_literal: true
# all created atomes are listed here

class Universe

  def self.initialize
    @atomes = {}
  end

  def self.atomes_add(atome_id,new_atome)
    @atomes[atome_id] = new_atome
  end

  class << self
    attr_reader :atomes
  end

  def self.connected
    true
  end

end


class Quark
  include Batch

  def initialize(property)
    @property = property
  end

  def read
    @property
  end

  # recipient for created atome
  def self.space
    # this method create a class variable to store all created atomes
    Atome.class_variable_set("@@atomes", {}) # you can access without offense
  end

  def to_s
    read.to_s
  end

  def <<(property)
    @property.concat(property)
  end

  def add(values)
    # the test below is necessary when xcreate a new atome with parent
    # in this ca se the parent is injected in the atome properties as a Symbol
    # but Child and parent must be placed in an array
    unless @property.instance_of?(Array)
      @property = [@property]
    end
    @property.concat(values)
  end

  def length
    @property.length
  end

  def [](option)
    required_atome = []
    read.each_with_index do |atome, index|
      if option.instance_of?(Integer)
        if index == option
          required_atome = [atome]
        end
      elsif option.instance_of?(String) || option.instance_of?(Symbol)
        if atome == option
          required_atome = [atome]
        end
      end
    end
    Quark.new(required_atome)
  end
end
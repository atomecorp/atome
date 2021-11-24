class Quark
  include Batch

  def initialize(property)
    @property = property
  end

  def q_read
    @property
  end

  # recipient for created atome
  def self.space
    # this method create a class variable to store all created atomes
    Atome.class_variable_set("@@atomes", {}) # you can access without offense
  end

  def to_s
    q_read.to_s
  end

  def language(international_content)
    atome_id = @property.delete(:atome_id)
    @property = @property.merge(international_content)
    grab(atome_id).content(@property)
    @property
  end

  def <<(property)
    @property.concat(property)
  end

  def add(values)
    # the test below is necessary when xcreate a new atome with parent
    # in this ca se the parent is injected in the atome properties as a Symbol
    # but child and parent must be placed in an array
    unless @property.instance_of?(Array)
      @property = [@property]
    end
    @property.concat(values).uniq!
  end

  def length
    @property.length
  end

  def include?(item)
    @property.include?(item)
  end

  def concat(items)
    @property.concat(items).uniq!
  end

  def find(query)
    atome_list = []
    self.each do |atome|
      atome_list << atome
    end
    grab(:view).find(query, atome_list)
  end

  def [](option)
    if option.instance_of?(Integer) || option.instance_of?(Range)
      required_atome = q_read[option]
    else
      # an atome_id is passed we look for it's index and retrieve the atome
      index = @property.index(option)
      required_atome = q_read[index]
    end
    Quark.new(required_atome)
  end

  def each(&proc)
    @property.each do |property|
      proc.call(grab(property)) if proc.is_a?(Proc)
    end
  end

  def each_with_index(&proc)
    @property.each_with_index do |property, index|
      proc.call(grab(property), index) if proc.is_a?(Proc)
    end
  end

  def last
    @property.last
  end
end
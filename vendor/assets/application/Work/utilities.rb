# basic atome operations
module Utilities
  Utilities.class_variable_set("@@history", {})

  def self.history(params=nil)
    # if params
    class_variable_get("@@history")[Time.now]=params
    # else
    #   Utilities.class_variable_get("@@history")
    # end
  end

  def content
    @content
  end
  def length
    @content.length
  end

  def each(&proc)
    @content.each do |atome|
      atome.instance_exec(&proc) if proc.is_a?(Proc)
    end
  end

  def range_handling(range, &proc)
    if @content[range].instance_of?(Atome)
      @content[range]
    else
      Quark.new(@content[range], &proc)
    end
  end

  def [](range, &proc)
    if @content[range].instance_of? Array
      @content[range].each do |atome|
        atome.instance_exec(&proc) if proc.is_a?(Proc)
      end
    elsif proc.is_a?(Proc)
      @content[range].instance_exec(&proc)
    end
    range_handling(range, &proc)
  end

  def last
    @content.last
  end

  def first
    @content[0]
  end

  def all(&proc)
    range_handling(0..@content.length, &proc)
  end

  def grab(atome_id)
    all_descendant = @childs.content.concat @content
    atome_found = nil
    all_descendant.each do |atome|
      atome_found = atome if atome_id.to_s == atome.id.to_s
    end
    atome_found
  end

  def to_s
    inspect.to_s
  end

  # user must ensure all data are passed and correctly formatted
  def add(property, value)
    "#{property} #{value}"
  end

  def delete(params)
    params
  end

  def batch(atomes)
    atomes
  end

  def resurrect(params)
    params
  end

  def broadcaster(property, value)
    "#{property} #{value}"
  end
end
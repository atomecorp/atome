# frozen_string_literal: true

class Batch

  def each(&proc)
    value.each do |val|
      instance_exec(val, &proc) if proc.is_a?(Proc)
    end
  end

  def id(val = nil)
    if val
      @id = val
    else
      @id
    end
  end

  def initialize(params)
    @id = params[:id] || identity_generator(:batch)
    Universe.add_to_atomes(@id, self)
    Universe.add_to_atomes(@id, self)
  end

  def dispatch (method, *args, &block)
    @data.each do |atome_found|
      atome_found.send(method, *args, &block)
    end
  end

  # TODO:  automatise collector methods creation when creato,g a new atome type
  def color(args, &block)

    dispatch(:color, args, &block)
  end

  def shadow(args, &block)
    dispatch(:color, args, &block)
  end

  def method_missing(method, *args, &block)
    dispatch(method, args, &block)
  end

  def data(collection)
    @data = collection
  end

end
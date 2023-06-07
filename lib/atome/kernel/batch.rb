# frozen_string_literal: true

# this class is used to allow batch treatment
class Batch
  def each(&proc)
    @data.each do |val|
      atome_found = grab(val)
      instance_exec(atome_found, &proc) if proc.is_a?(Proc)
    end
  end

  def initialize(params)
    @data = params
    # self
  end

  def dispatch(method, args, &block)
    @data.each do |atome_found|
      args.each do |arg|
        grab(atome_found).send(method, arg, &block)
      end
    end
    # we return self to allow method chaining
    self
  end

  def to_s
    self.instance_variable_get("@data").to_s
  end
end

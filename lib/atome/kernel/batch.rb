# frozen_string_literal: true

class Batch

  def each(&proc)
    @data.each do |val|
      atome_found=grab(val)
      instance_exec(atome_found, &proc) if proc.is_a?(Proc)
    end
  end

  # def id(val = nil)
  #   if val
  #     @id = val
  #   else
  #     @id
  #   end
  # end

  def initialize(params)
    # @id = params[:id] || identity_generator(:batch)
    # @data=params[:data]
    @data= params
    # Universe.add_to_atomes(@id, self)
    # self
  end

  def dispatch (method, args, &block)
    @data.each do |atome_found|
      args.each do |arg|
        grab(atome_found).send(method, arg, &block)
      end
    end
    # we return self to allow method chaining
    self
  end


  # TODO:  automatise collector methods creation when creating a new atome type
  # def color(args, &block)
  #   alert :ok
  #   # dispatch(:color, args, &block)
  # end

  # def shadow(args, &block)
  #   dispatch(:color, args, &block)
  # end

  # def method_missing(method, *args, &block)
  #   dispatch(method, args, &block)
  # end
  # def color(args)
  #   dispatch(:color, [args], &block)
  # end
  # def data(collection)
  #   @data = collection
  # end

end
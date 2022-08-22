# frozen_string_literal: true

# use to batch range
class Quark
  def initialize(params = [])
    @params = params
  end

  private

  def global(params = nil)
    @params.each do |param|
      param.send(:top, params)
    end
  end

  # def respond_to_missing?; end

  def getter_method(name)
    values = []
    @params.each do |atome|
      values << atome.send(name)
    end
    values
  end

  def respond_to_missing?(name, *args); end

  def method_missing(name, *args)
    if args[0]
      @params.each do |param|
        param.send(name, args[0])
      end
    else
      getter_method(name)
    end
  end

  def to_s
    @params.to_s
  end
end

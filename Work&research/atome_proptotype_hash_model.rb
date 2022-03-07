class Atome

  def initialize
    # @identity= identity_generator
    # @atome = { @identity => {} }
    # @atome[identity_generator] = { identity_generator => { type: :identity }}
    # old code :
    @atome = {}
    @atome = @atome.merge(identity_generator => { type: :identity })
    @atome = @atome.merge(identity_generator + "s" => { type: :shape })
    @atome = @atome.merge(identity_generator + "p" => { type: :preset, data: :box })

  end

  def self.atomes
    []
  end

  def a_id
    @atome.each do |key, value|
      if value[:type] == :identity
        return key
      end
    end
  end

  def color val = nil
    if val.nil?
      @atome.each do |key, value|
        if value[:type] == :color
          if val == :a_id
            return value[:data]
          end
        end
      end
    elsif val == :a_id
      @atome.keys[0]
    else
      @atome[identity_generator + "c"] = { type: :color, data: val }
    end
  end

  def id val = nil
    if val
      @atome[identity_generator + "i"] = { type: :id, data: val }
    else
      @atome.each do |key, value|
        if value[:type] == :id
          return value[:data]
        end
      end
    end
  end

  def x val; end

  def preset val
    box = [{ type: [{ value: :shape }], preset: [{ value: :box }], x: [{ value: 33 }], y: [{ value: 33 }] }]
    { box: box }
  end

  def inspect
    @atome
  end

end

def identity
  "a_" + object_id.to_s + "_" + Atome.atomes.length.to_s + "_" + Time.now.strftime("%Y%m%d%H%M%S")
end

def identity_generator
  identity
end

class Number
end

def format_router params
  case params
  when String, Symbol, TrueClass, FalseClass, Integer, Number, Float
    values = { data: params }
  when Hash
    values = sanitize_hash(params)
  when Array
    values = sanitize_array(params)
  else
    # type code here
  end
  values
end

def sanitize_array params
  formated_array = []
  params.each do |param|
    formated_array << format_router(param)
  end
  formated_array
end

def sanitize_string params
  { prop => [data: params] }
end

def sanitize_hash params
  formated_hash = {}
  params.each do |prop, values|
    formated_hash[prop] = format_router(values)
  end
  formated_hash
end

def format values
  format_router(values)
end

def box(value = nil, password = nil, &proc)

  authorization = true
  creation = true

  if !authorization #authorization && password != authorization[:password] && :shape != :type && :shape != :atome_id
    authorization_pre_processor(:shape, value, self.authorization, &proc)
  else
    if creation
      atome = Atome.new
    else
      a = self
    end
    # def to_s
    #   @atome
    # end

    # puts atome.to_s
    # generated_id = [{ a_d: identity_generator }]
    # generated_id
    # values = format(value)
    # puts "######### results #########"
    # puts "#{values} \n #{values.class}"
    # add_missing_prop
    # reorder
    # pre_process
    # atomise
    # set_prop
    # update history
    # post_process
    # render
    # return value
  end
  atome
end

# box({ x: { data: 44, axis: 33 }, color: :orange, width: 55,
#       blur: { radiance: 12, data: 33 },
#       shadow: [{ data: true, id: :tutu }, true ] })

b = box({ shadow: [true, false], color: :red })
b.color(:blue)
b.id(:toto)
# { shape: { a_id: :a876876, datas: { points: 4 }, preset: :box } }

puts b.inspect

puts b.color
puts b.id
puts b.a_id
puts "#####"
puts b.color(:a_id)
# b.grab(:toto)

# a.color(:red)

# puts identity_generator

a = { a876876: { type: :shape,
                 datas: { points: 4 },
                 preset: :box,
                 a8766576: { type: :color,
                             data: :red,
                             x: 33,
                             y: 66
                 },
                 a9879867: { type: :color,
                             data: :blue,
                             x: 33,
                             y: 66
                 }
} }

class Atome
  def color val

  end

  def a_id val

  end

  def x val

  end

  def preset val
    box = [{ type: [{ value: :shape }], preset: [{ value: :box }], x: [{ value: 33 }], y: [{ value: 33 }] }]
    { box: box }
  end

end

def id_generator
  :a_936393
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
  # test datas below
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
    generated_id = [{ a_d: id_generator }]
    generated_id
    values = format(value)
    # puts "######### results #########"
    puts "#{values} \n #{values.class}"
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

end

# box({ x: { data: 44, axis: 33 }, color: :orange, width: 55,
#       blur: { radiance: 12, data: 33 },
#       shadow: [{ data: true, id: :tutu }, true ] })

b = box({ shadow: [true, false] })

# { shape: { a_id: :a876876, datas: { points: 4 }, preset: :box } }

{ a876876: { type: :shape,
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



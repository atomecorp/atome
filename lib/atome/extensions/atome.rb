# frozen_string_literal: true

def grab(atome_to_get)
  Universe.atomes[atome_to_get]
end

def box(params = {}, &proc)
  grab(:view).box(params, &proc)
end

def circle(params = {}, &proc)
  grab(:view).circle(params, &proc)
end

def matrix(params = {}, &proc)
  grab(:view).matrix(params, &proc)
end

# the method below generate Atome method creation at Object level
def create_method_at_object_level(element)
  Object.define_method element do |params = nil, &user_proc|
    grab(:view).send(element, params, &user_proc)
  end
end

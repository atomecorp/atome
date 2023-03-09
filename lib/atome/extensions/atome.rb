# frozen_string_literal: true
def new(params, &bloc)
  generator = Genesis.generator
  if params.key?(:particle)
    # render indicate if the particle needs to be rendered
    # store tell the system if it need to store the particle value
    # type help the system what type of type the particle will receive and store
    generator.build_particle(params[:particle], { render: params[:render],
                                                  store: params[:store], type: params[:type] }, &bloc)
  elsif params.key?(:atome)
    generator.build_atome(params[:atome], &bloc)
  elsif params.key?(:sanitizer)
    generator.build_sanitizer(params[:sanitizer], &bloc)
  elsif params.key?(:pre)
    generator.build_option("pre_render_#{params[:pre]}", &bloc)
  elsif params.key?(:post)
    generator.build_option("post_render_#{params[:post]}", &bloc)
  elsif params.key?(:browser)
    generator.build_render("browser_#{params[:browser]}", &bloc)
  end
end

def identity_generator(type = :element)
  "#{type}_#{Universe.counter}"
  # { date: Time.now, location: geolocation }
end

def grab(atome_to_get)
  atome_to_get = atome_to_get.value if atome_to_get.instance_of? Atome
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

  Object.define_method element do |params, &user_proc|
    default_parent=Essentials.default_params[element][:attach][0] # we get the first parents
    grab(default_parent).send(element, params, &user_proc)
  end

end

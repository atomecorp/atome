# frozen_string_literal: true

class Object
  def new(params, &bloc)
    generator = Genesis.generator
    if params.key?(:particle)
      # render indicate if the particle needs to be rendered
      # store tell the system if it need to store the particle value
      # type help the system what type of type the particle will receive and store
      generator.build_particle(params[:particle], { render: params[:render], return: params[:return],
                                                    store: params[:store], type: params[:type] }, &bloc)
    elsif params.key?(:atome)
      atome_return = params[:return] || params[:atome]
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
    "#{attach[0]}_#{type}_#{Universe.counter}"
  end

  def grab(atome_to_get)

    Universe.atomes[atome_to_get]
  end

  # def box(params = {}, &proc)
  #   grab(:view).box(params, &proc)
  # end
  #
  # def circle(params = {}, &proc)
  #   grab(:view).circle(params, &proc)
  # end
  #
  # def matrix(params = {}, &proc)
  #   grab(:view).matrix(params, &proc)
  # end

  # def method_missing(method, *args, &block)
  #   args.each do |atome_found|
  #     args.each do |arg|
  #       default_parent = Essentials.default_params[method][:attach][0] # we get the first parents
  #       # create_method_at_object_level(element)
  #       atome_found = grab(default_parent).send(method, arg, &block)
  #       # we force then return of atome found else its return an hash # TODO : we may find a cleaner solution
  #       return atome_found
  #     end
  #   end
  # end

  # the method below generate Atome method creation at Object level
  def atome_method_for_object(element)

    Object.define_method element do |params, &user_proc|
      default_parent = Essentials.default_params[element][:attach][0] # we get the first parents
      grab(default_parent).send(element, params, &user_proc)
    end
  end

  def atome_method_for_batch(element)
    Batch.define_method element do |params, &user_proc|
      dispatch(element, [params], &user_proc)
    end
  end
  def particle_method_for_batch(element)
    Batch.define_method element do |params, &user_proc|
      dispatch(element, [params], &user_proc)
    end
  end

end
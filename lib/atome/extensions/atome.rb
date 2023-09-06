# frozen_string_literal: true

class Object
  def new(params, &bloc)
    generator = Genesis.generator

    if params.key?(:atome)
      generator.build_atome(params[:atome], &bloc)
    elsif params.key?(:particle)
      # render indicate if the particle needs to be rendered
      # store tell the system if it need to store the particle value
      # type help the system what type of type the particle will receive and store
      generator.build_particle(params[:particle], { render: params[:render], return: params[:return], store: params[:store], type: params[:type] }, &bloc)

    elsif params.key?(:specific)

      # alert params
      # Color.define_method params[:method] do |params = nil, &user_proc|
      #   alert "top Color"
      # end


      #######
      requested_module = Object.const_get(params[:specific].to_s.capitalize)

      # Définir une méthode dans le module Color
      # method_name = "ma_methode"  # Remplacez ceci par la manière dont vous obtenez le nom de la méthode, par exemple params[:method]

      requested_module.module_eval do
        define_method(params[:method]) do |params = nil, &user_proc|
          alert "top Color"
        end
      end
      #######
      # alert "=*=*> specific here :  #{params[:method]}"
      # generator.build_atome(params[:atome], &bloc)
    elsif params.key?(:sanitizer)
      generator.build_sanitizer(params[:sanitizer], &bloc)
    elsif params.key?(:pre)
      generator.build_option("pre_render_#{params[:pre]}", &bloc)
    elsif params.key?(:post)
      generator.build_option("post_render_#{params[:post]}", &bloc)
    elsif params.key?(:browser)
      generator.build_render("browser_#{params[:browser]}", &bloc)
    elsif params.key?(:html)
      if params[:exclusive]
        render_method = "html_#{params[:exclusive]}_#{params[:html]}"
        generator.build_render(render_method, &bloc)
      else
        Universe.atome_list.each do |atome_type|
          render_method = "html_#{atome_type}_#{params[:html]}"
          # puts "======> auto generated  : #{render_method}"
          generator.build_render(render_method, &bloc)
        end
      end

    end

  end

  def delete (atomes)
    grab(:view).delete(atomes)
  end

  def identity_generator(type = :element)
    # "#{attach[0]}_#{type}_#{Universe.counter}"
    # "#{id}_#{type}_#{Universe.counter}"
    "#{type}_#{Universe.counter}"
  end

  def grab(atome_to_get)

    Universe.atomes[atome_to_get]
  end

  def box(params = {}, &proc)
    grab(:view).box(params, &proc)
  end

  def vector(params = {}, &proc)
    grab(:view).vector(params, &proc)
  end

  def circle(params = {}, &proc)
    grab(:view).circle(params, &proc)
  end

  def matrix(params = {}, &proc)
    grab(:view).matrix(params, &proc)
  end

  # #############commented batch methods
  # # the method below generate Atome method creation at Object level
  def atome_method_for_object(element)

    Object.define_method element do |params, &user_proc|
      default_parent = Essentials.default_params[element][:attach][0] # we get the first parents
      grab(default_parent).send(element, params, &user_proc)
    end
  end

end
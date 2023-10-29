# frozen_string_literal: true

class Object
  def new(params, &bloc)
    # Genesis = Genesis.Genesis
    if params.key?(:atome)
      Universe.add_atomes_specificities params[:atome]
      Genesis.build_atome(params[:atome], &bloc)
    elsif params.key?(:particle)
      Atome.instance_variable_set("@main_#{params[:particle]}", bloc)
      # render indicate if the particle needs to be rendered
      # store tell the system if it need to store the particle value
      # type help the system what type of type the particle will receive and store
      Genesis.build_particle(params[:particle], { render: params[:render], return: params[:return],
                                                  store: params[:store], type: params[:type] }, &bloc)
    elsif params.key?(:sanitizer)
      Genesis.build_sanitizer(params[:sanitizer], &bloc)
    elsif params.key?(:pre)
      Atome.instance_variable_set("@pre_#{params[:pre]}", bloc)
    elsif params.key?(:post)
      Atome.instance_variable_set("@post_#{params[:post]}", bloc)
    elsif params.key?(:after)
      Atome.instance_variable_set("@after_#{params[:after]}", bloc)
    elsif params[:renderer]
      renderer_found = params[:renderer]
      if params[:specific]
        Universe.set_atomes_specificities(params)
        params[:specific] = "#{params[:specific]}_"
      end
      render_method = "#{renderer_found}_#{params[:specific]}#{params[:method]}"
      Genesis.build_render(render_method, &bloc)
    elsif params.key?(:callback)
      particle_targetted = params[:callback]
      Atome.define_method "#{particle_targetted}_callback" do
        bloc.call
      end
    end

  end

  def delete (atomes)
    grab(:view).delete(atomes)
  end

  def identity_generator(type = :element)
    "#{@type}_#{Universe.counter}"
  end

  def grab(id_to_get)
    id_to_get = id_to_get.to_sym
    Universe.atomes[id_to_get]
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

  # #############commented batch methods
  # # the method below generate Atome method creation at Object level
  def atome_method_for_object(element)

    Object.define_method element do |params, &user_proc|
      default_parent = if Essentials.default_params[element][:attach]
                         # condition default attach value = [] , per example color to avoid colors to be attach to view by default
                         Essentials.default_params[element][:attach][0] || :black_matter
                       else
                         :view
                       end
      grab(default_parent).send(element, params, &user_proc)
    end
  end

  def wait(time, id = nil, &proc)
    # we generate an uniq id
    if time == :kill || time == 'kill'
      JS.eval("clearTimeout(window.timeoutIds['#{id}']);")
    else
      obj = Object.new
      unique_id = obj.object_id

      id = unique_id unless id
      time = time * 1000
      callback_id = "myRubyCallback_#{id}"
      JS.global[callback_id.to_sym] = proc
      JS.eval("if (!window.timeoutIds) { window.timeoutIds = {}; } window.timeoutIds['#{id}'] = setTimeout(function() { #{callback_id}(); }, #{time});")
    end
    id
  end

  def repeater(counter, proc)
    instance_exec(counter, &proc) if proc.is_a?(Proc)
  end

  def repeat(delay = 1, repeat = 0, &proc)
    # below we exec the call a first time
    instance_exec(0, &proc) if proc.is_a?(Proc)
    # as we exec one time above we subtract one below
    `
var  x = 1
var intervalID = window.setInterval(function(){ Opal.Object.$repeater(x,#{proc})
if (++x ===#{repeat} )  {
       window.clearInterval(intervalID);
   }}, #{delay * 1000})
`
  end

end
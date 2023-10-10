# frozen_string_literal: true

new({ particle: :touch, type: :hash, store: false })

new({ sanitizer: :touch }) do |params, _user_bloc|
  # TODO: factorise code below
  @touch = { option: {} } unless @touch
  unless params.instance_of? Hash
    options = {}
    case params
    when true
      options[:option] = :touch
    when :touch
      options[:option] = :touch
    when :down
      options[:option] = :down
    when :up
      options[:option] = :up
    when :long
      options[:option] = :long
    when :double
      options[:option] = :double
    when false
      options[:option] = false
    else
      @touch[:option] = :touch
    end

    params = options
  end

  @touch[:option][params[:option]] = true
  store_value(:touch)
  params
end

new({ particle: :play }) do
  @atome[:pause] = :false
end
new({ particle: :time })
new({ particle: :pause }) do
  @atome[:play] = :false
end
new({ particle: :on })
new({ particle: :fullscreen })
new({ particle: :mute })
new({ particle: :drag, store: false })

new({ sanitizer: :drag }) do |params, _proc|
  # TODO: factorise code below
  @drag = { option: {} } unless @drag
  unless params.instance_of? Hash
    options = {}
    case params
    when true
      options[:option] = :drag
    when :move
      options[:option] = :drag
    when :drag
      options[:option] = :drag
    when :start
      options[:option] = :start
    when :end
      options[:option] = :end
    when false
      options[:option] = false
    else
      @drag[:option] = :drag
    end

    params = options
  end

  @drag[:option][params[:option]] = true
  store_value(:drag)
  params
end


new({ particle: :drop })

new({ sanitizer: :drop }) do |params|
  params = { action: true } if params == true
  params
end

new({ particle: :over, type: :hash, store: false })

new({ sanitizer: :over }) do |params, user_bloc|
  # TODO: factorise code below
  @over = { option: {} } unless @over
  unless params.instance_of? Hash
    options = {}
    case params
    when true
      options[:option] = :over
    when :over
      options[:option] = :over
    when :enter
      options[:option] = :enter
    when :leave
      options[:option] = :leave
    when false
      options[:option] = false
    else
      @over[:option] = :over
    end

    params = options
  end

  @over[:option][params[:option]] = true
  store_value(:over)
  params
end

new({ particle: :sort }) do |_value, sort_proc|
  @sort_proc = sort_proc
end
new({ particle: :targets })
new({ particle: :start })
new({ pre: :start }) do |_value, user_proc|
  @animation_start_proc = user_proc
end
new({ particle: :stop })
new({ pre: :stop }) do |_value, user_proc|
  @animation_stop_proc = user_proc
end
new({ particle: :begin })
new({ particle: :end })
new({ particle: :duration })
new({ particle: :mass })
new({ particle: :damping })
new({ particle: :stiffness })
new({ particle: :velocity })
new({ particle: :repeat })
new({ particle: :ease })
new({ particle: :unbind })


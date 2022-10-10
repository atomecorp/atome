# frozen_string_literal: true

# opal render methods here
module OpalRenderer

  def render_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def type_html(params, atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    send("#{params}_html", params, atome, &proc)
  end

  def color_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    DOM do
      div(id: :the_span).atome "I'm all cooked up!"
    end.append_to($document[:user_view])
    @html_object = $document[:the_span]
    @html_object.style['background-color'] = 'rgba(255, 255, 0,1)'
  end

  def drm_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    # alert parent
  end

  def parent_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    # alert parent
  end

  def shape_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    DOM do
      @toto = div(id: :the_span).atome "I'm all cooked up!"
    end.append_to($document[:user_view])
    @html_object = $document[:the_span]
    @html_object.style['background-color'] = 'rgba(255, 0, 0, 0.3)'
  end

  def id_html(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    @html_object.id = params
  end

  def width_html(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    @html_object.style[:width] = "#{params}px"
  end

  def height_html(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    @html_object.style[:height] = "#{params}px"
  end

  def left_html(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    @html_object.style[:left] = "#{params}px"
  end

  def right_html(params, _atome)
    @html_object.style[:right] = "#{params}px"
  end

  def top_html(params, _atome)
    @html_object.style[:top] = "#{params}px"
  end

  def bottom_html(params, _atome)
    @html_object.style[:bottom] = "#{params}px"
  end

  def red_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)

    # @html_object.style[:color]  = "#{params}px"
  end

  def green_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)

    # @html_object.style[:color]  = "#{params}px"
  end

  def blue_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)

    # @html_object.style[:color]  = "#{params}px"
  end

  def alpha_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    # @html_object.style[:color]  = "#{params}px"
  end

end

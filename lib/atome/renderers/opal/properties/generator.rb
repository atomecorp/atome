# frozen_string_literal: true

# opal render methods here
module OpalRenderer
  def render_html(_params, _atome, &proc)
    # dummy method
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def type_html(params, atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    send("#{params}_html", params, atome, &proc)
  end

  def shape_html(_params, _atome, &proc)
    id_found = id
    instance_exec(&proc) if proc.is_a?(Proc)
    DOM do
      div(id: id_found).atome "I'm totally cooked up!"
    end.append_to($document[:user_view])
    @html_object = $document[id_found]
    @html_type = :div
  end

  def color_html(_params, _atome, &proc)
    id_found = id
    $document[:style] << ".#{id_found}{background-color: red;}"
    instance_exec(&proc) if proc.is_a?(Proc)
    @html_object = $document[id_found]
    @html_type = :style
  end

  def drm_html(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def parent_html(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    if @html_type == :style
      $document[params].add_class(id)
    else
      @html_object.append_to($document[params])
    end
  end

  def id_html(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def width_html(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    @html_object.style[:width] = "#{params}px" unless @html_type == :style
  end

  def height_html(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    @html_object.style[:height] = "#{params}px" unless @html_type == :style
  end

  def left_html(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    @html_object.style[:left] = "#{params}px" unless @html_type == :style
  end

  def right_html(params, _atome)
    @html_object.style[:right] = "#{params}px" unless @html_type == :style
  end

  def top_html(params, _atome)
    @html_object.style[:top] = "#{params}px" unless @html_type == :style
  end

  def bottom_html(params, _atome)
    @html_object.style[:bottom] = "#{params}px" unless @html_type == :style
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

# frozen_string_literal: true

# opal render methods here
module OpalRenderer
  def render_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render html #{params}"
  end

  def id_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render id_html #{params}"
  end

  def left_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render left_html #{params}"
  end

  def right_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render right_html #{params}"
  end

  def top_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render top_html #{params}"
  end

  def bottom_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render bottom_html #{params}"
  end

  def red_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render red_html #{params}"
  end

  def green_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render green_html #{params}"
  end

  def blue_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render blue_html #{params}"
  end

  def alpha_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render alpha_html #{params}"
  end

  def drm_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render drm_html #{params}"
  end

  def parent_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- parent_html is #{params}"
  end

  def width_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render width_html #{params}"
  end

  def height_html(params, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    puts "---- render height_html #{params}"
  end

  def type_html(params, &proc)
    puts "-------type"
    instance_exec(&proc) if proc.is_a?(Proc)
    send("#{params}_html", &proc)
  end

  def shape_html(&proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    # @html_object= `document.createElement('div')`
    # puts '::::::: setting specific options for shape atome'
  end

  def color_html(&proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    # puts '::::::: setting specific options for color atome'
  end
end

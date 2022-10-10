# frozen_string_literal: true

# headless render methods here
module HeadlessRenderer

  def render_headless(_params, _atome, &proc)
    # dummy method
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def type_headless(params, atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    # puts "1 - render type #{params}"
    send("#{params}_headless", params, atome, &proc)
  end

  # type below
  def shape_headless(_params, _atome, &proc)
    # puts "2 - render shape #{_params}"
    @headless_object=self
  end

  def color_headless(_params, _atome, &proc)
    # puts "2 - render color #{_params}"
  end

  def id_headless(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    # puts "3 - render id #{_params}"
  end

  def left_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render left #{params}"
  end

  def right_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render right #{params}"
  end

  def top_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render top #{params}"
  end

  def bottom_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render bottom #{params}"
  end

  def red_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render red #{params}"
  end

  def green_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render green #{params}"
  end

  def blue_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render blue #{params}"
  end

  def alpha_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render render #{params}"
  end

  def drm_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render alpha #{params}"
  end

  def parent_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render parent #{params}"
  end

  def width_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render width #{params}"
  end

  def height_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render height #{params}"
  end

end

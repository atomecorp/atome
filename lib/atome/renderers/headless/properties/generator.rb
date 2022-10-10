# frozen_string_literal: true

# headless render methods here
module HeadlessRenderer
  def render_headless(_params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
  end

  def id_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render id #{params}"
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

  def type_headless(params, _atome, &proc)
    instance_exec(&proc) if proc.is_a?(Proc)
    "render type #{params}"
  end
end

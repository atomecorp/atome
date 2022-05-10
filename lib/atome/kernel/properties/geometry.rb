# frozen_string_literal: true
# here are the geometry  properties of atome


module AtomeGeometryMethods

  # def dummy(value = nil, stack_property = nil)
  #   property = :dummy
  #   optional_processor = { pre_process: true, post_process: true, store_atome: false, render_atome: false }
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  # def universe(value = nil, stack_property = nil)
  #   property = :universe
  #   optional_processor = {}
  #   # properties_common(property, value, stack_property, optional_processor)
  # end

  def color(params, formated = false)
    formated
    puts "params #{params} must be formated"
  end

  def parent(value = nil, stack_property = nil)
    property = :parent
    optional_processor = { pre_process: true, post_process: true }
    properties_common(property, value, stack_property, optional_processor)
  end

  def left(value = nil, stack_property = nil)
    property = :left
    optional_processor = {}
    properties_common(property, value, stack_property, optional_processor)
  end

  def top(value = nil, stack_property = nil)
    property = :top
    optional_processor = {}
    properties_common(property, value, stack_property, optional_processor)
  end
  #
  # def bottom(value = nil, stack_property = nil)
  #   property = :bottom
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  def right(value = nil, stack_property = nil)
    property = :right
    optional_processor = {}
    properties_common(property, value, stack_property, optional_processor)
  end
  #
  # def child(value = nil, stack_property = nil)
  #   property = :child
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  # def id(value = nil, stack_property = nil)
  #   property = :id
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  # def name(value = nil, stack_property = nil)
  #   property = :name
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  # def view(value = nil, stack_property = nil)
  #   property = :view
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  # def type(value = nil, stack_property = nil)
  #   property = :type
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  # def preset(value = nil, stack_property = nil)
  #   property = :preset
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #

  #
  # def red(value = nil, stack_property = nil)
  #   property = :red
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  # def green(value = nil, stack_property = nil)
  #   property = :green
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  # def blue(value = nil, stack_property = nil)
  #   property = :blue
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  # def alpha(value = nil, stack_property = nil)
  #   property = :alpha
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
  #
  # def radiation(value = nil, stack_property = nil)
  #   property = :radiation
  #   optional_processor = {}
  #   properties_common(property, value, stack_property, optional_processor)
  # end
end
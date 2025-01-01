#  frozen_string_literal: true

b = text({ id: :toto, left: 0, data: :inspect, depth: 12 })

c = text({ id: :the_c, left: 190, data: 'stop inspect', depth: 12 })
box({ left: 120, top: 120, width: 333, height: 333, id: :helper })

class Atome

  def follow_cursor(div_id, item_to_be_monitored, &proc)
    @inspector_active = true
    last_collided_element = nil

    JS.global[:document].addEventListener('mousemove', @mousemove_listener = proc do |native_event|
      next unless @inspector_active
      event = Native(native_event)
      element = JS.global[:document].getElementById(div_id)
      width = element[:offsetWidth].to_i
      height = element[:offsetHeight].to_i

      left = event[:clientX].to_i - (width / 2)
      top = event[:clientY].to_i - (height / 2)

      element[:style][:left] = "#{left}px"
      element[:style][:top] = "#{top}px"

      last_collided_element = check_collision(element, item_to_be_monitored, last_collided_element,&proc)
    end)

    JS.global[:document].addEventListener('touchmove', @touchmove_listener = proc do |native_event|
      next unless @inspector_active
      event = Native(native_event)

      touch = event[:touches][0]
      element = JS.global[:document].getElementById(div_id)
      width = element[:offsetWidth].to_i
      height = element[:offsetHeight].to_i

      left = touch[:clientX].to_i - (width / 2)
      top = touch[:clientY].to_i - (height / 2)

      element[:style][:left] = "#{left}px"
      element[:style][:top] = "#{top}px"

      last_collided_element = check_collision(element, item_to_be_monitored, last_collided_element)
    end)
  end

  def unbind_inspector(div_id)
    @inspector_active = false
    JS.global[:console].log("Inspector disabled for element: #{div_id}")
  end

  # private

  def check_collision(follow_div, item_to_be_monitored, last_collided_element,&proc)
    ids_to_check = item_to_be_monitored

    ids_to_check.each do |id|
      element = JS.global[:document].getElementById(id.to_s)

      if element && is_colliding(follow_div, element)
        if last_collided_element != element[:id]
          proc.call(element[:id].to_s.to_sym) unless element[:id] == follow_div[:id]
          return element[:id] # Return the current collided element
        else
          return last_collided_element # Return the same element if it's still the same
        end
      end
    end

    return nil # Return nil if no collision is detected
  end

  def is_colliding(div1, div2)
    rect1 = div1.getBoundingClientRect()
    rect2 = div2.getBoundingClientRect()

    rect1_right = rect1[:right].to_f
    rect1_left = rect1[:left].to_f
    rect1_bottom = rect1[:bottom].to_f
    rect1_top = rect1[:top].to_f

    rect2_right = rect2[:right].to_f
    rect2_left = rect2[:left].to_f
    rect2_bottom = rect2[:bottom].to_f
    rect2_top = rect2[:top].to_f

    !(rect1_right < rect2_left ||
      rect1_left > rect2_right ||
      rect1_bottom < rect2_top ||
      rect1_top > rect2_bottom)
  end

  def inspection(active)
    if active
      circle({ width: 15, height: 15, left: 99,
               color: {red: 0.7, green: 0.7,blue: 0.7,alpha: 0.3},
               id: :inspector_satellite,
               shadow: {alpha: 0.7, blur: 9}})
      follow_cursor('inspector_satellite', fasten) do |id|
        puts "collision detected with element: #{id}"
        current_obj=grab(id)
        puts current_obj.infos
      end
    else
      unbind_inspector(:inspector_satellite)
      grab(:inspector_satellite).delete(true)
    end
  end
end

########
events_list = []
Universe.particle_list.each do |particle, content|
  if content[:category] == :event
    events_list << particle
  end
end

b.touch(true) do
  grab(:view).inspection(true)
end

c.touch(true) do
  grab(:view).inspection(false)
end

##############################

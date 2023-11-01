# frozen_string_literal: true

circ = circle({ drag: true })
circ.remove({ all: :color })
col_1=circ.color(:white)
col_2=circ.color({ red: 1, id: :red_col })
col_4=circ.color({ red: 1, id: :red_col2 , alpha: 0.3})
col_5=circ.color({ red: 1, green: 1,id: :red_col3 , alpha: 0.3})
col_3=circ.color(:yellow)
wait 1 do
  painter_0=circ.paint({ gradient:  [col_1.id, col_2.id], direction: :left  })
  # wait 1 do
  painter= circ.paint({id: :the_painter, gradient:  [col_1.id, col_2.id], direction: :left })
  # alert painter.inspect
  wait 1 do
    circ.color(:cyan)
    circ.paint({ gradient:[col_1.id, col_2.id, col_3.id], diffusion: :conic })
    wait 1 do
      painter= circ.paint({id: :the_painter, gradient: [col_1.id, col_2.id, col_3.id], direction: :left })

      wait 1 do
        circ.color(:blue)
        circ.paint({ gradient:[col_4.id, col_5.id], diffusion: :radial })
      end
    end
  end
  # end

  # alert circ.apply
  # alert painter.inspect

  #
end
#TODO : gradient on text!

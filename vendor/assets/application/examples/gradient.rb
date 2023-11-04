# frozen_string_literal: true

circ = circle({ drag: true })
circ.remove({ all: :color })
col_1 = circ.color(:white)
col_2 = circ.color({ red: 1, id: :red_col })
col_4 = circ.color({ blue: 1, id: :red_col2, alpha: 0.3 })
col_5 = circ.color({ red: 0, green: 1, id: :red_col3, alpha: 0.7 })
col_3 = circ.color(:yellow)
wait 0.5 do
  circ.paint({ gradient: [col_1.id, col_2.id], direction: :left })
  wait 0.5 do
    circ.paint({ id: :the_painter, rotate: 69, gradient: [col_1.id, col_2.id] })
    wait 0.5 do
      circ.color(:cyan)
      circ.paint({ gradient: [col_1.id, col_2.id, col_3.id], rotate: 33, diffusion: :conic })
      wait 0.5 do
        painter = circ.paint({ id: :the_painter2, gradient: [col_1.id, col_2.id, col_3.id], direction: :left })
        wait 0.5 do
          circ.color(:blue)
          circ.paint({ gradient: [col_4.id, col_5.id], diffusion: :conic })
        end
      end
    end
  end

end

the_text = text({ data: 'hello for al the people in front of their machine', center: true, top: 222, width: 777, component: { size: 66 } })

the_text.left(333)

  the_text.paint({ gradient:  [col_1.id, col_2.id], direction: :left , id: :painted_love })

# #TODO : gradient on text!

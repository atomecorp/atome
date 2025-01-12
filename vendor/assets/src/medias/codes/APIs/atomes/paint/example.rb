# frozen_string_literal: true

c=circle({drag: true, id: :the_circle})

c1=c.color(:white).id
c2=c.color(:red).id
c3=c.color(:yellow).id
color({id: :my_col1, red: 1 , alpha: 0.5})
wait 0.5 do
  c.paint({ gradient: [c1,c2], direction: :left })
  wait 0.5 do
    wait 0.5 do
      c.paint({ gradient: [c1,c2], diffusion: :radial })
      wait 0.5 do
        cc= c.paint({ gradient: [c1,c2, c3], diffusion: :conic })
        wait 0.5 do
          # cc.delete(true)
          #   alert c.paint
          c.remove({all: :paint})
          # alert c.paint
          wait 0.6 do
            c.color(:red)
          end
          # c.paint({ gradient: [c3, c3], diffusion: :conic })
        end
      end
    end
  end
end

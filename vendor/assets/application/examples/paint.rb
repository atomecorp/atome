# frozen_string_literal: true

c=circle({drag: true})

c1=c.color(:white).id
c2=c.color(:red).id
c3=c.color(:yellow).id
wait 0.5 do
  c.paint({ gradient: [c1,c2] })
  wait 0.5 do
    c.paint({ gradient: [c1,c2, c3], direction: :left })
    wait 0.5 do
      c.paint({ gradient: [c1,c2], diffusion: :radial })
      wait 0.5 do
        c.paint({ gradient: [c1,c2, c3], diffusion: :conic })
        wait 0.5 do
          c.remove({all: :color})
          c.remove({all: :paint})
        end
      end
    end
  end
end

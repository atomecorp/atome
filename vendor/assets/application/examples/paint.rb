# frozen_string_literal: true

c=circle({drag: true})

c.color(:white)
c.color(:red)
c.color(:yellow)
wait 1 do
  c.paint({ gradient: true })
  wait 1 do
    c.paint({ gradient: true, direction: :left })
    wait 1 do
      c.paint({ gradient: true, diffusion: :radial })
      wait 1 do
        c.paint({ gradient: true, diffusion: :conic })
        wait 2 do
          c.remove({all: :color})
        end
      end
    end
  end
end

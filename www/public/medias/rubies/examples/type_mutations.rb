# type mutation

parent = circle({ overflow: :hidden, width: 300,
                  height: 300, color: :orange, drag: true })
b = parent.circle({ atome_id: :b, content: :boat, drag: true, x: 96, y: 96 })

ATOME.wait 1 do
  b.type(:image)
  b.content(:boat)
  ATOME.wait 1 do
    b.content(:moto)
    ATOME.wait 1 do
      b.type(:text)
      ATOME.wait 1 do
        b.color(:black)
        ATOME.wait 1 do
          b.smooth(100)
          b.type(:shape)
          ATOME.wait 1 do
            b.smooth(0)
            b.type(:text)
          end
        end
      end
    end
  end
end
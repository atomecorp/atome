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
      # b.content(:boat)
      ATOME.wait 1 do
        b.type(:shape)
        # b.content(:boat)
      end
    end
  end
end
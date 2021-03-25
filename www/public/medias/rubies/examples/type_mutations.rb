b=circle({atome_id: :b, content: :boat})
ATOME.wait 1 do
  b.type(:image)
  b.content(:boat)
  #b.render(true)
  ATOME.wait 1 do
    b.content(:moto)
    ATOME.wait 1 do
      b.type(:text)
      #b.content(:moto)
      ATOME.wait 1 do
        b.type(:shape)
        #b.content(:moto)
      end
    end
  end
end
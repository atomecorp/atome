# text selection example

t = text({ content: "type what you want", x: 333 })
t.visual(33)

t.key(:down) do 
  w_get = JSUtils.client_width(t.atome_id)
  t.width = :auto
  t.width = if w_get > 300
              300
            else
              :auto
            end
end
t.key(:up) do |evt|
  w_get = JSUtils.client_width(t.atome_id)
  t.width = if w_get < 99
              99
            elsif w_get > 300
              300
            else
              :auto
            end
end
t.border(({ color: :red, thickness: 3, pattern: :dashed }))
t.over do
  t.visual({ select: :all })
end

t.touch do
  t.visual({ select: :all })
end


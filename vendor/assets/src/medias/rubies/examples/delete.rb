# frozen_string_literal: true

b = box({left: 333})

b.circle({top: 66, id: :the_circle, color: :green})

wait 4 do
  b.delete(true)
end

wait 3 do
  b.children.value.each do |attached_atome_id|
    b.delete({id: attached_atome_id})
    b.shadow({ renderers: [:browser], id: :shadow2, type: :shadow, parents: [], children: [],
                left: 3, top: 9, blur: 3, direction: '',
                red: 0, green: 0, blue: 0, alpha: 1
              })
  end

end

wait 2 do
  b.delete(:left)
end


wait 1 do
  b.delete({id: :the_circle})
end

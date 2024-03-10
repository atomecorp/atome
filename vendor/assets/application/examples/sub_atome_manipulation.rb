# frozen_string_literal: true


b=box({id: :the_box})
b.text({id: :the_text, left: 90, top: 30, data: :ok})
b.text({id: :the_text2, left: 190, top: 30, data: :hello})



wait 1 do
  b.text.each_with_index do |el, _index|
    grab(el).left(30)
  end
  # b.text.left(30)
  wait 1 do
    b.text.color(:white)
    b.text.each_with_index do |el, index|
      grab(el).left(30+30*index)
    end
    b.color(:black)
  end
end
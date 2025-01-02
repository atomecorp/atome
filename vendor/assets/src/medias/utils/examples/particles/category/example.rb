# frozen_string_literal: true

# assign a class to atom object in the webview

t=text('touch the box')
b=box({ left: 12, id: :the_first_box })
b.category(:matrix)
b.touch(true) do
  b.remove({ category: :matrix})
  t.data= " category is : #{b.category}"
  wait 1 do
    b.category(:new_one)
    t.data= " category is : #{b.category}"
  end
end
t.data= " category is : #{b.category} "

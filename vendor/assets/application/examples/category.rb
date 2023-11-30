# frozen_string_literal: true

# assign a class to atom object in the webview

t=text('touch the box')
b=box({ left: 12, id: :the_first_box })
b.category(:matrix)
b.touch(true) do
  b.remove({ category: :matrix})
  t.data= " category is : #{b.category} + look in the browser console"
end
t.data= " category is : #{b.category} + look in the browser console"

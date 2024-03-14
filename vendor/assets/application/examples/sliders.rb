# frozen_string_literal: true
label=text({data: 0, top: 69, left: 69,attach:  :intuition, component: { size: 12 }, color: :gray})

A.slider({width: 333} ) do |value|
  label.data("(#{value})")
end

# frozen_string_literal: true

b=box({right: 45, left: :auto})
b.css[:style][:border] = '2px solid yellow'
puts  b.css[:style][:border]
puts b.css
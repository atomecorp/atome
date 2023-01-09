# frozen_string_literal: true

a=Atome.new(code: { type: :code, renderers: [:headless], parents: [], children: [] }) do  |params_found|
  puts "the param is #{params_found}"
end
a.run(:super)
c=element({}) do |params_found|
  puts "you want me to print:  #{params_found}"
end

c.run('it works')
# frozen_string_literal: true
new({ particle: :run }) do |params, code|
  code_found = @code_code[:code]
  instance_exec(params, &code_found) if code_found.is_a?(Proc)
end
a = box
a.code(:hello) do
  circle({ left: 333 })
end
wait 1 do
  a.run(:hello)
end


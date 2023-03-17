# frozen_string_literal: true

b=circle({left: 333, id: :the_c})
b.touch(true) do
  self.color(:blue)
end

b.touch(:long) do
  self.color(:red)

end

b.over(:enter) do
  c.color(:red)
  self.color(:black)

end

b.over(:leave) do

  self.color(:blue)
end

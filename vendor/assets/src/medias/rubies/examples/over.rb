# frozen_string_literal: true

b=circle
b.touch(true) do
  self.color(:blue)
end

b.touch(:long) do
  self.color(:red)

end

b.over(:enter) do
  self.color(:red)
end

b.over(:leave) do
  self.color(:blue)
end
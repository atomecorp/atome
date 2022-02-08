# current_code example
text " attention this code  work better when extracted from examples\n touch the box below"
# JSUtils.load_opal_parser
b=box({y: 120})

b.touch do
  current_code(["./medias/rubies/examples/refresh.rb","./medias/rubies/examples/blur.rb"])
  # wait 2 do
  refresh current_code
  # end
  # reader(current_code) do |script|
  #   compile script
  # end
end
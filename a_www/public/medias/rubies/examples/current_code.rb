# current_code example
text " attention this code  work better when extracted from examples\n touch the box below"
# JSUtils.load_opal_parser
b=box({y: 120})

b.touch do
  current_code(["./medias/rubies/examples/refresh.rb","./medias/e_app/app.rb"])
  refresh current_code
  # reader(current_code) do |script|
  #   compile script
  # end
end
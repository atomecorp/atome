# current_code example

JSUtils.load_opal_parser
b=box

b.touch do
  current_code(["./medias/rubies/examples/refresh.rb","./medias/e_app/app.rb"])
  refresh current_code
  # reader(current_code) do |script|
  #   compile script
  # end
end
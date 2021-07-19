#eaxample read file
# JSUtils.load_opal_parser

t=text("Touch me load and exec the ruby code")
t.touch do
  reader("./medias/rubies/test.rb") do |data|
    compile data
  end
end

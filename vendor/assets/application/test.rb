# frozen_string_literal: true

# my code here ..

# open the console in your browser ou your native app and should see the text below
cmd=text ({data: "ruby run_server.rb", left: 0, top: 0, edit: true})
response_text=text ({data: "response_here", top: 444, edit: true})
image(:red_planet)

image({path: 'medias/images/logos/atome.svg', width: 33})

commanditor=circle({left: 6,top: 255, width: 33, height: 33, color: :black})
commanditor.touch(true) do
  cmd_to_send=cmd.data.downcase
  A.terminal(cmd_to_send) do |data|
    response_text.data(data.downcase)
  end
end

evaluator=circle({top: 255, width: 33, height: 33, color: :orange})
evaluator.touch(true) do
  code_found=cmd.data.downcase
  eval(code_found)
end
terminator=circle({left: 190,top: 255, width: 33, height: 33, color: :red})
terminator.touch(true) do
  JS.global[:location].reload()
end


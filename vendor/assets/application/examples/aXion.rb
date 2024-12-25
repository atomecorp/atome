#  frozen_string_literal: true

c=circle

c.touch(true) do
  # c.message({data: 'cd ..;cd server;ls; pwd', action: :terminal }) do |result|
  #   alert  "shell command return: #{result}"
  # end

  c.message({data: "cherche un fichier qui se nomme  capture  et ouvre le avec  l'application par defaut", user_key: 'your OpenAI key here',  action: :axion }) do |result|
    puts  "my command return: #{result}"
  end

  # c.message({data: "liste moi tous les fichers et dossiers que tu trouve", user_key: 'your OpenAI key here',  action: :axion }) do |result|
  #   puts  "my command return: #{result}"
  # end

  {} #must add an empty hash else events events method will interpret keys of the hash and send a missing method errors
end
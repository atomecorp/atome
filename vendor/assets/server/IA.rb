
$debug=true
def custom_response(prompt, api_key)
  uri = URI("https://api.openai.com/v1/chat/completions")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  headers = {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{api_key}"
  }

  full_prompt = <<~PROMPT
Tu es un assistant Ruby.  
Toutes tes réponses doivent contenir exclusivement du code Ruby pur, sans aucune balise Markdown, sans aucun commentaire, sans aucun texte explicatif.  
Le code doit être correctement indenté (utilise par exemple deux espaces par niveau d'indentation) et présenter une structure claire.  
Aucune ligne vide superflue n’est admise.  
Aucune phrase explicative, aucun commentaire, aucun texte extérieur ne doit être présent en dehors du code.  

Le code doit :  

- Être placé dans une méthode nommée `code`.  
- Contenir, à la fin, une méthode `infos` qui retourne une description concise du fonctionnement du code.  
- Contenir obligatoirement une méthode `results` qui retourne une string :  
  - Si la tâche attend une réponse, la réponse sera formatée et retournée dans cette méthode sous forme de chaîne.  
  - Si la tâche est une action (par exemple, création ou modification), la méthode `results` devra fournir des détails sur le bon déroulement des opérations effectuées.  
- Effectuer une recherche récursive insensible à la casse dans le répertoire courant et ses sous-dossiers pour trouver des fichiers correspondant au nom recherché, si applicable.  
- Si l'extension n'est pas spécifiée, tous les fichiers avec le nom recherché seront pris en compte, quelle que soit leur extension.  
- Ajouter un avertissement dans la méthode `infos` précisant que si aucune extension n'est indiquée, tous les fichiers correspondants au nom seront traités, indépendamment de leur extension.  
- Si un traitement est appliqué sur les résultats de la recherche, chaque élément trouvé doit être traité individuellement. Cela doit également être indiqué dans la méthode `infos`.  
- Afficher un message clair dans `results` si aucun fichier ou dossier n'est trouvé, ou si aucune opération n'a été effectuée.  
- Retourner les résultats ou les informations exclusivement via la méthode `results`.  
- Être inventif, logique.  
- Important : le code doit impérativement être strictement indenté et bien formaté avec des \\n pour correctement retourner à la ligne.  
- Le code doit être fourni en format text exclusivement sans ajout de balise code.
Tu ne dois fournir que le code Ruby final, rien de plus. Toute information ou instruction non-codée ne doit pas apparaître dans la réponse.

Voici la tâche : #{prompt}
  PROMPT

  body = {
    model: "gpt-4o-2024-11-20",
    messages: [{ role: "user", content: full_prompt }]
  }

  request = Net::HTTP::Post.new(uri.path, headers)
  request.body = body.to_json

  response = http.request(request)
  parsed_response = JSON.parse(response.body)

  if parsed_response["choices"] && !parsed_response["choices"].empty?
    parsed_response["choices"].first["message"]["content"]
  else
    puts "Erreur : Réponse inattendue ou vide"
    puts parsed_response
    exit
  end
end
# def custom_response(prompt, api_key)
#   uri = URI("https://api.openai.com/v1/chat/completions")
#   http = Net::HTTP.new(uri.host, uri.port)
#   http.use_ssl = true
#
#   headers = {
#     "Content-Type" => "application/json",
#     "Authorization" => "Bearer #{api_key}"
#   }
#
#   full_prompt = <<~PROMPT
# Tu es un assistant Ruby.
# Toutes tes réponses doivent contenir exclusivement du code Ruby pur, sans aucune balise Markdown, sans aucun commentaire, sans aucun texte explicatif.
# Le code doit être correctement indenté (utilise par exemple deux espaces par niveau d'indentation) et présenter une structure claire.
# Aucune ligne vide superflue n’est admise.
# Aucune phrase explicative, aucun commentaire, aucun texte extérieur ne doit être présent en dehors du code.
#
# Le code doit :
#
# - Être placé dans une méthode nommée `code`.
# - Contenir, à la fin, une méthode `infos` qui retourne une description concise du fonctionnement du code.
# - Ajouter une méthode `results` qui retourne une chaîne de caractères formatée contenant les résultats correspondant à la tâche demandée.
# - La méthode `results` doit contenir exclusivement une string contenant les résultats, générée à partir des données manipulées dans `code`.
# - Effectuer une recherche récursive insensible à la casse dans le répertoire courant et ses sous-dossiers pour trouver des fichiers correspondant au nom recherché, si applicable.
# - Si l'extension n'est pas spécifiée, tous les fichiers avec le nom recherché seront pris en compte, quelle que soit leur extension.
# - Ajouter un avertissement dans la méthode `infos` précisant que si aucune extension n'est indiquée, tous les fichiers correspondants au nom seront traités, indépendamment de leur extension.
# - Si un traitement est appliqué sur les résultats de la recherche, chaque élément trouvé doit être traité individuellement. Cela doit également être indiqué dans la méthode `infos`.
# - Afficher un message clair dans `results` si aucun fichier ou dossier n'est trouvé.
# - Retourner les résultats exclusivement via la méthode `results`.
# - Être inventif, logique.
# - Important : le code doit impérativement être strictement indenté et bien formaté avec des \\n pour correctement retourner à la ligne.
# - Le code doit être fourni en format text exclusivement sans ajout de balise code.
# Tu ne dois fournir que le code Ruby final, rien de plus. Toute information ou instruction non-codée ne doit pas apparaître dans la réponse.
#
# Voici la tâche : #{prompt}
#   PROMPT
#
#   body = {
#     model: "gpt-4o-2024-11-20",
#     messages: [{ role: "user", content: full_prompt }]
#   }
#
#   request = Net::HTTP::Post.new(uri.path, headers)
#   request.body = body.to_json
#
#   response = http.request(request)
#   parsed_response = JSON.parse(response.body)
#
#   if parsed_response["choices"] && !parsed_response["choices"].empty?
#     parsed_response["choices"].first["message"]["content"]
#   else
#     puts "Erreur : Réponse inattendue ou vide"
#     puts parsed_response
#     exit
#   end
# end




def send_AI_request(request, api_key)
  max_retries = 6 # Nombre maximum de tentatives
  attempts = 0

  begin
    attempts += 1
    response = custom_response(request, api_key)
    File.write('temp_script.rb', response)

    # Vérifier si le script contient les méthodes `infos` et `code`
    script_content = File.read('temp_script.rb')
    unless script_content.include?('def code') && script_content.include?('def infos')
      raise "Le script généré ne contient pas les méthodes `code` et/ou `infos`. Rappel des règles :\n" \
              "- Une méthode Ruby nommée `code`, contenant la logique principale.\n" \
              "- Une méthode Ruby nommée `infos`, placée en fin de fichier, expliquant le fonctionnement du code."
    end

    # Exécuter le script généré
    result = system('ruby temp_script.rb')
    unless result
      raise "Échec lors de l'exécution du script"
    end
  rescue StandardError => e
    puts "Erreur : #{e.message}"
    if attempts < max_retries
      puts "Nouvelle tentative (#{attempts}/#{max_retries})..."
      retry
    else
      puts "Échec après #{max_retries} tentatives."
      exit(1) # Quitter si toutes les tentatives échouent
    end
  end

  # Appeler les méthodes `code` et `infos`
  system("ruby -r./temp_script -e 'code'")
  system("ruby -r./temp_script -e 'puts infos'")
end



def get_OpenAI_models(api_key) #if we need to obtain all OpenAI models
  uri = URI("https://api.openai.com/v1/models")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  headers = {
    "Authorization" => "Bearer #{api_key}"
  }

  request = Net::HTTP::Get.new(uri, headers)
  response = http.request(request)

  parsed_response = JSON.parse(response.body)

  if response.code.to_i == 200
    parsed_response["data"].map { |model| model["id"] }
  else
    puts "Erreur : #{parsed_response["error"]["message"]}" if parsed_response["error"]
    []
  end
end

# puts get_OpenAI_models(api_key)
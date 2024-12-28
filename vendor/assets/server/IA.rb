
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
Tu es un assistant expert en Ruby.
Toutes tes réponses doivent contenir exclusivement du code Ruby pur, sans aucune balise Markdown, sans aucun commentaire, sans aucun texte explicatif.
Le code doit être correctement indenté (utilise par exemple deux espaces par niveau d’indentation) et présenter une structure claire.
Aucune ligne vide superflue n’est admise.
Aucune phrase explicative, aucun commentaire, aucun texte extérieur ne doit apparaître dans la réponse.
Le code doit :
	•	Être placé dans une méthode nommée code.
	•	Contenir, à la fin, une méthode infos qui retourne une description concise du fonctionnement du code.
	•	Contenir obligatoirement une méthode results qui retourne une string :
	•	Si la tâche attend une réponse, la réponse sera formatée et retournée dans cette méthode sous forme de chaîne.
	•	Si la tâche est une action (par exemple, création ou modification), la méthode results devra fournir des détails sur le bon déroulement des opérations effectuées.
	•	Si la méthode code n’a pas été exécutée avant, la méthode results devra exécuter automatiquement les opérations nécessaires pour produire un résultat approprié, basé sur les informations du prompt ou une logique par défaut.
	•	Chaque méthode (code, results, infos) doit pouvoir être exécutée de manière indépendante, dans n’importe quel ordre, et retourner des résultats pertinents basés sur l’état actuel du programme ou l’objectif du prompt.
	•	Effectuer une recherche récursive insensible à la casse dans le répertoire courant et ses sous-dossiers pour trouver des fichiers correspondant au nom recherché, si applicable.
	•	Si l’extension n’est pas spécifiée, tous les fichiers avec le nom recherché seront pris en compte, quelle que soit leur extension.
	•	Ajouter un avertissement dans la méthode infos précisant que si aucune extension n’est indiquée, tous les fichiers correspondants au nom seront traités, indépendamment de leur extension.
	•	Gérer les cas où plusieurs fichiers sont trouvés en vérifiant que leur chemin existe et qu’il est valide avant d’essayer de les ouvrir.
	•	Traiter correctement les extensions des fichiers. Si une comparaison insensible à la casse est effectuée, elle doit ignorer l’extension pour trouver les fichiers correspondant au nom spécifié.
	•	Assurer la compatibilité multiplateforme pour ouvrir les fichiers, en utilisant les commandes appropriées pour Windows, macOS et Linux. Une détection fiable du système d’exploitation doit être incluse.
	•	En cas de permissions restreintes ou d’erreurs pendant la recherche ou l’ouverture des fichiers, capturer les exceptions et fournir des messages d’erreur clairs et détaillés dans results.
	•	Utiliser des chemins absolus pour éviter les erreurs liées aux chemins relatifs lors de l’ouverture des fichiers.
	•	Si aucun fichier n’est trouvé ou si des erreurs surviennent, le message dans results doit être clair et précis, incluant les erreurs spécifiques rencontrées.
	•	Retourner les résultats ou les informations exclusivement via la méthode results.
	•	Être inventif, logique.
	•	Important : le code doit impérativement être strictement indenté et bien formaté avec des \n pour correctement retourner à la ligne.
	•	: le code doit impérativement être testé et vérifié méticuleusement pour être exempt de tout bug.
	•	Le code doit être fourni en format text exclusivement sans ajout de balise code.
Pour chaque nouveau prompt, crée ou recherche un fichier log (dans un dossier logs) nommé selon le sujet du prompt et la date (format YYYYMMDD). Si le sujet existe et que la date reste la même, ajoute et résume l’ancien contenu pour éviter un fichier trop volumineux, sinon crée un nouveau fichier. L’API doit être capable de cibler un sujet soit par la date, soit par le nom du sujet. Si le prompt concerne un nouveau sujet, ouvre un nouveau fichier, sinon réutilise celui déjà existant. Si le sujet est trop éloigné dans le temps mais inchangé, conserve le même nom ou crée un nouveau fichier avec la date courante pour qu’on puisse s’y retrouver.
Tu ne dois fournir que le code Ruby final, rien de plus. Toute information ou instruction non-codée ne doit pas apparaître dans la réponse.
Voici la tâche : #{prompt}
PROMPT
    body = {
      model: "gpt-4o-2024-11-20",
       # model: "g-TIdYSkrQp-atome-for-end-developers",
      messages: [
        { role: "system", "content" => "Tu es un expert Ruby" },
        { role: "user", content: full_prompt }]
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
    Thread.new do
      begin
        system("ruby -r./temp_script -e 'code'")
        puts 'Infos:'
        system("ruby -r./temp_script -e 'puts infos'")
        puts 'results:'
        system("ruby -r./temp_script -e 'puts results'")
      rescue => e
        puts "Erreur dans le thread : #{e.message}"
      end
    end

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


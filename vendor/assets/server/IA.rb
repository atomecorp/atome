require 'open3'
require 'timeout'

  $debug=true

  def custom_response(prompt, api_key)
    uri = URI("https://api.openai.com/v1/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{api_key}"
    }

    #  prompt below is for native compatibilty
    full_prompt = <<~PROMPT
Tu es un assistant expert en Ruby. Toutes tes réponses doivent contenir exclusivement du code Ruby pur, sans aucune balise Markdown, sans aucun commentaire, sans aucun texte explicatif.

Spécifications générales :
	1.	Indentation stricte : Deux espaces par niveau d’indentation.
	2.	Structure claire : Aucune ligne vide superflue.
	3.	Code testé et fonctionnel : Toutes les méthodes et instructions doivent être vérifiées pour garantir leur validité et leur exécution correcte avec Atome.

Comportement attendu du code :
	•	Création ou recherche de dossiers et fichiers :
	•	Vérifie l’existence ou crée un dossier nommé logs dans le répertoire courant.
	•	Vérifie l’existence ou crée un dossier nommé temp dans le répertoire courant.
	•	Dans le dossier logs, crée un fichier horodaté (format : operation_YYYYMMDD.log).
	•	Ce fichier doit résumer l’opération demandée ou enregistrer les logs des actions effectuées.
	•	Architecture du code :
	1.	Méthode code : Contient la logique principale, crée les objets, exécute les opérations demandées.
	2.	Méthode results : Retourne les résultats sous forme de chaîne :
	•	Résultat de l’opération demandée (si applicable).
	•	Confirmation claire des actions effectuées.
	•	Si code n’a pas été exécutée, appelle automatiquement code pour produire un résultat.
	3.	Méthode infos : Fournit une description concise des fonctionnalités du code, incluant :
	•	Un avertissement spécifique à Atome : “Si aucune extension n’est spécifiée lors de la recherche de fichiers, tous les fichiers correspondant au nom seront pris en compte, quelle que soit leur extension.”
	•	Une explication de l’architecture logique du programme.
	•	Indépendance : Chaque méthode (code, results, infos) doit pouvoir être appelée de manière indépendante et retourner des résultats pertinents.

Gestion des fichiers :
	•	Recherche récursive insensible à la casse dans le répertoire courant et ses sous-dossiers.
	•	Prise en compte de tous les fichiers si aucune extension n’est précisée.
	•	Utilisation de chemins absolus pour éviter les erreurs.

Logs :
	•	Les fichiers doivent contenir un résumé clair des opérations (nouveau fichier ou concaténation avec l’existant).

Voici la tâche : #{prompt}
PROMPT


    # # prompt  below is for atome compatibilty
#     full_prompt = <<~PROMPT
# Tu es un assistant expert en Ruby et spécialiste du framework atome. Toutes tes réponses doivent contenir exclusivement du code Ruby pur, sans aucune balise Markdown, sans aucun commentaire, sans aucun texte explicatif.
#
# Spécifications générales :
# 	1.	Indentation stricte : Deux espaces par niveau d’indentation.
# 	2.	Structure claire : Aucune ligne vide superflue.
# 	3.	Code testé et fonctionnel : Toutes les méthodes et instructions doivent être vérifiées pour garantir leur validité et leur exécution correcte avec Atome.
#
# Comportement attendu du code :
# 	•	Création ou recherche de dossiers et fichiers :
# 	•	Vérifie l’existence ou crée un dossier nommé logs dans le répertoire courant.
# 	•	Vérifie l’existence ou crée un dossier nommé temp dans le répertoire courant.
# 	•	Dans le dossier logs, crée un fichier horodaté (format : operation_YYYYMMDD.log).
# 	•	Ce fichier doit résumer l’opération demandée ou enregistrer les logs des actions effectuées.
# 	•	Architecture du code :
# 	1.	Méthode code : Contient la logique principale, crée les objets, exécute les opérations demandées.
# 	2.	Méthode results : Retourne les résultats sous forme de chaîne :
# 	•	Résultat de l’opération demandée (si applicable).
# 	•	Confirmation claire des actions effectuées.
# 	•	Si code n’a pas été exécutée, appelle automatiquement code pour produire un résultat.
# 	3.	Méthode infos : Fournit une description concise des fonctionnalités du code, incluant :
# 	•	Un avertissement spécifique à Atome : “Si aucune extension n’est spécifiée lors de la recherche de fichiers, tous les fichiers correspondant au nom seront pris en compte, quelle que soit leur extension.”
# 	•	Une explication de l’architecture logique du programme.
# 	•	Indépendance : Chaque méthode (code, results, infos) doit pouvoir être appelée de manière indépendante et retourner des résultats pertinents.
#
# Règles spécifiques pour Atome :
# 	1.	Création d’objets :
# 	•	Utilise box, text, circle, image, video, etc., pour créer des objets interactifs.
# 	•	Exemple : box(id: :my_box, width: 300, height: 300, color: :blue).
# 	2.	Positionnement dynamique :
# 	•	Configure les propriétés comme left, top, width, height, etc., pour structurer les objets.
# 	•	Exemple : Centrer dynamiquement un objet : grab(:my_box).left = (scene.width / 2) - (grab(:my_box).width / 2).
# 	3.	Manipulation des propriétés :
# 	•	Atome permet l’utilisation de getters et setters dynamiques pour configurer des propriétés :
# 	•	Apparence : color, opacity, shadow.
# 	•	Interactions : touch, drag.
# 	•	Animations : Utilise animate pour modifier des propriétés de manière fluide.
# 	4.	Hiérarchie d’objets :
# 	•	Ajoute des objets avec add.
# 	•	Supprime avec delete(true) pour libérer les ressources.
#
# Gestion des fichiers :
# 	•	Recherche récursive insensible à la casse dans le répertoire courant et ses sous-dossiers.
# 	•	Prise en compte de tous les fichiers si aucune extension n’est précisée.
# 	•	Utilisation de chemins absolus pour éviter les erreurs.
#
# Logs :
# 	•	Les fichiers doivent contenir un résumé clair des opérations (nouveau fichier ou concaténation avec l’existant).
#
# Voici la tâche : #{prompt}
# PROMPT




# # prompt  below is for atome backup
#     full_prompt = <<~PROMPT
# Tu es un assistant expert en Ruby et spécialiste du framework Atome.
# Toutes tes réponses doivent contenir exclusivement du code Ruby pur, sans aucune balise Markdown, sans aucun commentaire, sans aucun texte explicatif.
# Le code doit être correctement indenté (utilise par exemple deux espaces par niveau d’indentation) et présenter une structure claire. Aucune ligne vide superflue n’est admise. Aucune phrase explicative, aucun commentaire, aucun texte extérieur ne doit apparaître dans la réponse.
#
# Le code doit :
# Pour chaque nouveau prompt, crée ou recherche un fichier log dans un dossier nommé logs.
# ce log doit etre créé avant tout autre operations
# Être placé dans une méthode nommée code.
# Contenir, à la fin, une méthode infos qui retourne une description concise du fonctionnement du code. Cette méthode doit inclure un avertissement pour le framework Atome : Si aucune extension n’est indiquée lors de la recherche de fichiers, tous les fichiers correspondants au nom seront pris en compte, quelle que soit leur extension.
# Contenir une méthode results qui retourne une string :
# Si la tâche attend une réponse, la méthode results retourne cette réponse formatée sous forme de chaîne.
# Si la tâche est une action (par exemple, création ou modification), la méthode results détaille le bon déroulement des opérations effectuées.
# Si la méthode code n’a pas été exécutée, la méthode results doit exécuter automatiquement les opérations nécessaires pour produire un résultat approprié, basé sur les informations du prompt ou une logique par défaut.
# Chaque méthode (code, results, infos) doit pouvoir être exécutée de manière indépendante, dans n’importe quel ordre, et retourner des résultats pertinents basés sur l’état actuel du programme ou l’objectif du prompt.
# Règles spécifiques pour le framework Atome :
#
# Création d’objets : Utilise les méthodes telles que box, text, circle, image, video, paint, group, et autres, pour créer des objets interactifs et visuels.
# Exemple : box(id: :my_box, width: 300, height: 300, color: :blue)
# Pour positionner un objet dans un autre (exemple d’un cercle dans un carré) : utilise les propriétés left et top et ajuste-les dynamiquement pour centrer l’objet.
# Manipulation des propriétés : Atome permet de configurer et récupérer les propriétés de manière fluide grâce à des getters et setters dynamiques :
# Position : left, top, width, height, smooth (pour arrondir les coins).
# Apparence : color, opacity, shadow, border, background.
# Interactions et animations : Atome prend en charge des événements comme touch, drag, animate.
# Exemple : Ajouter une interaction tactile (touch) pour changer la couleur au clic.
# Exemple : Créer une animation (animate) pour déplacer un objet ou changer son style.
# Récupération d’objets existants : Utilise la méthode grab(:id) pour récupérer et manipuler des objets déjà créés.
# Gestion hiérarchique : Les objets peuvent être structurés en relations parent-enfant :
# Pour ajouter un enfant : utilise add.
# Pour supprimer un objet : utilise delete(true) pour le retirer entièrement de la scène et de la mémoire.
# Suppression et nettoyage : Tout objet non utilisé doit être correctement supprimé via delete(true).
# Recherche et gestion des fichiers :
#
# Effectuer une recherche récursive insensible à la casse dans le répertoire courant et ses sous-dossiers pour trouver des fichiers correspondant au nom recherché.
# Si l’extension n’est pas spécifiée, tous les fichiers correspondant au nom recherché seront pris en compte, quelle que soit leur extension.
# Vérifie que les chemins des fichiers trouvés existent et sont valides avant d’essayer de les ouvrir.
# En cas de permissions restreintes ou d’erreurs pendant la recherche ou l’ouverture des fichiers, capture les exceptions et retourne des messages d’erreur détaillés via la méthode results.
# Utilise des chemins absolus pour éviter les erreurs liées aux chemins relatifs lors de l’ouverture des fichiers.
# Log des opérations :
#
# Le fichier log doit être nommé selon le sujet du prompt et la date (format YYYYMMDD).
# Si le sujet existe et que la date reste la même, ajoute et résume l’ancien contenu pour éviter un fichier trop volumineux.
# Si le sujet est trop éloigné dans le temps mais reste inchangé, conserve le même nom ou crée un nouveau fichier avec la date courante pour faciliter la recherche.
# Important : Le code doit impérativement être strictement indenté et bien formaté avec des \n pour correctement retourner à la ligne.
# Le code doit impérativement être testé et vérifié méticuleusement pour être exempt de tout bug.
# Le code doit être fourni en format text exclusivement, sans ajout de balise
# Pour chaque nouveau prompt, crée ou recherche un fichier log (dans un dossier logs) nommé selon le sujet du prompt et la date (format YYYYMMDD). Si le sujet existe et que la date reste la même, ajoute et résume l’ancien contenu pour éviter un fichier trop volumineux, sinon crée un nouveau fichier. L’API doit être capable de cibler un sujet soit par la date, soit par le nom du sujet. Si le prompt concerne un nouveau sujet, ouvre un nouveau fichier, sinon réutilise celui déjà existant. Si le sujet est trop éloigné dans le temps mais inchangé, conserve le même nom ou crée un nouveau fichier avec la date courante pour qu’on puisse s’y retrouver.
# Tu ne dois fournir que le code Ruby final, rien de plus. Toute information ou instruction non-codée ne doit pas apparaître dans la réponse.
# Voici la tâche : #{prompt}
#     PROMPT


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



  def execute_script_safely(file_path)
    timeout_duration = 5 # Timeout en secondes
    result = nil
    errors = nil

    begin
      Timeout.timeout(timeout_duration) do
        stdout, stderr, status = Open3.capture3("ruby #{file_path}")
        result = stdout
        errors = stderr unless status.success?
      end
    rescue Timeout::Error
      errors = "Execution timed out after #{timeout_duration} seconds."
    rescue StandardError => e
      errors = "Unexpected error: #{e.message}"
    end

    if errors
      puts "Script errors:\n#{errors}"
      return { success: false, errors: errors }
    else
      puts "Script executed successfully:\n#{result}"
      return { success: true, output: result }
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


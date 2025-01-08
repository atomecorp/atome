require 'ferrum'


path=Dir.pwd

# browser.screenshot(path: path+"/test/automatise/logs/screenshot.png")


examples = [path+"/vendor/assets/application/examples/above_below_before_after.rb",
            path+"/vendor/assets/application/examples/account.rb"] # Liste des exemples à tester

examples.each do |example|
  puts "Test de l'exemple : #{example}"

  # Charger et exécuter le script via Opal (ou Ruby-Wasm si nécessaire)
  compiled_js = `opal -c #{example}`

  # Créer une nouvelle instance de navigateur
  browser = Ferrum::Browser.new

  # Charger une page vide et injecter le script compilé
  browser.goto("data:text/html,<html><body></body></html>")
  browser.evaluate(compiled_js)

  # Capturer les erreurs JS
  errors = []
  browser.on(:console) do |message|
    if message[:type] == 'error'
      errors << message[:text]
    end
  end

  # Attendre un peu pour permettre l'exécution
  sleep 2

  # Générer un log d'erreurs si nécessaire
  if errors.any?
    File.open("logs/#{example}.log", "w") do |file|
      file.puts(errors.join("\n"))
    end
    puts "Erreurs capturées pour #{example}. Voir le log."
  else
    puts "Aucune erreur détectée pour #{example}."
  end

  browser.quit
end

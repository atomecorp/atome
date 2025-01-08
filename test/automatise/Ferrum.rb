require 'ferrum'

# Créer une instance de navigateur Ferrum
browser = Ferrum::Browser.new

# Naviguer vers une URL
browser.goto("http://localhost:9292")

# Capturer un message de la console JS
browser.on(:console) do |message|
  puts "LOG JS : #{message[:text]}"
end

# Prendre une capture d’écran de la page
path=Dir.pwd

browser.screenshot(path: path+"/test/automatise/logs/screenshot.png")

# Fermer le navigateur
browser.quit

# frozen_string_literal: true

if online?
  puts "Vous êtes en ligne."
else
  puts "Vous êtes hors ligne."
end

def add_online_listener
  JS.eval(%{
    window.addEventListener('online', function() {
      console.log("Passé en ligne.");
    });
  })
end

def add_offline_listener
  JS.eval(%{
    window.addEventListener('offline', function() {
      console.log("Passé hors ligne.");
    });
  })
end
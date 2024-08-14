# # Définir la fonction JavaScript pour charger et exécuter le module
# Suppose this is part of your Ruby WASM script

b=box({id: :container, width: 333, height: 333})
js_code = <<~JAVASCRIPT
  initWithParam("https://aframe.io/aframe/examples/boilerplate/panorama/puydesancy.jpg", 'container', 'method', 'params');
JAVASCRIPT
wait 3 do
  JS.eval(js_code)
end

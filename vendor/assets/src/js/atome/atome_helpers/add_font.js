// Fonction pour ajouter la police dynamiquement
function ajouterPoliceDynamiquement(font_name,type,path) {
    // Créer une nouvelle balise <style>
    const styleElement = document.getElementById('atomic_style');

    // Ajouter la règle @font-face à la balise <style>
    styleElement.textContent = `
    @font-face {
      font-family: ${font_name};
      src: url('${path}') format('truetype');
    }
  `;

    // Ajouter la balise <style> à la balise <head> du document
    document.head.appendChild(styleElement);

    // Appliquer la police au corps du document
    // document.body.style.fontFamily = font_name+','+type;
}

// Appeler la fonction pour ajouter et appliquer la police
ajouterPoliceDynamiquement('Ruboto','ThinItalic','medias/fonts/Roboto/Roboto-ThinItalic.ttf');

/////////////////

// setTimeout(function () {
//     const viewDiv = document.getElementById('view');
//
//     // Vérifier si la div existe
//     if (viewDiv) {
//         // Ajouter le texte à la div
//         viewDiv.innerText = "Ceci est un texte ajouté à la div 'view'.";
//
//         // Appliquer la police et la taille du texte
//         viewDiv.style.fontFamily = 'Ruboto, thin';
//         viewDiv.style.fontSize = '36px';
//     } else {
//         console.error("La div avec l'ID 'view' n'a pas été trouvée.");
//     }
// }, 3000);







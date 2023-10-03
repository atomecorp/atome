
`function addElement (width) {
  // crée un nouvel élément div
  var newDiv = document.createElement("div");
  // et lui donne un peu de contenu
  var newContent = document.createTextNode('Hi there and greetings!');
  // ajoute le nœud texte au nouveau div créé
  newDiv.appendChild(newContent);
  newDiv.id='div1';

  // ajoute le nouvel élément créé et son contenu dans le DOM
  var currentDiv = document.getElementById('div1');
  document.body.insertBefore(newDiv, currentDiv);
}

addElement();


 var selectedRow = document.querySelector('div#div1');
 selectedRow.style.color = 'black';
  selectedRow.style.backgroundColor = 'orange';`
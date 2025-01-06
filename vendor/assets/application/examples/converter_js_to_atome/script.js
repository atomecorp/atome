// Ajouter dynamiquement un élément à la page
document.addEventListener('DOMContentLoaded', () => {
    const newBox = document.createElement('div');
    newBox.id = 'dynamic-box';
    newBox.textContent = 'I am dynamic!';
    document.body.appendChild(newBox);

    // Ajouter un événement au nouveau box
    newBox.addEventListener('click', () => {
        newBox.style.backgroundColor = 'orange';
    });
});

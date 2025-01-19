document.addEventListener('DOMContentLoaded', () => {
    // Créer un canvas et l'ajouter au document
    const canvas = document.createElement('canvas');
    document.body.appendChild(canvas);
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    const ctx = canvas.getContext('2d');

    // Appliquer des styles pour empêcher la sélection
    canvas.style.userSelect = 'none';
    canvas.style.webkitUserSelect = 'none';
    canvas.style.msUserSelect = 'none';
    canvas.style.mozUserSelect = 'none';

    // Paramètres du cercle
    const circle = {
        x: canvas.width / 2,
        y: canvas.height / 2,
        radius: 50,
        tolerance: 10, // Marge de tolérance pour les clics proches de la périphérie
        color: '#2F4F4F' // Gris bleu foncé par défaut
    };

    // Fonction pour dessiner le cercle
    function drawCircle() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.beginPath();
        ctx.arc(circle.x, circle.y, circle.radius, 0, Math.PI * 2);
        ctx.fillStyle = circle.color;
        ctx.fill();
    }

    // Configuration Web Audio
    const audioContext = new (window.AudioContext || window.webkitAudioContext)();
    let oscillator;

    // Fonction pour démarrer le son
    function startSound() {
        oscillator = audioContext.createOscillator();
        oscillator.type = 'sawtooth';
        oscillator.frequency.setValueAtTime(440, audioContext.currentTime); // Fréquence en Hz (440Hz = La4)
        oscillator.connect(audioContext.destination);
        oscillator.start();
    }

    // Fonction pour arrêter le son
    function stopSound() {
        if (oscillator) {
            oscillator.stop();
            oscillator.disconnect();
            oscillator = null;
        }
    }

    // Fonction de gestion du clic/tap
    function handlePress(x, y) {
        // Calculer la distance entre le clic/tap et le centre du cercle
        const distX = x - circle.x;
        const distY = y - circle.y;
        const distance = Math.sqrt(distX * distX + distY * distY);

        // Vérifier si le clic/tap est dans le cercle ou légèrement autour
        if (distance <= circle.radius + circle.tolerance) {
            startSound();
            circle.color = 'lightblue'; // Changer la couleur en bleu clair lors du clic/tap
            drawCircle();
        }
    }

    // Gestionnaire d'événements pour détecter la fin du clic/tap
    function handleRelease() {
        stopSound();
        circle.color = '#2F4F4F'; // Restaurer la couleur gris bleu foncé
        drawCircle();
    }

    // Événements de souris
    canvas.addEventListener('mousedown', (event) => {
        event.preventDefault(); // Empêcher la sélection par clic
        const rect = canvas.getBoundingClientRect();
        const clickX = event.clientX - rect.left;
        const clickY = event.clientY - rect.top;
        handlePress(clickX, clickY);
    });
    canvas.addEventListener('mouseup', (event) => {
        event.preventDefault();
        handleRelease();
    });

    // Événements tactiles
    canvas.addEventListener('touchstart', (event) => {
        event.preventDefault(); // Empêcher la sélection par toucher
        const rect = canvas.getBoundingClientRect();
        const touchX = event.touches[0].clientX - rect.left;
        const touchY = event.touches[0].clientY - rect.top;
        handlePress(touchX, touchY);
    });
    canvas.addEventListener('touchend', (event) => {
        event.preventDefault();
        handleRelease();
    });

    // Dessiner le cercle
    drawCircle();
});

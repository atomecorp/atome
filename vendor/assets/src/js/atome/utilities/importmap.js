const script = document.createElement('script');
script.type = 'importmap';
script.textContent = JSON.stringify({
    "imports": {
        "three": "./js/third_parties/Three/build/three.module.min.js",
        "three/addons/": "./js/third_parties/Three/jsm/"
    }
});
document.head.appendChild(script);
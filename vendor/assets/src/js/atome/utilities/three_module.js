import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

let camera, scene, renderer, controls;
let hotspot;

function initWithParam(path, target, method, params) {
    init(path, target, method, params);
    animate();
}

window.initWithParam = initWithParam;

function init(path, target, method, params) {
    const container = document.getElementById(target);

    const width = container.clientWidth;
    const height = container.clientHeight;

    camera = new THREE.PerspectiveCamera(75, width / height, 1, 1100);
    camera.position.z = 0.01;

    scene = new THREE.Scene();

    const geometry = new THREE.SphereGeometry(500, 60, 40);
    geometry.scale(-1, 1, 1);

    const textureLoader = new THREE.TextureLoader();
    const texture = textureLoader.load(path);
    texture.colorSpace = THREE.SRGBColorSpace;
    const material = new THREE.MeshBasicMaterial({ map: texture });

    const mesh = new THREE.Mesh(geometry, material);
    scene.add(mesh);

    // Hotspot
    const hotspotGeometry = new THREE.SphereGeometry(2, 32, 16);
    const hotspotMaterial = new THREE.MeshBasicMaterial({ color: 0xff0000 });
    hotspot = new THREE.Mesh(hotspotGeometry, hotspotMaterial);
    hotspot.position.set(5, 0, -50);
    scene.add(hotspot);

    // Event listener for the hotspot
    const raycaster = new THREE.Raycaster();
    const mouse = new THREE.Vector2();

    window.addEventListener('click', (event) => {
        event.preventDefault();

        const rect = container.getBoundingClientRect();
        mouse.x = ((event.clientX - rect.left) / rect.width) * 2 - 1;
        mouse.y = -((event.clientY - rect.top) / rect.height) * 2 + 1;

        raycaster.setFromCamera(mouse, camera);

        const intersects = raycaster.intersectObjects([hotspot]);

        if (intersects.length > 0) {
            alert(`Hotspot clicked! Three.js version: ${THREE.REVISION}, ${method}, ${params}`);
        }
    }, false);

    renderer = new THREE.WebGLRenderer();
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.setSize(width, height);
    renderer.setAnimationLoop(animate);
    container.appendChild(renderer.domElement);

    controls = new OrbitControls(camera, renderer.domElement);
    controls.enableZoom = false;

    window.addEventListener('resize', onWindowResize(container));
}

function onWindowResize(container) {
    const width = container.clientWidth;
    const height = container.clientHeight;

    camera.aspect = width / height;
    camera.updateProjectionMatrix();
    renderer.setSize(width, height);
}

function animate() {
    controls.update();
    renderer.render(scene, camera);
}
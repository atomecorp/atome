class Third_d_Helper{
    constructor() {
        this.dummy_var="Cool!";
        $.getScript("js/third_parties/rendering_engines/three.min.js", function () {});
        $.getScript("js/third_parties/rendering_engines/three.interaction.min.js", function () {});
        this.view_width = $("#view").css("width");
        this.view_height = $("#view").css("height");
        //////
        $("#view").append("<canvas id='topino' width=" + this.view_width + " height= " + this.view_height + "></canvas>");
        $("#topino").css("left", "0px");
        $("#topino").css("top", "0px");
        $("#topino").css("position", "absolute");
    //     this.audioEventListener = audioEventListener;
    }
    basic3D(atome_id, options, proc) {
    alert (this.dummy_var);
        // create a synth and connect it to the main output (your speakers)

    }

}
function third_d_test(atome_id) {
    var url = "js/third_parties/rendering_engines/three.min.js";
    $.getScript(url, function () {
        var url_2 = "js/third_parties/rendering_engines/three.interaction.min.js";
        $.getScript(url_2, function () {
            var view_width = $("#view").css("width");
            var view_height = $("#view").css("height");
            //////
            $("#view").append("<canvas id='topino' width=" + view_width + " height= " + view_height + "></canvas>");
            $("#topino").css("left", "0px");
            $("#topino").css("top", "0px");
            $("#topino").css("position", "absolute");
            var offset = 4;
            var WIDTH = parseInt(view_width) - offset;
            var HEIGHT = parseInt(view_height) - offset;
            var camera2 = new THREE.PerspectiveCamera(60, WIDTH / HEIGHT, 0.01, 100);
            var renderer2 = new THREE.WebGLRenderer({
                canvas: document.querySelector('#topino'),
                antialias: true,
                alpha: true,
            });
            renderer2.setSize(WIDTH, HEIGHT);
            var scene2 = new THREE.Scene();
            var cube2 = new THREE.Mesh(
                new THREE.BoxGeometry(3, 2, 3),
                new THREE.MeshPhongMaterial({color: "blue", opacity: 0.5, transparent: true})
            );
            cube2.cursor = 'pointer';
            cube2.position.y = 1;
            cube2.position.z = -10;
            cube2.name = 'cube';
            scene2.add(cube2);

            var light2 = new THREE.PointLight(0xffffff);
            light2.position.set(20, 50, 10);
            scene2.add(light2);
            renderer2.render(scene2, camera2);
            ////

            $("#view").append("<canvas id=" + atome_id + " width=" + view_width + " height= " + view_height + "></canvas>");
            $("#" + atome_id).css("left", "0px");
            $("#" + atome_id).css("top", "0px");
            $("#" + atome_id).css("position", "absolute");
            var camera = new THREE.PerspectiveCamera(60, WIDTH / HEIGHT, 0.01, 100);
            var renderer = new THREE.WebGLRenderer({
                canvas: document.querySelector('#' + atome_id),
                antialias: true,
                alpha: true,
            });
            renderer.setSize(WIDTH, HEIGHT);
            var scene = new THREE.Scene();
            var cube = new THREE.Mesh(
                new THREE.BoxGeometry(3, 2, 3),
                new THREE.MeshPhongMaterial({color: "red", opacity: 0.5, transparent: true})
            );
            cube.cursor = 'pointer';
            cube.position.y = -2;
            cube.position.z = -10;
            cube.name = 'cube';
            scene.add(cube);

            var light = new THREE.PointLight(0xffffff);
            light.position.set(20, 50, 10);
            scene.add(light);
            renderer.render(scene, camera);
            var i = 0;

            function animate() {
                cube.rotation.y += 0.003;
                color = "rgb(" + i + ", 123, 0)";
                cube.material.color.set(color);
                if (i > 255) {
                    i = 0;
                }
                i++;
                renderer.render(scene, camera);
                requestAnimationFrame(animate);
            }

            //////// intercation here ////
            new THREE.Interaction(renderer, scene, camera);

            var clicked = false;
            cube.on('pointerdown', function (ev) {
                animate();
                clicked = true;
            });
            cube.on('pointerup', function (ev) {
                animate();
                clicked = false;
            });

            cube.on('mousemove', function (ev) {
                if (clicked) {
                    // console.log(ev.data.originalEvent.offsetX);
                    // ev.data.global.y;
                    cube.position.set(ev.data.global.x, ev.data.global.y, -10);
                }


            });

            function onWindowResize() {
                camera.aspect = window.innerWidth / window.innerHeight;
                camera.updateProjectionMatrix();
                renderer.setSize(window.innerWidth, window.innerHeight);
            }

        });


    });


//////////////// interactions here


}
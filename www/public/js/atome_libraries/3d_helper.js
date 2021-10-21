class Third_d_Helper {
    constructor() {
        // $.getScript("js/third_parties/rendering_engines/three.interaction.min.js", function () {
        // });

// below the table that match threejs id and atome_id
//    this.ids={"cool": "super", "great": "genious"};
    }

    universe(atome_id, options, proc) {
        // we create the canvas if doesn't already exist
        if ($("#three_d_space") == "") {
            this.view_width = $("#view").css("width");
            this.view_height = $("#view").css("height");
            $("#view").append("<canvas id='three_d_space' width=" + this.view_width + " height= " + this.view_height + "></canvas>");
            $("#three_d_space").css("left", "0px");
            $("#three_d_space").css("top", "0px");
            $("#three_d_space").css("position", "absolute");
        }
        let width = parseInt(this.view_width);
        let height = parseInt(this.view_height);
        this.camera = new THREE.PerspectiveCamera(60, width / height, 1, 1000);
        this.renderer = new THREE.WebGLRenderer({
            canvas: document.querySelector('#three_d_space'),
            antialias: true,
            alpha: true,
        });
        this.renderer.setSize(parseInt(width), height);
        this.scene = new THREE.Scene();

        new THREE.Interaction(this.renderer, this.scene, this.camera);

        window.addEventListener('resize', () => {
            this.renderer.setSize(window.innerWidth, window.innerHeight);
            this.camera.aspect = window.innerWidth / window.innerHeight;
            this.camera.updateProjectionMatrix();
            this.renderer.render(this.scene, this.camera);
        });

    }

    render() {
        this.renderer.render(this.scene, this.camera);
    }

    addCube(params) {
        // alert(params);
        var cube = new THREE.Mesh(
            new THREE.BoxGeometry(3, 2, 3),
            new THREE.MeshPhongMaterial({color: "red", opacity: 0.5, transparent: true})
        );
        cube.position.y = -2;
        cube.position.z = -10;
        cube.name = params;
        this.scene.add(cube);
        this.renderer.render(this.scene, this.camera);
    }

    addLight(params) {
        this.light = new THREE.PointLight(0xffffff);
        this.light.position.set(20, 50, 10);
        this.scene.add(this.light);

        this.renderer.render(this.scene, this.camera);
    }

    move(obj_id, params) {
        let obj = this.scene.getObjectByName(obj_id);
        let color = "rgb( 0 , 255, 0)";
        obj.material.color.set(color);
        this.renderer.render(this.scene, this.camera);
    }



    touch(obj_id, params) {
        this.clicked = false;
        let obj = this.scene.getObjectByName(obj_id);
        obj.cursor = 'pointer';
        obj.on('pointerdown', function (ev) {
            // animate();
            this.clicked = true;
            let color = "rgb( 0 , 255, 0)";
            obj.material.color.set(color);
            third_d.render();
        });
        obj.on('pointerup', function (ev) {
            // animate();
            this.clicked = false;
        });
    }

    drag(obj_id, params) {
        // new THREE.Interaction(this.renderer, this.scene, this.camera);
        let obj = this.scene.getObjectByName(obj_id);
        obj.on('mousemove', function (ev) {
            if (this.clicked) {
                // console.log(ev.data.originalEvent.offsetX);
                // ev.data.global.y;
                obj.position.set(ev.data.global.x, ev.data.global.y, -10);
                third_d.render();
            }
        });
    }

    anim(obj_id, params){
        ////// animation here ////
        var i = 0;
        let obj = this.scene.getObjectByName(obj_id);
        function animate() {
            obj.rotation.y += 0.003;
            var color = "rgb(" + i + ", 123, 0)";
            obj.material.color.set(color);
            if (i > 255) {
                i = 0;
            }
            i++;
            third_d.render();
            requestAnimationFrame(animate);
        }
        animate();
    }

}



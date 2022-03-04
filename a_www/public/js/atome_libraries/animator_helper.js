class AnimationHelper {
    constructor() {
        $.getScript("js/third_parties/animation/popmotion.min.js", function () {
        });
    }
}

animator = {
    animation: function (value) {
        let start = value.start;
        // let target = Opal.Object.$grab(value.target);
        let target = document.querySelector("#" + value.target);
        // const target_1 = document.querySelector('#box2');
        // alert(value.target);
        const {easing, styler, animate, mixColor} = window.popmotion;


        animate({
            type: 'spring',
            from: 0,
            to: 400,
            duration: 1000,
            // mass: 1,
            // velocity: 20,
            // dampingRatio: 1,
            repeat: 7,
            onUpdate: (v) => {
                target.style.top = `${v}px`;
                target.style.left = `${v}px`;
                var col = mixColor("rgba(0, 255, 0, 1)", "rgba(0, 0, 255, 1)")(v / 400);
                // target.style.backgroundImage = col;
                // rgba(0, 30, 30, 1)
                $(target).css("background-image", `linear-gradient(0deg,${col},${col})`);
                console.log(col);
            },
            onComplete: latest => console.log("latest")
        });


    }

};


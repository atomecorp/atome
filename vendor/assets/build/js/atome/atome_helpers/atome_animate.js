const atomeAnimate = {

    animate: function(particle_found, duration,damping_ratio,ease, mass,  repeat,stiffness, velocity,
                      start_value, end_value, atome_id, atome_found) {
        // console.log(start_value)

        const {easing,  styler, animate} = window.popmotion;

        const target_div = document.querySelector('#'+atome_id);

        // var myHash = Opal.hash({postion: target_div.style.transform});

        // let particle_to_process=  myHash.$fetch('postion','');

        animate({
            type: ease,
            from: start_value,
            to: end_value,
            duration: duration,
            mass: mass,
            velocity: velocity,
            dampingRatio: damping_ratio,
            stiffness: stiffness,
            repeat: repeat,
            onPlay: latest => console.log("Starting"),
            onUpdate: (v) => {
                atome_found.$Browser_animate_callback(particle_found, v)
                // atome_found.$play_active_callback(particle_found, v);
                // target_div.style.transform = `translateX(${v}px) translateY(${v/4}px)`;
                // target_div.style.left = `${v}px`;
            },
            onComplete: latest => console.log("finished")
        });


        ///////////////////////////



        // const target_1 = document.querySelector('#box2');
        // animate({
        // 	  // from: 0,
        // 	  // to: 100,
        // 	  // from: "#fff",
        // 		// to: "#000",
        // 		// from: "0px 0px 0px rgba(0, 0, 0, 0)",
        // 		//   to: "10px 10px 0px rgba(0, 0, 0, 0.2)",
        // 		from: "rgba(0, 0, 0, 0)",
        // 		  to: "rgba(0, 0, 0, 0.2)",
        // 	  duration: 1000,
        // 	  onUpdate: latest => {
        // 		  console.log(latest)
        // 		  // target_1.style.transform = `translateX(${latest}px)`;
        // 		  target_1.style.background= latest
        // 	  },
        // 	  repeat: 6
        // 	})
        // let element = document.getElementById(atome_id)


    }


}

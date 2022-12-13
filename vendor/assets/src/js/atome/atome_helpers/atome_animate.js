const atomeAnimate = {

    animate: function(particle_found, duration,damping_ratio,ease, mass,  repeat,stiffness, velocity,
                      start_value, end_value, atome_id, atome_found,atome_hash,original_particle,animation_atome) {
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
            // mass: mass,
            // velocity: velocity,
            // dampingRatio: damping_ratio,
            // stiffness: stiffness,
            // repeat: repeat,
            onPlay: (value) => {
                animation_atome.$play_start_callback(particle_found, start_value,atome_hash,original_particle,atome_found)
            },
            onUpdate: (value) => {
                atome_found.$browser_animate_callback(particle_found, value,atome_hash,original_particle,animation_atome)
            },
            onComplete: (value) => {
                animation_atome.$play_stop_callback(particle_found, end_value,atome_hash,original_particle,atome_found)
            }
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

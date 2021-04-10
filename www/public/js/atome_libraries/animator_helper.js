

animator = {
    is_mobile: function () {
        atome.jsIsMobile();
    },
    animation: function (value) {
        let target=Opal.Object.$get(value.target);
        let target_id=target.atome_id;
        let objectType=target.type;
        let start = value.start;
        let end = value.end;
        let duration = value.duration;
        let curve = value.curve;
        let property = value.property;
        let finished = value.finished;
        let loop = value.loop;
        let yoyo = value.yoyo;
        let a_start = {};
        let a_end = {};
        let a_duration = {};
        let a_curve = {};
        let a_property = {};
        let a_finished = {};
        if (start === "") {
            start = 0;
        }
        if (end === "") {
            end = 200;
        }

        if (duration === "") {
            duration = 2000;
        }
        if (property === "") {
            property = "x";
        }

        if (curve === "") {
            curve = "Out";
        }

        if (finished === "") {
            finished = "";
        }
        if (loop === "") {
            loop = 0;
        }

        if (typeof (start) == "object") {
            const start_opt = Object.keys(value.start);

            start_opt.forEach((item) => {
                let key = item;
                const val = value.start[item];
                if (key === "background" && objectType === "text") {
                    key = "color";
                }
                a_start[key] = val;
            });
        } else {
            a_start[property] = start;
        }
        if (typeof (end) == "object") {
            const end_option = Object.keys(value.end);
            end_option.forEach((item) => {
                let key = item;
                const val = value.end[item];
                if (key === "background" && objectType === "text") {
                    key = "color";
                }
                a_end[key] = val;
            });
        } else {
            a_end[property] = end;
        }
        a_duration[property] = duration;
        a_curve[property] = curve;
        a_property[property] = property;
        a_finished[property] = finished;
//popmotion
        const {easing, tween, styler} = window.popmotion;
        const divStyler = styler(document.querySelector('#' + target_id));
        tween({
            from: a_start,
            to: a_end,
            duration: duration,
            ease: easing[curve],
            flip: loop,
            yoyo: yoyo
        })
            .start(divStyler.set);
    },

};
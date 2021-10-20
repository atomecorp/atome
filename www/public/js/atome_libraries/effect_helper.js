function generateNoise(target_id, intensity, opacity, width, height, color, remove) {

    var canvas = document.createElement("canvas"),
        ctx = canvas.getContext('2d'),
        x, y,
        opacities = opacity || 0.3;
    canvas.width = width || 450;
    canvas.height = height || 450;
    color = color || false;
    intensity = intensity || 60;
    for (x = 0; x < canvas.width; x++) {
        for (y = 0; y < canvas.height; y++) {
            if (color) {
                red = Math.floor(Math.random() * intensity);
                green = Math.floor(Math.random() * intensity);
                blue = Math.floor(Math.random() * intensity);
            } else {
                number = Math.floor(Math.random() * intensity);
                red = number;
                green = number;
                blue = number;
            }
            ctx.fillStyle = "rgba(" + red + "," + green + "," + blue + "," + opacities + ")";
            ctx.fillRect(x, y, 1, 1);
        }
    }
   let  target = $("#" + target_id);
    var new_background = "";
    if (remove) {
        target_atome=Opal.Atome.$grab(target_id);
        var bg = target.css("backgroundImage");
        if (target_atome.type =="image"){
            let image_name=target_atome.content;
            var bgs = bg.split(image_name);
            path=bgs[0].split("url(\"").pop();
            extension=bgs[1].split("\")")[0];
            let new_background = "url("+path+image_name+extension+ ")";
            target.css("background-repeat", "repeat");
            target.css("backgroundImage", new_background);
        }
        else {

            let bgs = bg.split('linear-gradient');
            let new_background = 'linear-gradient' + bgs.pop();
            target.css("background-repeat", "repeat");
            target.css("backgroundImage", new_background);
        }
    } else {
        new_background = "url(" + canvas.toDataURL("image/png") + ")" + "," + target.css("backgroundImage");
        target.css("background-repeat", "repeat");
        target.css("backgroundImage", new_background);

        // : url(masks.svg#mask1)
    }

}

function generateNoise(target, intensity, opacity, width, height, color) {
    var canvas = document.createElement("canvas"),
        ctx = canvas.getContext('2d'),
        x, y,
        opacity = opacity || 0.3;
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
            ctx.fillStyle = "rgba(" + red + "," + green + "," + blue + "," + opacity + ")";
            ctx.fillRect(x, y, 1, 1);
        }
    }
    target=$("#" + target);
    var new_background = "url(" + canvas.toDataURL("image/png") + ")" + "," + target.css("backgroundImage");
    target.css("backgroundImage", new_background);
 }

function generateNoise(target,intensity,opacity, width, height ,color) {
    // if ( !!!document.createElement('canvas').getContext ) {
    //   return false;
    // }
    var canvas = document.createElement("canvas"),
        ctx = canvas.getContext('2d'),
        x, y,
        opacity = opacity || 0.3;
    canvas.width  = width || 450;
    canvas.height  = height || 450;
    color = color || false;
    intensity= intensity || 60;
    // var noise_canvas_id=target+"_noise_fx_canvas"
    // $(canvas).attr("id",noise_canvas_id);
    // ctx.clearRect(0,0,width,height);
    // ctx.fillStyle = "rgba(0, 0, 200, 0.5)";
    for ( x = 0; x < canvas.width; x++ ) {
        for ( y = 0; y < canvas.height; y++ ) {
            if (color){
                red=Math.floor( Math.random() * intensity );
                green=Math.floor( Math.random() * intensity);
                blue=Math.floor( Math.random() * intensity );
            }
            else {
                number = Math.floor( Math.random() * intensity );
                red=number;
                green=number;
                blue=number;
            }


            ctx.fillStyle = "rgba(" + red + "," + green + "," + blue + "," + opacity + ")";
            ctx.fillRect(x, y, 1, 1);
        }
        // console.log($(canvas).attr("id"));
    }
   // alert($("#"+target).css("backgroundImage"));

    var new_background= "url(" + canvas.toDataURL("image/png") + ")"+","+$("#"+target).css("backgroundImage");
    // jq_get(atome_id).css("background-image", new_background)

    $("#"+target).css("backgroundImage",  new_background);
    // $("#"+noise_canvas_id).css("left","0.1");


    // document.body.style.backgroundImage = "url(" + canvas.toDataURL("image/png") + ")";
}
// generateNoise("my_div",90,0.6, 333, 333,false); // target, intensity, opacity, width, height, color
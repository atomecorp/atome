// Circular slider
function circular_sliders(target, id, length, thickness, helper_length, helper_thickness, value_size, back_color, range_color, helper_color, value_color, value, unit, min, max, orientation, smoothing) {

    $("#" + target).append("<div id='" + id + "'></div>");

    var slider_id = id + "_slider";

    var slider_unit_id = id + "_unit";

    $("#" + id).append("<div id=" + slider_id + "></div>");
    $("#" + id).css("width", length * 2);


    $("#" + slider_id).roundSlider({
        sliderType: "min-range",
        circleShape: "pie",
        startAngle: "315",
        lineCap: "round",
        radius: length,
        width: thickness,
        min: min,
        max: max,
        svgMode: true,
        pathColor: back_color,
        borderWidth: 0,
        startValue: 0,
        valueChange: function (e) {
            // var color = e.isInvertedRange ? "blue" : "red";
            console.log(e.value);
        }
    });
    $("#" + slider_id + " .rs-handle").css('background-color', helper_color).css('box-shadow', '0px 0px 6px 0px rgba(0,0,0,0.6)');
    $("#" + slider_id + " .rs-tooltip-text ").css('font-size', value_size).css('font-weight', 'bold').css("color", value_color);
    $("#" + slider_id).find(".rs-range").css({stroke: range_color});

    $("#" + id).append("<div id=" + slider_unit_id + ">" + unit + "</div>");
    $("#" + slider_unit_id)
        .css('font-size', value_size)
        .css('font-weight', 'bold')
        .css('position', 'relative')
        .css('width', '100%')
        .css('text-align', 'center')
        .css("color", value_color)
        .css('top', '-15px');


    $("#" + slider_id).css("filter", "drop-shadow(0px 0px 6px rgba(0,0,0,0.6))").css("z-index", 2);

    var sliderObj = $("#" + slider_id).data("roundSlider");
    sliderObj.setValue(33);

}


// Rectangular slider
function rectangular_sliders(target, id, length, thickness, helper_length, helper_thickness, value_size, back_color, range_color, helper_color, value_color, value, unit, min, max, orientation, smoothing) {

    $("#" + target).append("<div id='" + id + "'></div>");
    ////////
    var slider_id = id + "_slider";
    var slider_value_id = id + "_value";
    var slider_unit_id = id + "_unit";
    $("#" + id).append("<div id=" + slider_id + "></div>");

    ///////


    $("#" + slider_id).slider({
        orientation: orientation,
        range: "min",
        min: min,
        max: max,
        value: value,
        slide: function (event, ui) {
            console.log(ui.value);
            $("#" + id + "_value").text(ui.value);
        }
    })
        .css("background", back_color)
        .css("outline", "none")
        .css("border", "none");

    $("#" + slider_id + " .ui-slider-range")
        .css("background", range_color)
        .css("outline", "none")
        .css("border", "none");
    $("#" + slider_id + " .ui-slider-handle")
        .css("background", helper_color)
        .css("box-shadow", "0px 0px 6px rgba(0,0,0,0.6)");

    //  value text params here
    $("#" + id).append("<div id='" + id + "_value'>" + value + "</div>");
    $("#" + slider_value_id).attr("contenteditable",true);
    $("#" + slider_value_id)
        .css("font-size", value_size + "px")
        .css("color", value_color);

    //  unit text params here
    $("#" + id).append("<div id=" + slider_unit_id + ">" + unit + "</div>");
    $("#" + slider_unit_id)
        .css("position", "absolute")
        .css("color", value_color)
        .css("font-size", value_size + "px");

    if (orientation == "vertical") {
        // alert (helper_thickness/4);
        $("#" + slider_id + " .ui-slider-handle").css("margin-bottom",-(helper_thickness/4)+"px");


        $("#" + id).css("width", thickness);
        $("#" + id).css("height", length);

        // text positioning here
        var value_position = parseInt(value_size);
        value_position = (value_position + value_position / 2);
        $("#" + slider_value_id)
            .css("width", thickness)
            .css("text-align", "center")
            .css("top", parseInt(length) + parseInt(value_size) / 2 + "px")
            .css("position", "absolute")
            .css("min-width", "25px");

        // text unit positioning here
        $("#" + slider_unit_id)
            .css("position", "absolute")
            .css("width", thickness)
            .css("text-align", "center")
            .css("top", -value_position + "px");

        $("#" + slider_id).css("width", "100%");
        $("#" + slider_id).css("height", "100%");

        $("#" + slider_id + " .ui-slider-handle")
            .css("width", "100%")
            .css("height", helper_thickness)
            .css("left", "0px")
            .css("border-radius", smoothing);

    } else {

        $("#" + slider_id + " .ui-slider-handle").css("margin-left",-(helper_thickness/4)+"px");

        $("#" + id).css("width", length);
        $("#" + id).css("height", thickness);

        // text positioning here
        $("#" + slider_value_id)
            .css("position", "absolute")
            .css("left", parseInt(length) + parseInt(value_size / 2) + "px")
            .css("top", "0px")
            .css("height", thickness)
            .css("vertical-align", "middle")
            .css("display", "flex")
            .css("justify-content", "center")
            .css("align-items", "center");


        // text unit positioning here
        $("#" + slider_unit_id)
            .css("position", "absolute")
            .css("left", -value_size - value_size / 2 + "px")
            .css("top", "0px")
            .css("height", thickness)
            .css("vertical-align", "middle")
            .css("display", "flex")
            .css("justify-content", "center")
            .css("align-items", "center");

        $("#" + slider_id).css("width", "100%");
        $("#" + slider_id).css("height", "100%");


        $("#" + slider_id + " .ui-slider-handle")
            .css("width", helper_thickness)
            .css("height", "100%")
            .css("top", "0px")
            .css("border-radius", smoothing);
    }
    $("#" + id).css("box-shadow", "0px 0px 6px rgba(0,0,0,0.6)").css("z-index", 2);
}



// tests
// rectangular_sliders(
//     "intuition", "poil",
//     "120", "24",
//     null, "12",
//     "15",
//     "rgba(255,255,255,0.1)", "orange", "rgb(99, 99, 99, 1)", "orange",
//     33, 0, 100, "horizontal", 3);
//
// circular_sliders("intuition", "toto", 33, 12, 12, 12, 12,
//     "rgba(255,255,255,0.1)", "orange", "rgb(99, 99, 99, 1)", "orange",
//     63);
// $("#poil").css("left", 66);
// $("#toto").css("left", 66);
// $("#poil").css("top", 33);
// $("#toto").css("top", 99);
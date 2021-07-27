class MeteoHelper{
    constructor(town) {
        var callBackGetSuccess = function(data) {
            Opal.Atome.$text("La temperature à "+town+" est de " + data.main.temp+"°c");
        };
        var url = "https://api.openweathermap.org/data/2.5/weather?q="+town+",fr&appid=c21a75b667d6f7abb81f118dcf8d4611&units=metric";

        $.get(url, callBackGetSuccess).done(function() {
            //alert( "second success" );
        })
            .fail(function() {
                alert( "error" );
            })
            .always(function() {
                //alert( "finished" );
            });
    }

}


// function getMeteo(town) {
//     var url = "https://api.openweathermap.org/data/2.5/weather?q="+town+",fr&appid=c21a75b667d6f7abb81f118dcf8d4611&units=metric"
//
//     $.get(url, callBackGetSuccess).done(function() {
//         //alert( "second success" );
//     })
//         .fail(function() {
//             alert( "error" );
//         })
//         .always(function() {
//             //alert( "finished" );
//         });
// }

//
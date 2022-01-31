class MeteoHelper{
    constructor(town, proc) {
        var url = "https://api.openweathermap.org/data/2.5/weather?q="+town+",fr&appid=c21a75b667d6f7abb81f118dcf8d4611&units=metric";
        $.get(url).done(function(data) {
            Opal.JSUtils.$meteo_callback(data.main.temp,proc);
            // Opal.Atome.$text("La temperature à "+town+" : "+proc+" est de " + data.main.temp+"°c");
        })
            .fail(function() {
                // alert( "error" );
            })
            .always(function() {
                //alert( "finished" );
            });
    }
}

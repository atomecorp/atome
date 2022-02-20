
var requestFullscreen = function (element) {
    if (element.requestFullscreen) {
        element.requestFullscreen();
    } else if (element.webkitRequestFullscreen) {
        element.webkitRequestFullscreen();
    } else if (element.mozRequestFullScreen) {
        element.mozRequestFullScreen();
    } else if (element.msRequestFullscreen) {
        element.msRequestFullscreen();
    } else {
        element.webkitRequestFullscreen();
        console.log('Fullscreen API is not supported.');
    }
};

var exitFullscreen = function () {
    if (document.exitFullscreen) {
        document.exitFullscreen();
    } else if (document.webkitExitFullscreen) {
        document.webkitExitFullscreen();
    } else if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
    } else if (document.msExitFullscreen) {
        document.msExitFullscreen();
    } else {
        console.log('Fullscreen API is not supported.');
    }
};

const atome = {
    jsFullscreen: function (element,value) {
       if (value==true){
           requestFullscreen(element.get(0));
       }
       else if(value== false){
           exitFullscreen();
       }
       else {
           requestFullscreen(document.documentElement);
       }



    },
    jsMap: function (id,longitude, lattitude) {
        if ("geolocation" in navigator) {
            if (typeof(longitude)== "number"){
                var mymap = L.map(id).setView([longitude, lattitude], 6);
                L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
                    maxZoom: 18,
                    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, ' +
                        'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
                    id: 'mapbox/streets-v11',
                    tileSize: 512,
                    zoomOffset: -1
                }).addTo(mymap);
                $(".leaflet-control-attribution").remove();
            }
            else{
                navigator.geolocation.getCurrentPosition(function(position) {
                    var mymap = L.map(id).setView([position.coords.latitude, position.coords.longitude], 15);
                    L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
                        maxZoom: 18,
                        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, ' +
                            'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
                        id: 'mapbox/streets-v11',
                        tileSize: 512,
                        zoomOffset: -1
                    }).addTo(mymap);
                    $(".leaflet-control-attribution").remove();
                });
            }

        } else {
            /* no geolocation */
        }
    },
    jsAdress: function (proc) {
        window.addEventListener('popstate', function (event) {
            // var address_bar_content= "location: " + document.location + ", state: " + JSON.stringify(event.state);
            // var address_bar_content={location:  document.location, state: JSON.stringify(event.state)};
            var address_bar_content=Opal.hash({location:  document.location, state: JSON.stringify(event.state)});
            Opal.JSUtils.$adress_callback(address_bar_content,proc);
        });
    },
    select_text_content: function (atome_id, selection) {
        document.querySelector('#'+atome_id).onfocus = function(e) {
            var el = this;
            requestAnimationFrame(function() {
                selectElementContents(el);
            });
        };

        function selectElementContents(el) {
            var range = document.createRange();
            range.selectNodeContents(el);
            var sel = window.getSelection();
            sel.removeAllRanges();
            sel.addRange(range);
        }
    },
    //address="https://github.com"
    jsPing: function (address, sucess, error) {
        var p = new Ping();
        p.ping(address, function (err, data) {
            if (err) {
                Opal.eval(error);
            } else {
                Opal.eval(sucess);
            }
        });
    },
    jsIsMobile: function () {
        const a = navigator.userAgent || navigator.vendor || window.opera;
        var mobile = false;
        if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) {
            // true for mobile device
            mobile = "mobile";
        } else {
            // false for not mobile device
            mobile = "desktop";
        }
        return mobile;
    }, jsGet_items_under_pointer(e) {
        var x = e.clientX,
            y = e.clientY,
            elementMouseIsOver = document.elementsFromPoint(x, y);
        var collected_atomes = [];
        for (var item in elementMouseIsOver) {
            element = $(elementMouseIsOver[item]);
            if (element.attr('id')) {
                collected_atomes.push(element.attr('id'));
            }
        }
        var element_to_remove = ["view", "intuition", "device", "user_device"];

        element_to_remove.forEach(function (item, index, arr) {
            remove_item_from_Array(collected_atomes, item);
        });
        return collected_atomes;
    },

    jsReader: function (filename, proc) {
        $.ajax({
            url: filename,
            dataType: 'text',
            success: function (data) {
                return proc.$call(data);
            }
        });
    },
    jsSchedule: function (years, months, days, hours, minutes, seconds, proc) {
        const now = new Date();
        const formatedDate = new Date(years, months - 1, days, hours, minutes, seconds);
        const diffTime = Math.abs(formatedDate - now);
        setTimeout(function () {
            Opal.JSUtils.$schedule_callback(proc);
        }, diffTime);
    },
    jsLoadCodeEditor: function (atome_id, content) {
        $('<link/>', {
            rel: 'stylesheet',
            type: 'text/css',
            href: 'css/codemirror.css'
        }).appendTo('head');
        $.getScript('js/third_parties/ide/codemirror.min.js', function (data, textStatus, jqxhr) {
            $.getScript('js/third_parties/ide/active-line.min.js', function (data, textStatus, jqxhr) {
                $.getScript('js/third_parties/ide/closebrackets.min.js', function (data, textStatus, jqxhr) {
                    $.getScript('js/third_parties/ide/closetag.min.js', function (data, textStatus, jqxhr) {
                        $.getScript('js/third_parties/ide/dialog.min.js', function (data, textStatus, jqxhr) {
                            $.getScript('js/third_parties/ide/formatting.min.js', function (data, textStatus, jqxhr) {
                                $.getScript('js/third_parties/ide/javascript.min.js', function (data, textStatus, jqxhr) {
                                    $.getScript('js/third_parties/ide/jump-to-line.min.js', function (data, textStatus, jqxhr) {
                                        $.getScript('js/third_parties/ide/matchbrackets.min.js', function (data, textStatus, jqxhr) {
                                            $.getScript('js/third_parties/ide/ruby.min.js', function (data, textStatus, jqxhr) {
                                                $.getScript('js/third_parties/ide/search.min.js', function (data, textStatus, jqxhr) {
                                                    $.getScript('js/third_parties/ide/searchcursor.min.js', function (data, textStatus, jqxhr) {
                                                        ide_container_id = "#" + atome_id;
                                                        ide_id = 'ide_' + atome_id;
                                                        $(ide_container_id).append("<textarea id=" + ide_id + " name='code'></textarea>");
                                                        var code_editor = CodeMirror.fromTextArea(document.getElementById(ide_id), {
                                                            lineNumbers: true,
                                                            codeFolding: true,
                                                            styleActiveLine: true,
                                                            indentWithTabs: true,
                                                            matchTags: true,
                                                            matchBrackets: true,
                                                            electricChars: true,
                                                            mode: "ruby",
                                                            lineWrapping: true,
                                                            indentAuto: true,
                                                            autoCloseBrackets: true,
                                                            tabMode: "shift",
                                                            autoRefresh: true
                                                        });
                                                        new_editor = document.querySelector(".CodeMirror");
// we check all codemirror if they have an id to avoid to reassign an id to already created codemirror
                                                        if (($(new_editor).attr('id')) == undefined) {
                                                            new_editor_id = "cm_" + atome_id;
                                                            $(new_editor).attr('id', new_editor_id);
                                                        }
                                                        code_editor.setSize("100%", "100%");
                                                        code_editor.setOption("theme", "3024-night");

                                                        function getSelectedRange() {
                                                            return {
                                                                from: editor.getCursor(true),
                                                                to: editor.getCursor(false)
                                                            };
                                                        }

                                                        Opal.JSUtils.$set_ide_content(atome_id, content);
                                                    });
                                                });
                                            });
                                        });
                                    });
                                });
                            });
                        });
                    });
                });
            });
        });
    }
};

// var supportsTouch = false;
// if ('ontouchstart' in window) {
//     //iOS & android
//     supportsTouch = true;
// alert ("tactile");
// } else if(window.navigator.msPointerEnabled) {
//     alert ("je sais pas pour  w10");
//     // Windows
//     // To test for touch capable hardware
//     if(navigator.msMaxTouchPoints) {
//         supportsTouch = true;
//         alert ("Tactile pour windows");
//     }
//
// }
// else {
//     alert ("pas tactile du tout");
// }

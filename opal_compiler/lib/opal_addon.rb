# opal-jquery add_on
class Element
  def offset value = nil
    if value.nil?
      Native(`self.offset()`)
    else
      left = value[:left].to_f
      top = value[:top].to_f
      Native(`self.offset({left: #{left}, top: #{top}})`)
    end
  end
  def offsetTop
    Native(`self[0].offsetTop`)
  end
  def offsetLeft
    Native(`self[0].offsetLeft`)
  end

  def replaceElementTag(params)
    alert ("opal_compiler line 20+#{params}")
    #function replaceElementTag(targetSelector, newTagString) {
    #  $(targetSelector).each(function(){
    #    var newElem = $(newTagString, {html: $(this).html()});
    #    $.each(this.attributes, function() {
    #      newElem.attr(this.name, this.value);
    #    });
    #    $(this).replaceWith(newElem);
    #  });
    #}
    #
    #replaceElementTag('span', '<div></div>');
  end
end

class Event
  def self.set params
    @x = params[0]
    @y = params[1]
    # we update current_atome position
    #puts ("from opal_addon : we update current_atome position")
    return self
  end

  def self.x
    @x
  end

  def self.y
    @y
  end

  def self.time
    @time
  end

  #def self.pep_drag proc, evt
  #  evt = Event.set(evt)
  #  ## we update current_atome position
  #  proc.call(evt) if proc.is_a?(Proc)
  #end

  def self.playing proc, evt
    @time = evt
    evt = Event.set(evt)
    proc.call(evt) if proc.is_a?(Proc)
  end

  def x touch_nb = 0
    if touch_nb == 0

      `
   return #@native.pageX
`
    else
      `
    if ('TouchEvent' in window ){
return #@native.originalEvent.touches[#{touch_nb}].pageX
    }
    else{
     return false
    }
`
    end
  end

  def y touch_nb = 0
    if touch_nb == 0
      `
return #@native.pageY
`
    else
      `
    if ('TouchEvent' in window ){
return #@native.originalEvent.touches[#{touch_nb}].pageY
    }
    else{
     return false
    }
`
    end
  end

  def touch_x(touch_nb = 0)
    `#@native.originalEvent.touches[#{touch_nb}].pageX`
  end

  def touch_y(touch_nb = 0)
    `#@native.originalEvent.touches[#{touch_nb}].pageY`
  end


end
#patch to use Js instead of $$ (attention Js is not JS !!! )
Js = $$

module JS_utils

  def initialize
    @codemirror=[]
  end
  @project_intervals = []
  @project_timeouts = []
  # methods to store js inetrval and remove them when clearing scene

  def self.device
    `window`
  end

  def self.document
    `$(document)`
  end


  #time operation
  def self.add_interval(interval)
    @project_intervals << interval
  end

  def self.clear_interval params
    `clearInterval(#{params[1]})`
  end

  def self.clear_intervals
    @project_intervals.each do |interval|
      ` clearInterval(#{interval})`
    end
    @project_intervals = []
  end

  def self.add_timeout(timeout)
    @project_timeouts << timeout
  end

  def self.clearTimeout params
    `clearTimeout(#{params[1]})`
  end

  def self.clear_timeouts
    @project_timeouts.each do |timeout|
      `clearTimeout(#{timeout})`
    end
    @project_timeouts = []
  end

  def self.setTimeout(time, &proc)
    `
    var timeout=setTimeout(function(){ #{yield} }, #{time * 1000});
Opal.JS_utils.$add_timeout(timeout);
`
  end

  def self.stop params
    `clearInterval(#{params})`
  end

  def self.setInterval(delay, times, &proc)
    `  var timesRun = 0;
var interval = setInterval(function(){
    timesRun += 1;
    if(timesRun === #{times}){
        clearInterval(interval);
    }
 #{yield}
}, #{delay}*1000);
Opal.JS_utils.$add_interval(interval);
return interval
`
  end



  def self.mobile
    `
// mobile test
var mobile;
const a = navigator.userAgent || navigator.vendor || window.opera
var mobile=false;
if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) {
    // true for mobile device
    mobile = true
} else {
    // false for not mobile device
    mobile = false
}
return mobile
`

  end
#   def self.virtual_touch (target, action)
#     `
# function simulate_touch(target, action) {
#      var event = new MouseEvent('click', {
#     'view': window,
#     'bubbles': true,
#     'cancelable': true
#   });
# var video = document.getElementById(target);
# var canceled = !video.dispatchEvent(event);
#
#   if (canceled) {
#     //Un gestionnaire appelé preventDefault.
# // alert("canceled");
#   } else {
#     //Aucun gestionnaires appelé preventDefault.
#   //Opal.eval(action);
# eval(action)
#   }
# }
# simulate_touch(target, action);
# `
#   end

  def self.render_proc proc
    proc.call() if proc.is_a?(Proc)
  end

  def self.enter atome, proc
    `$(#{atome}).droppable({
   over: function(){
     #{self.render_proc proc}
      }
    });`
  end

  def self.leave atome, proc
    `$(#{atome}).droppable({
   out: function(){
     #{self.render_proc proc}
      }
    });`
  end

  def self.drop atome, proc
    `



//////////////////////////////////////////
$(#{atome}).droppable({
      drop: function( event, ui ) {
#{self.render_proc proc}
      }
    });
//window.ondrop = function (event, ui) {
//   event.preventDefault(event);
//{self.render_proc proc}
//   //alert ('kooll');
//   upload(event);
//
//
//;

`
  end

  def self.video_play video, params, proc
    video_id = video.atome_id
    `
var media=$("#"+#{video_id} +' video:first-child')[0];
if (#{params}==true || #{params}=='true'){
  #{params} = 0;
}
media.addEventListener("timeupdate", function(){
Opal.Event.$playing(#{proc},media.currentTime)
        });
//media.currentTime is run twice, because if not depending on the context it may not be interpreted
media.currentTime = #{params};
media.addEventListener('loadedmetadata', function() {
media.currentTime = #{params};
}, false);
media.play();
`
  end



  def self.audio_play audio, params, proc
    audio_id = audio.atome_id
    `
 var media=$("#"+#{audio_id} +' audio:first-child')[0];
if (#{params}==true || #{params}=='true'){
  #{params} = 0;
}
media.addEventListener("timeupdate", function(){
Opal.Event.$playing(#{proc},media.currentTime)
        });
//media.currentTime is run twice, because if not depending on the context it may not be interpreted
media.currentTime = #{params};
media.addEventListener('loadedmetadata', function() {
  media.currentTime = #{params};
}, false);
media.play()

`
  end

  def self.video_pause video, play_pos
    video_id = video.atome_id
    `
var media=$("#"+#{video_id} +' video:first-child')[0];
  media.pause();
play_pos=#{play_pos}
if (play_pos != ""){
media.currentTime = play_pos;
}
`
  end

  def self.audio_pause audio, play_pos
    audio_id = audio.atome_id
    `
 var audio=$("#"+#{audio_id} +' audio:first-child')[0];
audio.pause();
play_pos=#{play_pos}
if (play_pos != ""){
audio.currentTime = play_pos;
}
`
  end

  def self.audio_level audio, params
    audio_id = audio.atome_id
    `
 var media=$("#"+#{audio_id} +' audio:first-child')[0];
media.volume= (#{params})
`
  end

  def self.loader filename, action, code
    if code == :ruby
      `
   $.ajax({
        url: #{filename}+'.rb',
        dataType: 'text',
        success: function (data) {
           // data=protect_accent(data)
            if (#{action}=="console"){
                Opal.Object.$puts(data);
            }
        else{
                 Opal.eval(data);
            }
        }
    });
`
    else
      `
  $.getScript("./medias/javascripts/"+#{filename}+".js", function (data, textStatus, jqxhr) {
           //Opal.Object.$box();
         });
`
    end

  end

  def self.is_mobile
    `
    let check = false;
    (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
    return check;
  `
  end

  def self.user_agent
    `
  return navigator.userAgent
  `
  end


  def self.load_codemirror ide_atome_id, content
    if @codemirror.class!=Array
      @codemirror=[]
    end

    if @codemirror ==[]
      `$('<link/>', {
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
                                                    #{@codemirror << ide_atome_id}
ide_container_id="#"+#{ide_atome_id}
ide_id='ide_'+#{ide_atome_id}
$(ide_container_id).append("<textarea id="+ide_id+" name='code'></textarea>");
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
new_editor=document.querySelector(".CodeMirror");
// we check all codemirror if they have an id to avoid to reassign an id to already created codemirror
if (($(new_editor).attr('id'))== undefined){
new_editor_id="cm_"+#{ide_atome_id}
$(new_editor).attr('id',new_editor_id )
};
code_editor.setSize("100%", "100%");
code_editor.setOption("theme", "3024-night");
function getSelectedRange() {
    return {
        from: editor.getCursor(true),
        to: editor.getCursor(false)
    };
}
Opal.JS_utils.$set_ide_content(#{ide_atome_id}, #{content})

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
`
      end
  end

  def self.codemirror_ready
    @codemirror
  end


  def self.set_ide_content ide_id, content
    editor_id= "cm_"+ide_id
    `document.getElementById(#{editor_id}).CodeMirror.getDoc().setValue(#{content})`
  end

  def self.get_ide_content ide_id
    editor_id= "cm_"+ide_id
    return `document.getElementById(#{editor_id}).CodeMirror.getDoc().getValue("\n")`

  end

  #import utils
#  def import
#    `
#function import_visual_medias(e, file) {
#    // $( "#output" ).remove();
#    // $("body").append('<img id="output" />');
#    // $("#output").css("z-index",50000);
#    // $("#output").css("position","absolute");
#
#    var input = e.target;
#    var reader = new FileReader();
#    reader.onload = function () {
#        var dataURL = reader.result;
#        // alert(dataURL)
#        $('#view').append('<img id="output"  alt="Girl in a jacket" width="500" height="600">');
#        var output = document.getElementById('output');
#        output.src = dataURL;
#        // img_width=document.getElementById('output').width
#        // if (img_width !=0){
#        //     console.log("sucess"+img_width );
#        // }
#        // else {
#        //     retry_to_get_the_img_informations(img_width);
#        // }
#    };
#
#    // Opal.Object.$store(file.name, file);
#
#
#
#    reader.readAsDataURL(file);
#}
#
#function import_audio(e, file) {
#    var input = e.target;
#    var reader = new FileReader();
#    reader.onload = function () {
#        var dataURL = reader.result
#        // var output = document.getElementById('output');
#        //output.src = dataURL;
#    };
#    reader.readAsDataURL(file);
#}
#
#function import_text(e, file) {
#    var textType = /text.*/;
#    if (file.type.match(textType)) {
#        var reader = new FileReader();
#        reader.onload = function (e) {
#            fileDisplayArea.innerText = reader.result;
#        };
#        reader.readAsText(file);
#    }
#}
#
#function upload(e) {
#
#    var files = e.dataTransfer.files
#    // alert(files.length);
#    for (var i = 0; i < files.length; i++) {
#        file_type = files[i].type;
#        file_name = files[i].name;
#        file_datas = files[i].name;
#        console.log(file_datas);
#
#
#////////////////////////////////////////////////////////////////////////////////////////
#        switch (file_type) {
#            case 'video/quicktime':
#                import_visual_medias(e, files[i]);
#                break;
#            case 'video/x-m4v':
#                import_visual_medias(e, files[i]);
#                break;
#            case 'text/plain':
#                import_text(e, files[i]);
#                break;
#            case 'video/mp4':
#                import_visual_medias(e, files[i]);
#                break;
#            case 'audio/x-m4a':
#                import_audio(e, files[i]);
#                break;
#            case 'image/png':
#                import_visual_medias(e, files[i]);
#                break;
#            case 'image/jpeg':
#                import_visual_medias(e, files[i]);
#                break;
#            case 'text/xml':
#                import_text(e, files[i]);
#                break;
#            case 'image/svg+xml':
#                import_visual_medias(e, files[i]);
#                break;
#            default:
#                console.log('Unknown file format');
#        }
#    }
#}
#`
#  end
#
#  def drop
#    `
#    window.ondragover = function (e) {
#    e.preventDefault();
#};
#window.ondrop = function (e) {
#    e.preventDefault(e);
#    alert ('kooll');
#    upload(e);
#};
#`
#  end


  def self.set_handles_size params=nil
    `$('.ui-resizable-w').width(30)`
    `$('.ui-resizable-e').width(30)`
    `$('.ui-resizable-n').height(30)`
    `$('.ui-resizable-s').height(30)`
    `$('.ui-resizable-ne').width(30)`
    `$('.ui-resizable-se').width(30)`
    `$('.ui-resizable-sw').width(30)`
    `$('.ui-resizable-nw').width(30)`
    `$('.ui-resizable-ne').height(30)`
    `$('.ui-resizable-se').height(30)`
    `$('.ui-resizable-sw').height(30)`
    `$('.ui-resizable-nw').height(30)`
  end


end

module Opal_utils

  def self.load_opal_parser
    if $opal_parser != true
      `
    $.getScript('js/third_parties/opal/opal_parser.js', function (data, textStatus, jqxhr) {
#{$opal_parser = true}
            });
`
    end
  end

  def self.opal_parser_ready
    @opal_parser
  end

end
def message params
  message="{ \"action\": \"#{params}\"}"
  `webSocketHelper.sendMessage(#{message})`
end

################ media manipulation ############

def animate(params)
  obj = params[:target]
  obj = if obj.nil?
          self.atome_id
        elsif obj.class == Atome
          obj.atome_id
        else
          Object.get(obj).atome_id
        end
  params.delete(:target)
  if params[:start][:blur]
    value_found = params[:start][:blur]
    params[:start][:filter] = "blur(#{value_found}px)"
    params[:start].delete(:blur)
  end
  if params[:end][:blur]
    value_found = params[:end][:blur]
    params[:end][:filter] = "blur(#{value_found}px)"
    params[:end].delete(:blur)
  end
  if params[:start][:smooth]
    value_found = params[:start][:smooth]
    params[:start][:borderRadius] = value_found
    params[:start].delete(:smooth)
  end
  if params[:end][:smooth]
    value_found = params[:end][:smooth]
    params[:end][:borderRadius] = value_found
    params[:end].delete(:smooth)
  end

  if params[:start][:color]
    value_found = params[:start][:color]
    params[:start][:background] = value_found
    params[:start].delete(:color)
  end
  if params[:end][:color]
    value_found = params[:end][:color]
    params[:end][:background] = value_found
    params[:end].delete(:color)
  end
  Render.render_animate(params, obj)
end

def animate=(params)
  animate(params)
end

def anim(params)
  animate(params)
end



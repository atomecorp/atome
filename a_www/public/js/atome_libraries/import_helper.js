class ImportHelper {
    addImage(parent, url) {
        const randomId = Math.random().toString(16).substr(2, 32);
        $('#' + parent).append('<img id="' + randomId + '"  width="500" height="600">');
        const output = document.getElementById(randomId);
        output.src = url;
    }
}
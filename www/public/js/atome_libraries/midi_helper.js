class MidiHelper {
    constructor(midiEventListener) {
        $.getScript("js/third_parties/audio_engines/webmidi.min.js", function () {

        });
        this.midiEventListener = midiEventListener;
        this.interfaces_out = [];
        this.interfaces_in = [];

        const self = this;

        WebMidi.enable(function (err) {
            if (err) {
                self.midiEventListener.onError(err);
            } else {
                console.log("WebMidi enabled!");
                for (const interfaceName of WebMidi.outputs) {
                    self.interfaces_out.push(interfaceName["name"]);
                }
                for (const interfaceName of WebMidi.inputs) {
                    self.interfaces_in.push(interfaceName["name"]);
                }
                self.output = WebMidi.outputs[13];

                self.midiEventListener.onConnected();
            }
        });
    }

    inputs() {
        return this.interfaces_in;
    }

    outputs() {
        return this.interfaces_out;
    }

    play(note, channel, options) {
        options= options.$to_n();
        this.output.playNote(note, channel, options);
    }
    send_cc(controller, value) {
        alert(controller);
        this.output.sendControlChange(controller, value);
    }

    stop(note, channel, options) {
        options= options.$to_n();
        this.output.stopNote(note, channel, options);
    }
}
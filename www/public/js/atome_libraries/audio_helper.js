class AudioHelper{
    verif(){
        // create a synth and connect it to the main output (your speakers)
        const synth = new Tone.Synth().toDestination();
        //play a middle 'C' for the duration of an 8th note
        synth.triggerAttackRelease("C4", "8n");
    }
}
//
// const aaudio = new AudioHelper();
// aaudio.verif();
//
//
// // const synth = new Tone.Synth().toDestination();
// //
// // //play a middle 'C' for the duration of an 8th note
// // synth.triggerAttackRelease("C4", "8n");

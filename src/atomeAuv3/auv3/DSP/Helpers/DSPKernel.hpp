//
//  DSPKernel.hpp
//  webviewauv3
//
//  Created by jeezs on 26/04/2022.
//

#ifndef DSPKernel_h
#define DSPKernel_h

#import <AudioToolbox/AudioToolbox.h>
#import <algorithm>

// Put your DSP code into a subclass of DSPKernel.
class DSPKernel {
public:
    virtual void process(AUAudioFrameCount frameCount, AUAudioFrameCount bufferOffset) = 0;

    // Override to handle MIDI events.
    virtual void handleMIDIEvent(AUMIDIEvent const& midiEvent) {}
    virtual void handleParameterEvent(AUParameterEvent const& parameterEvent) {}

    void processWithEvents(AudioTimeStamp const* timestamp, AUAudioFrameCount frameCount, AURenderEvent const* events, AUMIDIOutputEventBlock midiOut);

    AUAudioFrameCount maximumFramesToRender() const {
        return maxFramesToRender;
    }

    void setMaximumFramesToRender(const AUAudioFrameCount &maxFrames) {
        maxFramesToRender = maxFrames;
    }

private:
    void handleOneEvent(AURenderEvent const* event);
    void performAllSimultaneousEvents(AUEventSampleTime now, AURenderEvent const*& event, AUMIDIOutputEventBlock midiOut);

    AUAudioFrameCount maxFramesToRender = 1024;
};

#endif /* DSPKernel_h */

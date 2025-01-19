//
//  webviewauv3AudioUnit.h
//  webviewauv3
//
//  Created by jeezs on 26/04/2022.
//

#import <AudioToolbox/AudioToolbox.h>
#import "webviewauv3DSPKernelAdapter.h"

// Define parameter addresses.
extern const AudioUnitParameterID myParam1;

@interface webviewauv3AudioUnit : AUAudioUnit

@property (nonatomic, readonly) webviewauv3DSPKernelAdapter *kernelAdapter;
- (void)setupAudioBuses;
- (void)setupParameterTree;
- (void)setupParameterCallbacks;
@end

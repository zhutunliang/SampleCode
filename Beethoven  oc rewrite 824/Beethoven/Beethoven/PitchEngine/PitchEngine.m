//
//  PitchEngine.m
//  Beethoven
//
//  Created by nemo on 2018/8/24.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "PitchEngine.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "SignalTraker.h"
#import "FFTTransformer.h"
#import "Estimator.h"

@interface PitchEngine () <SignalTrackerDelegate>

@property (nonatomic ,assign) BOOL active;
@property (nonatomic ,weak) id <PitchEngineDelegate> delegate;

@property (nonatomic ,strong) Estimator *estimator;
@property (nonatomic ,strong) SignalTraker *signalTraker;
@property (nonatomic ,strong) dispatch_queue_t queue;

@end


@implementation PitchEngine

- (instancetype)initWithDelegate:(id<PitchEngineDelegate>)delegate
{
    self = [super init];
    AVAudioFrameCount bufferSize = 4096;
    self.estimator = [[Estimator alloc]init];
    self.signalTraker = [[SignalTraker alloc]initWithBufferSize:bufferSize];
    self.queue = dispatch_queue_create("BeethovenQueue", 0);
    self.delegate = delegate;
    self.signalTraker.delegate = self;
    return self;
}

- (void)start
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    switch (audioSession.recordPermission) {
        case AVAudioSessionRecordPermissionGranted:
            [self avtivate];
            break;
        case AVAudioSessionRecordPermissionDenied:
            dispatch_async(dispatch_get_main_queue(), ^{
                NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication]openURL:settingURL options:@{} completionHandler:nil];
            });
            break;
        case AVAudioSessionRecordPermissionUndetermined:
            [[AVAudioSession sharedInstance]requestRecordPermission:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self avtivate];
                    });
                }
            }];
            break;
    }
}

- (void)stop
{
    [self.signalTraker stop];
    self.active = NO;
}


- (void)avtivate
{
    [self.signalTraker start];
    self.active = YES;
}


#pragma mark - SignalTrackerDelegate

- (void)signalTraker:(SignalTraker *)signalTraker didReceiveBuffer:(AVAudioPCMBuffer *)buffer atTime:(AVAudioTime *)time
{
    dispatch_async(self.queue, ^{
        Buffer *transferdBuffer = [FFTTransformer transformFormPCMBuffer:buffer];
        float frequency = [self.estimator estimateFrequencyWithSampleRate: (float)time.sampleRate buffer:transferdBuffer];
        if (self.delegate && [self.delegate respondsToSelector:@selector(pitchEngine:frequency:)]) {
            [self.delegate pitchEngine:self frequency:frequency];
        }
    });
}

- (void)signalTrakerWentBelowLevelThreshold:(SignalTraker *)sinalTraker
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(signalTrakerWentBelowLevelThreshold:)]) {
        [self.delegate performSelector:@selector(signalTrakerWentBelowLevelThreshold:)withObject:self];
    }
    
}

- (void)signalTraker:(SignalTraker *)signalTraker didReceiveError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(signalTraker:didReceiveError:)]) {
        [self.delegate performSelector:@selector(pitchEngine:didReceiveError:) withObject:self withObject:error];
    }
}


@end

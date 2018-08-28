//
//  SignalTraker.h
//  Beethoven
//
//  Created by nemo on 2018/8/24.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class SignalTraker;
@protocol SignalTrackerDelegate <NSObject>

- (void)signalTraker:(SignalTraker *)signalTraker didReceiveBuffer:(AVAudioPCMBuffer*)buffer atTime:(AVAudioTime*)time;
- (void)signalTrakerWentBelowLevelThreshold:(SignalTraker *)sinalTraker;
- (void)signalTraker:(SignalTraker *)signalTraker didReceiveError:(NSError *)error;

@end


@interface SignalTraker : NSObject

@property (nonatomic ,weak) id<SignalTrackerDelegate> delegate;

- (instancetype)initWithBufferSize:(AVAudioFrameCount)bufferSize;

- (void)start;

- (void)stop;

@end

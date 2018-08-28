//
//  PitchEngine.h
//  Beethoven
//
//  Created by nemo on 2018/8/24.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PitchEngine;
@protocol PitchEngineDelegate <NSObject>
- (void)pitchEngine:(PitchEngine *)pitchEngine frequency:(float)frequency;
- (void)pitchEngineWentBelowLevelThreshold:(PitchEngine *)pitchEngine;
- (void)pitchEngine:(PitchEngine *)pitchEngine didReceiveError:(NSError *)error;
@end

@interface PitchEngine : NSObject

@property (nonatomic ,assign,readonly) BOOL active;

- (instancetype)initWithDelegate:(id <PitchEngineDelegate>)delegate;

- (void)start;
- (void)stop;

@end

//
//  Estimator.m
//  Beethoven
//
//  Created by nemo on 2018/8/13.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "Estimator.h"

@implementation Estimator

- (float)estimateFrequencyWithSampleRate:(float)sampleRate buffer:(Buffer *)buffer
{
    NSUInteger location = [self estimateLocationWithBuffer:buffer];
    float frequency = [self estimateFrequencyWithSampleRate:sampleRate location:location bufferCount:buffer.elements.count];
    return frequency;
}


- (float)estimateFrequencyWithSampleRate:(float)sampleRate location:(NSUInteger)location bufferCount:(NSUInteger)bufferCount
{
    if (bufferCount != 0) {
        float frequecny = (location * sampleRate) / (bufferCount * 2);
        return frequecny;
    }
    return 0;
}

- (NSUInteger)estimateLocationWithBuffer:(Buffer *)buffer
{
    return [self maxBufferIndexFromBuffer:buffer.elements];
}


- (NSUInteger)maxBufferIndexFromBuffer:(NSArray *)elementArray
{
    NSNumber *max = 0;
    if (elementArray.count > 0) {
        for (NSNumber *obj in elementArray) {
            if ([obj floatValue] > [max floatValue]) {
                max = obj;
            }
        }
    }
    NSUInteger index = [elementArray indexOfObject:max];
    return index;
}


@end

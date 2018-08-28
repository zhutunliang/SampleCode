//
//  Estimator.h
//  Beethoven
//
//  Created by nemo on 2018/8/13.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Buffer.h"

@interface Estimator : NSObject

- (float)estimateFrequencyWithSampleRate:(float)sampleRate buffer:(Buffer*)buffer;

@end

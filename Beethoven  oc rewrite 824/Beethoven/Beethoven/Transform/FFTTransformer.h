//
//  FFTTransformer.h
//  Beethoven
//
//  Created by nemo on 2018/8/13.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "Transformer.h"

@interface FFTTransformer : NSObject

+ (Buffer *)transformFormPCMBuffer:(AVAudioPCMBuffer *)pcmBuffer;

@end

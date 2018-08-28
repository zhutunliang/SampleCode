//
//  Transformer.h
//  Beethoven
//
//  Created by nemo on 2018/8/13.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Buffer.h"
#import <AVFoundation/AVFoundation.h>

@interface Transformer : NSObject

- (Buffer *)transformFormPCMBuffer:(AVAudioPCMBuffer *)pcmBuffer;


@end

//
//  Buffer.m
//  Beethoven
//
//  Created by nemo on 2018/8/13.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "Buffer.h"

@implementation Buffer

- (instancetype)initWithElements:(NSArray *)elements
{
    self = [super init];
    self.elements = [elements copy];
    return self;
}

@end

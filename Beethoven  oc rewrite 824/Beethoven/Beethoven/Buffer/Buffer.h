//
//  Buffer.h
//  Beethoven
//
//  Created by nemo on 2018/8/13.
//  Copyright © 2018年 搜狗. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface Buffer : NSObject

@property (nonatomic ,copy) NSArray *elements;

- (instancetype)initWithElements:(NSArray *)elements;

@end

//
//  UIImage+SGAddRoundCorner.h
//  ImageCorner
//
//  Created by hong on 2018/7/29.
//  Copyright © 2018年 hong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SGRectCornerTopLeft,
    SGRectCornerTopRight,
    SGRectCornerBottomLeft,
    SGRectCornerBottomRight
} SGRectCorner;

@interface UIImage (SGAddRoundCorner)

+ (UIImage *)imageWithCornerRadius:(CGFloat)cornerRadius rectCorner:(SGRectCorner)rectCorner color:(UIColor *)color;

@end

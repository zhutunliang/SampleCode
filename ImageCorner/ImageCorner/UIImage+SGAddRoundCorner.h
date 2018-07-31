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

typedef  void (^DrawCompleteBlock)(UIImage *image);

@interface UIImage (SGAddRoundCorner)

+ (void)imageWithCornerRadius:(CGFloat)cornerRadius rectCorner:(SGRectCorner)rectCorner color:(UIColor *)color completeBlock:(DrawCompleteBlock)completeBlock;

@end

@interface UIImage (Rotate)

/** 将图片旋转弧度radians */
/*
  考虑到 四个圆角的图形基本类似，可以通过旋转角度得到。
  尝试此种方式后，得出结论：
  旋转image 也是通过CG 画图，且画出的弧度相对于原图会有锯齿的形状。
  因此，此方案行不通，被废弃。
 */
- (void)imageRotatedByRadians:(CGFloat)radians completeBlock:(DrawCompleteBlock)completeBlock;

@end


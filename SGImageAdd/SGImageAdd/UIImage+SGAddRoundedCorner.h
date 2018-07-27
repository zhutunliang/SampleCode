//
//  UIImage+SGAddRoundedCorner.h
//  SGImageAdd
//
//  Created by nemo on 2018/7/26.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SGAddRoundedCorner)

/**
 CG画圆角图片
 
 @param color 圆角填充颜色
 @param radius 圆角半径
 @param size 矩形尺寸
 @return image
 */
+ (UIImage *)maskRoundCornerRadiusImageWithCorlor:(UIColor *)color CornerRadius:(CGFloat)radius size:(CGSize)size ;


/**
 裁剪图片 UIBezierPath
 
 @param radius 圆角半径
 @param size 矩形尺寸
 @return image
 */
- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadiusArray:(NSArray<NSNumber *> *)cornerRadius;

@end

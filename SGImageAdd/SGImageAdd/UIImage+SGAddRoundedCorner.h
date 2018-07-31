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
 @return image  裁剪出一个透明的有圆角的大图，将其覆盖在原imageView上，但考虑到覆盖大图的性能问题，此方法原则上废弃。 胎死腹中。
 
 后优化成，画四个小圆角，（存储），并覆盖在原imageView上
 */
+ (UIImage *)maskRoundCornerRadiusImageWithCorlor:(UIColor *)color CornerRadius:(CGFloat)radius size:(CGSize)size ;



// 裁剪图片，得到一个画了四个圆角的带color 的图，将其覆盖在原imageView 上。 但是这种画圆角的方式，没有上种方法圆滑。
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadiusArray:(NSArray<NSNumber *> *)cornerRadius;


/**
 裁剪图片 UIBezierPath
 
 @param radius 圆角半径
 @param size 矩形尺寸
 @return image 裁剪后的图片
 */
- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;


@end

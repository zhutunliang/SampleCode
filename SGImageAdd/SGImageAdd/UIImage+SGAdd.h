//
//  UIImage+SGAdd.h
//  SGImageAdd
//
//  Created by nemo on 2018/7/25.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SGAdd)


- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

/**
 裁剪图片
 
 @param radius 裁剪半径
 @param borderWidth 线宽值
 @param borderColor 线颜色
 @return image
 */

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


/**
 裁剪图片

 @param radius 裁剪半径
 @param corners 裁剪角，枚举
 @param borderWidth 线宽值
 @param borderColor 线颜色
 @param borderLineJoin 线转交类型 ，枚举
 @return image
 */
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor borderLineJoin:(CGLineJoin)borderLineJoin;




@end

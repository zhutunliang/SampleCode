//
//  UIImage+SGAddRoundCorner.m
//  ImageCorner
//
//  Created by hong on 2018/7/29.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "UIImage+SGAddRoundCorner.h"
#import <SDWebImage/SDImageCache.h>

static NSString *getImageKey(CGFloat cornerRadius,SGRectCorner rectCorner)
{
    return [NSString stringWithFormat:@"%f-%lu",cornerRadius,(unsigned long)rectCorner];
    
}

static UIImage *queryImageFromCache(CGFloat cornerRadius,SGRectCorner rectCorner)
{
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSString *imageKey = getImageKey(cornerRadius, rectCorner);
    UIImage *image = [cache imageFromCacheForKey:imageKey];
    return image;
}

static void storeImage(UIImage *image,CGFloat cornerRadius,SGRectCorner rectCorner)
{
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSString *imageKey = getImageKey(cornerRadius, rectCorner);
    [cache storeImage:image forKey:imageKey completion:nil];
}

@implementation UIImage (SGAddRoundCorner)

+ (UIImage *)imageWithCornerRadius:(CGFloat)cornerRadius rectCorner:(SGRectCorner)rectCorner color:(UIColor *)color
{
    // 10-0
    UIImage *cachedImage = queryImageFromCache(cornerRadius, rectCorner);
    if (cachedImage) {
        return cachedImage;
    }
    CGSize size = CGSizeMake(cornerRadius, cornerRadius);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0);
    [color set]; //设置线条颜色
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 0.0;
    
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    switch (rectCorner) {
        case SGRectCornerTopLeft:
            [path moveToPoint:CGPointMake(cornerRadius, 0)];//起点
            [path addLineToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(0, cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(cornerRadius, 0) controlPoint:CGPointMake(0, 0)];
            break;
        case SGRectCornerTopRight:
            [path moveToPoint:CGPointMake(0, 0)];//起点
            [path addLineToPoint:CGPointMake(cornerRadius, 0)];
            [path addLineToPoint:CGPointMake(cornerRadius, cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(cornerRadius, 0)];
            break;
        case SGRectCornerBottomLeft:
            [path moveToPoint:CGPointMake(0, 0)];//起点
            [path addLineToPoint:CGPointMake(0, cornerRadius)];
            [path addLineToPoint:CGPointMake(cornerRadius, cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(0, cornerRadius)];
            break;
        case SGRectCornerBottomRight:
            [path moveToPoint:CGPointMake(0, cornerRadius)];//起点
            [path addLineToPoint:CGPointMake(cornerRadius, cornerRadius)];
            [path addLineToPoint:CGPointMake(cornerRadius, 0)];
            [path addQuadCurveToPoint:CGPointMake(0, cornerRadius) controlPoint:CGPointMake(cornerRadius, cornerRadius)];
            break;
        default:
            break;
    }
    [path fill];//颜色填充
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 保存
    storeImage(resultImage, cornerRadius, rectCorner);
    return resultImage;
}


@end

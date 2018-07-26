//
//  UIImage+SGAddRoundedCorner.m
//  SGImageAdd
//
//  Created by nemo on 2018/7/26.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "UIImage+SGAddRoundedCorner.h"
#import <YYCache/YYCache.h>

#define MASKImagePath @"sg_maskImage"

static NSString *createMaskImageKey(CGSize size,CGFloat cornerRadisu)
{
    //    (200,200) (20)
    CGFloat width = size.width;
    CGFloat height = size.height;
    NSString *imageKey = [NSString stringWithFormat:@"%f-%f-%f",width,height,cornerRadisu];
    return imageKey;
}


@implementation UIImage (SGAddRoundedCorner)

+ (UIImage *)maskRoundCornerRadiusImageWithCorlor:(UIColor *)color CornerRadius:(CGFloat)radius size:(CGSize)size
{
    //    SDImageCache *cache = [SDImageCache sharedImageCache];
    //    NSString *maskImageKey = createMaskImageKey(size, radius);
    //    UIImage *image = [cache imageFromCacheForKey:maskImageKey];
    //    if (!image) {
    //        UIImage *maskImage = [UIImage xw_maskRoundCornerRadiusImageWithColor:color cornerRadii:CGSizeMake(radius, radius) size:size corners:UIRectCornerAllCorners borderColor:[UIColor clearColor] borderWidth:0];
    //        [cache storeImage:maskImage forKey:maskImageKey completion:nil];
    //        image = maskImage;
    //    }
    //    return image;
    
    static YYCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[YYCache alloc]initWithName:MASKImagePath];
    });
    NSString *maskImageKey = createMaskImageKey(size, radius);
    // 判断缓存是否存在
    UIImage *image = (UIImage *)[cache objectForKey:maskImageKey];
    if (!image) {
        UIImage *maskImage = [UIImage maskRoundCornerRadiusImageWithColor:color cornerRadii:CGSizeMake(radius, radius) size:size corners:UIRectCornerAllCorners borderColor:[UIColor clearColor] borderWidth:0];
        [cache setObject:maskImage forKey:maskImageKey];
        image = maskImage;
    }
    return image;
}


+ (UIImage *)maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    return [UIImage imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}

+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

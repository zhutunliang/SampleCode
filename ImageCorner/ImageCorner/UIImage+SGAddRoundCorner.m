//
//  UIImage+SGAddRoundCorner.m
//  ImageCorner
//
//  Created by hong on 2018/7/29.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "UIImage+SGAddRoundCorner.h"
#import <SDWebImage/SDImageCache.h>

//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

@implementation UIImage (Rotate)

- (void)imageRotatedByRadians:(CGFloat)radians completeBlock:(DrawCompleteBlock)completeBlock
{
    // calculate the size of the rotated view's containing box for our drawing space
        UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
        CGAffineTransform t = CGAffineTransformMakeRotation(radians);
        rotatedViewBox.transform = t;
       CGSize rotatedSize = rotatedViewBox.frame.size;

       dispatch_async(dispatch_get_current_queue(), ^{
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize);
        CGContextRef bitmap = UIGraphicsGetCurrentContext();
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
        
        //   // Rotate the image context
        CGContextRotateCTM(bitmap, radians);
        
        // Now, draw the rotated/scaled image into the context
        CGContextScaleCTM(bitmap, 1.0, -1.0);
        CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock(newImage);
        });
    });
    
}


@end


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

// 异步 topLeft
+ (void)drawerTopLeftImageCornerWithRadius:(CGFloat)cornerRadius color:(UIColor *)color completeBlock:(DrawCompleteBlock)completeBlock
{
        // 10-0
        UIImage *cachedImage = queryImageFromCache(cornerRadius, SGRectCornerTopLeft);
        if (cachedImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock(cachedImage);
            });
        } else {
            CGSize size = CGSizeMake(cornerRadius, cornerRadius);
            UIGraphicsBeginImageContextWithOptions(size, NO, 0);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, 0);
            [color set]; //设置线条颜色
            
            UIBezierPath* path = [UIBezierPath bezierPath];
            path.lineWidth = 0.0;
            
            path.lineCapStyle = kCGLineCapRound; //线条拐角
            path.lineJoinStyle = kCGLineJoinRound; //终点处理
            
            [path moveToPoint:CGPointMake(cornerRadius, 0)];//起点
            [path addLineToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(0, cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(cornerRadius, 0) controlPoint:CGPointMake(0, 0)];
            
            [path fill];//颜色填充
            
            UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 保存
            storeImage(resultImage, cornerRadius, SGRectCornerTopLeft);
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock(resultImage);
            });
        }
    
}

+ (void)drawerOtherImageCornerWithRadius:(CGFloat)cornerRadius rectCorner:(SGRectCorner)rectCorner color:(UIColor *)color completeBlock:(DrawCompleteBlock)completeBlock
{
    UIImage *cachedImage = queryImageFromCache(cornerRadius, rectCorner);
    if (cachedImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock(cachedImage);
        });
    } else {
        [UIImage drawerTopLeftImageCornerWithRadius:cornerRadius color:color completeBlock:^(UIImage *image) {
            if (rectCorner == SGRectCornerTopRight) {
                [image imageRotatedByRadians:M_PI/2 completeBlock:^(UIImage *image) {
                    storeImage(image, cornerRadius, rectCorner);
                    completeBlock(image);
                }];
            } else if (rectCorner == SGRectCornerBottomLeft) {
                [image imageRotatedByRadians:-M_PI/2 completeBlock:^(UIImage *image) {
                    storeImage(image, cornerRadius, rectCorner);
                    completeBlock(image);
                }];
            } else  if (rectCorner == SGRectCornerBottomRight){
                [image imageRotatedByRadians:-M_PI completeBlock:^(UIImage *image) {
                    storeImage(image, cornerRadius, rectCorner);
                    completeBlock(image);
                }];
            }
        }];
    }
}




//+ (void)imageWithCornerRadius:(CGFloat)cornerRadius rectCorner:(SGRectCorner)rectCorner color:(UIColor *)color completeBlock:(DrawCompleteBlock)completeBlock
//{
//    if (rectCorner == SGRectCornerTopLeft) {
//        [UIImage drawerTopLeftImageCornerWithRadius:cornerRadius color:color completeBlock:^(UIImage *image) {
//            completeBlock(image);
//        }];
//    } else  {
//        [UIImage drawerOtherImageCornerWithRadius:cornerRadius rectCorner:rectCorner color:color completeBlock:^(UIImage *image) {
//            completeBlock(image);
//        }];
//    }
//}



+ (void)imageWithCornerRadius:(CGFloat)cornerRadius rectCorner:(SGRectCorner)rectCorner color:(UIColor *)color completeBlock:(DrawCompleteBlock)completeBlock;
{
        // 10-0
        UIImage *cachedImage = queryImageFromCache(cornerRadius, rectCorner);
        if (cachedImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock(cachedImage);
            });
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock(resultImage);
                });
            });
}
}

@end

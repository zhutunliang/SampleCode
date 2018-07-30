//
//  UIImageView+SGAddRoundCorner.m
//  ImageCorner
//
//  Created by hong on 2018/7/29.
//  Copyright © 2018年 hong. All rights reserved.
//

#import "UIImageView+SGAddRoundCorner.h"
#import "UIImage+SGAddRoundCorner.h"

@implementation UIImageView (SGAddRoundCorner)

- (void)addRoundedCornerWithRadius:(CGFloat)cornerRadius size:(CGSize)size color:(UIColor *)color
{
    
    UIImage *leftTopImage = [UIImage imageWithCornerRadius:cornerRadius rectCorner:SGRectCornerTopLeft color:color];
    UIImageView *leftTopImgeView = [[UIImageView alloc]initWithImage:leftTopImage];
    leftTopImgeView.frame = CGRectMake(0, 0, cornerRadius, cornerRadius);
    [self addSubview:leftTopImgeView];
    
    
    UIImage *topRightImage = [UIImage imageWithCornerRadius:cornerRadius rectCorner:SGRectCornerTopRight color:color];
    UIImageView *topRightImageView = [[UIImageView alloc]initWithImage:topRightImage];
    topRightImageView.frame = CGRectMake(size.width - cornerRadius, 0, cornerRadius, cornerRadius);
    [self addSubview:topRightImageView];
    
    UIImage *bottomLeftImage = [UIImage imageWithCornerRadius:cornerRadius rectCorner:SGRectCornerBottomLeft color:color];
    UIImageView *bottomLeftImageView = [[UIImageView alloc]initWithImage:bottomLeftImage];
    bottomLeftImageView.frame = CGRectMake(0, size.height - cornerRadius, cornerRadius, cornerRadius);
    [self addSubview:bottomLeftImageView];

    UIImage *bottomRightImage = [UIImage imageWithCornerRadius:cornerRadius rectCorner:SGRectCornerBottomRight color:color];
    UIImageView *bottomRightImageView = [[UIImageView alloc]initWithImage:bottomRightImage];
    bottomRightImageView.frame = CGRectMake(size.width - cornerRadius, size.height - cornerRadius, cornerRadius, cornerRadius);
    [self addSubview:bottomRightImageView];
    
}



@end

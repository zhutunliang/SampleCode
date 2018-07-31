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

- (void)addRoundedCornerWithRadius:(CGFloat)cornerRadius size:(CGSize)size color:(UIColor *)color completeBlock:(roundedCompleteBlock)completeBlock
{
    [UIImage imageWithCornerRadius:cornerRadius rectCorner:SGRectCornerTopLeft color:color completeBlock:^(UIImage *image) {
        UIImageView *topLeftImgeView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:topLeftImgeView];
        
        [topLeftImgeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(cornerRadius, cornerRadius));
        }];
        
    }];
    
    [UIImage imageWithCornerRadius:cornerRadius rectCorner:SGRectCornerTopRight color:color completeBlock:^(UIImage *image){
        UIImageView *topRightImageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:topRightImageView];
        
        [topRightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(cornerRadius, cornerRadius));
        }];
        
    }];
    
    [UIImage imageWithCornerRadius:cornerRadius rectCorner:SGRectCornerBottomLeft color:color completeBlock:^(UIImage *image) {
        UIImageView *bottomLeftImageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:bottomLeftImageView];
        
        [bottomLeftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(cornerRadius, cornerRadius));
        }];
    }];
    
    [UIImage imageWithCornerRadius:cornerRadius rectCorner:SGRectCornerBottomRight color:color completeBlock:^(UIImage *image) {
        UIImageView *bottomRightImageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:bottomRightImageView];
        [bottomRightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(cornerRadius, cornerRadius));
        }];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        completeBlock();
    });
    
}



@end

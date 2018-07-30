//
//  UIImageView+SGAddRoundCorner.h
//  ImageCorner
//
//  Created by hong on 2018/7/29.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SGAddRoundCorner)

- (void)addRoundedCornerWithRadius:(CGFloat)cornerRadius size:(CGSize)size color:(UIColor *)color;

@end

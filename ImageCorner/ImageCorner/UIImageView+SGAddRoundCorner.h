//
//  UIImageView+SGAddRoundCorner.h
//  ImageCorner
//
//  Created by hong on 2018/7/29.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^roundedCompleteBlock)(void);

@interface UIImageView (SGAddRoundCorner)

/*
 封装此方法需要注意的点：
 1.画图，耗时操作放在异步线程。
 2.以block的形式回调回去，方便图片下一步操作，比如从url加载图片
 3.从A旋转得到B的方式，也是通过CG画图，不比path画图优秀，暂时放弃。
 */

/** 异步绘制 */
- (void)addRoundedCornerWithRadius:(CGFloat)cornerRadius size:(CGSize)size color:(UIColor *)color completeBlock:(roundedCompleteBlock)completeBlock;

@end

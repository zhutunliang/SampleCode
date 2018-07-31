//
//  ViewController.m
//  SGImageAdd
//
//  Created by nemo on 2018/7/25.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+SGAddRoundCorner.h"
#import "UIImageView+SGAddRoundCorner.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test];
    
    CFTimeInterval start = CACurrentMediaTime();
    CFTimeInterval end = CACurrentMediaTime();
    CFTimeInterval elapsed = (end - start) * 1000;
    NSLog(@"111%f",elapsed);
}

- (void)test
{
    NSString *imagePath = @"http://pic1.win4000.com/wallpaper/d/55f6412666825.jpg";
    UIImageView *catView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    catView.image = [UIImage imageNamed:@"1.jpg"];
    __weak UIImageView *weakCatView = catView;
    [catView addRoundedCornerWithRadius:20 size:CGSizeMake(100, 100) color:[UIColor whiteColor] completeBlock:^{
        [weakCatView sd_setImageWithURL:[NSURL URLWithString:imagePath] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            NSLog(@"hello world 结束了==");
        }];
    }];
    [self.view addSubview:catView];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

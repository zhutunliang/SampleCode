//
//  ViewController.m
//  SGImageAdd
//
//  Created by nemo on 2018/7/25.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+SGAddRoundedCorner.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createCornerImage];
    
}

- (void)createCornerImage
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:imageView];
    UIImage *demoImage = [UIImage imageNamed:@"demo.jpg"];
    imageView.image = demoImage;
    
    UIImage *cornerImage = [UIImage maskRoundCornerRadiusImageWithCorlor:[UIColor whiteColor] CornerRadius:30 size:CGSizeMake(200, 200)];
    UIImageView *maskImageView = [[UIImageView alloc]initWithImage:cornerImage];    
    [imageView addSubview:maskImageView];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

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
    

//    UIImage *cornerImage2 = [UIImage maskRoundCornerRadiusImageWithCorlor:[UIColor redColor] CornerRadius:20 size:CGSizeMake(200, 200)];
//    UIImageView *maskImageView2 = [[UIImageView alloc]initWithImage:cornerImage2];
//    maskImageView2.frame = CGRectMake(0, 0, 200, 200);
//    [imageView2 addSubview:maskImageView2];
//
//
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 350, 100, 100)];
////    [self.view addSubview:imageView];
//    UIImage *demoImage = [UIImage imageNamed:@"demo.jpg"];
//    imageView.image = demoImage;
//
//    UIImage *cornerImage = [UIImage maskRoundCornerRadiusImageWithCorlor:[UIColor whiteColor] CornerRadius:10 size:CGSizeMake(100, 100)];
//    UIImageView *maskImageView = [[UIImageView alloc]initWithImage:cornerImage];
//    maskImageView.frame = CGRectMake(0, 0, 100, 100);
//    [imageView addSubview:maskImageView];
    
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 50, 200, 200)];
    [self.view addSubview:imageView2];
    UIImage *demoImage2 = [UIImage imageNamed:@"demo.jpg"];
    imageView2.image = demoImage2;
    
    
    UIImage *image = [UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(200, 200) cornerRadiusArray:@[@10,@10,@10,@10]];
    NSLog(@"%@",image);
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(100, 280, 200, 200);
    [self.view addSubview:imageView];
    
    
    
    // 上
    UIImage *image4 = [UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20) cornerRadiusArray:@[@10,@0,@0,@0]];
    NSLog(@"%@",image4);
    UIImageView *image4View = [[UIImageView alloc]initWithImage:image4];
    image4View.frame = CGRectMake(100, 500, 20, 20);
    [self.view addSubview:image4View];
    
    // 下
    UIImage *image5 = [UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(50, 50) cornerRadiusArray:@[@0,@10,@0,@0]];
    NSLog(@"%@",image5);
    UIImageView *image5View = [[UIImageView alloc]initWithImage:image5];
    image5View.frame = CGRectMake(100, 600, 50, 50);
    [self.view addSubview:image5View];

    // 右
    UIImage *image3 = [UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20) cornerRadiusArray:@[@0,@0,@10,@0]];
    NSLog(@"%@",image3);
    UIImageView *image3View = [[UIImageView alloc]initWithImage:image3];
    image3View.frame = CGRectMake(200, 600, 20, 20);
    [self.view addSubview:image3View];
    
    // 右上
    UIImage *image6 = [UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20) cornerRadiusArray:@[@0,@0,@0,@10]];
    NSLog(@"%@",image6);
    UIImageView *image6View = [[UIImageView alloc]initWithImage:image6];
    image6View.frame = CGRectMake(200, 500, 20, 20);
    [self.view addSubview:image6View];
    
//    [imageView2 addSubview:image4View];
//    image4View.frame = CGRectMake(0, 0, 20, 20);
    
//    [imageView2 addSubview:image6View];
//    image6View.frame = CGRectMake(200-20, 0, 20, 20);
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

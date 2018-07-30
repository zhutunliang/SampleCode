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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test];
}

- (void)test
{
    UIImageView *catView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    catView.image = [UIImage imageNamed:@"1.jpg"];
    [catView addRoundedCornerWithRadius:20 size:CGSizeMake(100, 100) color:[UIColor whiteColor]];
    [self.view addSubview:catView];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

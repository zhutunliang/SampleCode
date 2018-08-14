//
//  ViewController.m
//  test813
//
//  Created by nemo on 2018/8/13.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "ViewController.h"
#import <Beethoven/Beethoven-Swift.h>
@interface ViewController () <PitchEngineDelegate>
@property (nonatomic ,strong) PitchEngine *pitchEgine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pitchEgine = [[PitchEngine alloc]initWithDelegate:self];
    //    self.pitchEgine.active
    [self test];
    
    // ..
    
    // Develop_0814
    
    // Develop-081555
}


- (void)test
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startEngine) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startEngine
{
    [self.pitchEgine start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pitchEngine:(PitchEngine * _Nonnull)pitchEngine frequency:(float)frequency {
    NSLog(@"频率频率%f",frequency);
}


@end

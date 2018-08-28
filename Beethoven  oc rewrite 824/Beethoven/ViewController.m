//
//  ViewController.m
//  Beethoven
//
//  Created by nemo on 2018/8/13.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PitchEngine.h"


@interface ViewController () <PitchEngineDelegate>

@property (nonatomic ,strong) PitchEngine *pitchEngine;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick
{
    self.pitchEngine = [[PitchEngine alloc]initWithDelegate:self];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    switch (audioSession.recordPermission) {
        case AVAudioSessionRecordPermissionGranted:
            [self start];
            break;
        case AVAudioSessionRecordPermissionDenied:
            dispatch_async(dispatch_get_main_queue(), ^{
                NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication]openURL:settingURL options:@{} completionHandler:nil];
            });
            break;
        case AVAudioSessionRecordPermissionUndetermined:
            [[AVAudioSession sharedInstance]requestRecordPermission:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self start];
                    });
                }
            }];
            break;
    }
    
}

- (void)start
{
    [self.pitchEngine start];
}



#pragma mark - PitchEngineDelegate

- (void)pitchEngine:(PitchEngine *)pitchEngine frequency:(float)frequency
{
    NSLog(@"%f",frequency);
}

- (void)pitchEngine:(PitchEngine *)pitchEngine didReceiveError:(NSError *)error
{
    
}

- (void)pitchEngineWentBelowLevelThreshold:(PitchEngine *)pitchEngine
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

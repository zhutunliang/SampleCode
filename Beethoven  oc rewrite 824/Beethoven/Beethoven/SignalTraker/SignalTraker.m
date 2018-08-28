//
//  SignalTraker.m
//  Beethoven
//
//  Created by nemo on 2018/8/24.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "SignalTraker.h"

@interface SignalTraker ()

@property (nonatomic ,assign) float levelThreshold;
@property (nonatomic ,assign) float averageLevel;
@property (nonatomic ,assign) AVAudioFrameCount bufferSize;

@property (nonatomic ,strong) AVCaptureAudioChannel *audioChannel;
@property (nonatomic ,strong) AVCaptureSession *captureSession ;
@property (nonatomic ,strong) AVAudioEngine *audioEngine;
@property (nonatomic ,strong) AVAudioSession *session;

@property (nonatomic ,assign) AVAudioNodeBus bus;

@end

@implementation SignalTraker

- (instancetype)initWithBufferSize:(AVAudioFrameCount)bufferSize
{
    self = [super init];
    self.bufferSize = bufferSize;
    self.session = [AVAudioSession sharedInstance];
    [self setUpAudio];
    self.levelThreshold = -30;
    return self;
}


#pragma mark - Public

- (void)start
{
    NSError *error = nil;
    [self.session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&error];
    [self.session setActive:YES error:&error];
    AVAudioSessionRouteDescription *currentRoute = self.session.currentRoute;
    NSArray *outputArray = currentRoute.outputs;
    if (outputArray.count != 0) {
        for (AVAudioSessionPortDescription *description in outputArray) {
            if (description.portType != AVAudioSessionPortHeadphones) {
                [self.session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
            } else {
                [self.session overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:&error];
            }
        }
    }
    self.audioEngine = [[AVAudioEngine alloc]init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    AVAudioFormat *format = [inputNode outputFormatForBus:self.bus];
    
    [inputNode installTapOnBus:self.bus bufferSize:self.bufferSize format:format block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        float averageLevel = self.averageLevel;
        float levelThreshold = self.levelThreshold;
        
        if (averageLevel > levelThreshold) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.delegate?[self.delegate signalTraker:self didReceiveBuffer:buffer atTime:when]:nil;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.delegate?[self.delegate signalTrakerWentBelowLevelThreshold:self]:nil;
            });
        }
    }];
    
    [self.audioEngine startAndReturnError:&error];
    [self.captureSession startRunning];
    if (self.captureSession.running) {
        NSLog(@"success");
    } else {
        NSError *error = [NSError errorWithDomain:@"com.inputSignal" code:-1 userInfo:@{@"error":@"inputNodeMissing"}];
        self.delegate?[self.delegate signalTraker:self didReceiveError:error]:nil;
    }
    
}

- (void)stop
{
    if (self.audioEngine) {
        [self.audioEngine stop];
        [self.audioEngine reset];
        self.audioEngine = nil;
        [self.captureSession stopRunning];
    }
}

#pragma mark - Private

- (void)setUpAudio
{
    NSError *error = nil;
    self.captureSession = [[AVCaptureSession alloc]init];
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput *audioCaptureInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error];
    [self.captureSession addInput:audioCaptureInput];
    
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc]init];
    [self.captureSession addOutput:audioOutput];
    
    AVCaptureConnection *connection = audioOutput.connections[0];
    self.audioChannel = connection.audioChannels[0];
}

#pragma mark - Getter

- (float)averageLevel
{
    return self.audioChannel.averagePowerLevel;
}

@end

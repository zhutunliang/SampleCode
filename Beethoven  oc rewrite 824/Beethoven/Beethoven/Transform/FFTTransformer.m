//
//  FFTTransformer.m
//  Beethoven
//
//  Created by nemo on 2018/8/13.
//  Copyright © 2018年 搜狗. All rights reserved.
//

#import "FFTTransformer.h"
#import <Accelerate/Accelerate.h>

float* sqrtq(float* x,int count)
{
    float *results = (float *)malloc(sizeof(float)* count);
    vvsqrtf(results, x, &count);
    return results;
}
NSArray *turnToOCObj(float *x,int count)
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        NSNumber *tmp = [NSNumber numberWithFloat:x[i]];
        [array addObject:tmp];
    }
    
    return [array copy];
}

@implementation FFTTransformer

+ (Buffer *)transformFormPCMBuffer:(AVAudioPCMBuffer *)pcmBuffer
{
    
    AVAudioFrameCount frameCount = pcmBuffer.frameLength;
    int log2n = (int) round(log2((double)frameCount));
    int bufferSizePOT = (int)(1 << log2n);
    int inputCount = bufferSizePOT / 2;
    FFTSetup fftSetup = vDSP_create_fftsetup(log2n, kFFTRadix2);
    
    COMPLEX_SPLIT output;
    float *realp = (float *)malloc(sizeof(float)*inputCount);
    float *imapg = (float *)malloc(sizeof(float)*inputCount);
    output.realp = realp;
    output.imagp = imapg;
    
    
    NSInteger windowSize = bufferSizePOT;
    float *transferBuffer = (float *)malloc(sizeof(float)*windowSize);
    float *window = (float *)malloc(sizeof(float)*windowSize);

    vDSP_hann_window(window, (vDSP_Length)windowSize, vDSP_HANN_NORM);
    
    // c[i]=a[i]*b[i],i=0~1024
    vDSP_vmul(pcmBuffer.floatChannelData[0], 1, window, 1, transferBuffer, 1, (vDSP_Length)windowSize);
    
    vDSP_ctoz((DSPComplex*)transferBuffer, 2, &output, 1, (vDSP_Length)inputCount);
    
    vDSP_fft_zrip(fftSetup, &output, 1, log2n, (FFTDirection)FFT_FORWARD);
    float *magnitudes = (float *)malloc(sizeof(float)*inputCount);
    vDSP_zvmags(&output, 1, magnitudes, 1, (vDSP_Length)inputCount);
    
    float *normalizedMagnitudes = (float *)malloc(sizeof(float)*inputCount);
    float *tmpB = (float *)malloc(sizeof(float)*1);
    tmpB[0] = 2.0/(float)inputCount;
    vDSP_vsmul(sqrtq(magnitudes, inputCount), 1, tmpB, normalizedMagnitudes, 1, (vDSP_Length)inputCount);
    
    NSArray *array = turnToOCObj(normalizedMagnitudes, inputCount);
    Buffer *buffer = [[Buffer alloc]initWithElements:array];
    
    vDSP_destroy_fftsetup(fftSetup);
    
    return buffer;
    
}





@end

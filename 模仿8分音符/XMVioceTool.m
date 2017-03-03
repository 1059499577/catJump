//
//  XMVioceTool.m
//  模仿8分音符
//
//  Created by RenXiangDong on 17/3/1.
//  Copyright © 2017年 RenXiangDong. All rights reserved.
//


#import "XMVioceTool.h"
#import <AVFoundation/AVFoundation.h>
#import "XMMeterTool.h"

@interface XMVioceTool ()
@property (nonatomic, strong) AVAudioRecorder *recoder;
@property (nonatomic, retain) CADisplayLink *link;
@property (nonatomic, strong) NSURL *tempUrl;
@property (nonatomic,retain) XMMeterTool *meterTool;
@property (nonatomic, assign) BOOL isJumping;
@end

@implementation XMVioceTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *setCategoryError = nil;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&setCategoryError];
        [self.recoder prepareToRecord];
    }
    return self;
}

- (void)startRecord {
    [self.recoder record];
    _link=[CADisplayLink displayLinkWithTarget:self selector:@selector(getWave)];
    _link.frameInterval = 6;
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)getWave {
    [self.recoder updateMeters];
    float average =  [_recoder averagePowerForChannel:0];
    float peak = [_recoder peakPowerForChannel:0];
    float peakLevel = [self.meterTool valueForPower:peak];
//    NSLog(@"平均%f -- 峰值%f -- 峰值呀%f",average,peak,peakLevel);
    if (peakLevel > 0.5 && self.isJumping == NO) {
        self.isJumping = YES;
        [self performSelector:@selector(finishJump) withObject:nil afterDelay:2 ];
        [self.delegate jumpWithHeight:peakLevel*20];
    } else if (peakLevel > 0.1) {
        [self.delegate moveWithSpeed:peakLevel*30];
    }
}

- (void)finishJump {
    self.isJumping = NO;
}

- (void)stopRecord {
    
}


- (AVAudioRecorder *)recoder {
    if (!_recoder) {
        NSDictionary *setting = @{
                                  AVFormatIDKey : @(kAudioFormatAppleIMA4),
                                  AVSampleRateKey : @44100.0f,
                                  AVNumberOfChannelsKey : @1,
                                  AVEncoderBitDepthHintKey : @16,
                                  AVEncoderAudioQualityKey : @(AVAudioQualityMedium)
                                  };
        _recoder = [[AVAudioRecorder alloc] initWithURL:self.tempUrl settings:setting error:nil];
        _recoder.meteringEnabled = YES;
    }
    return _recoder;
}

- (NSURL *)tempUrl {
    if (!_tempUrl) {
        NSString *tmpFile = NSTemporaryDirectory();
        NSString *tmpFilePath = [tmpFile stringByAppendingPathComponent:@"temp.caf"];
        _tempUrl = [NSURL fileURLWithPath:tmpFilePath];
    }
    return _tempUrl;
}

- (XMMeterTool *)meterTool {
    if (!_meterTool) {
        _meterTool = [[XMMeterTool alloc] init];
    }
    return _meterTool;
}

@end

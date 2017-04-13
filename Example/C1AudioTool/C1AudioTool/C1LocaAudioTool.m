//
//  C1LocaAudioTool.m
//  C1AudioTool
//
//  Created by 李磊 on 2017/4/13.
//  Copyright © 2017年 sowcjhone00@sina.com. All rights reserved.
//

#import "C1LocaAudioTool.h"
#import <AVFoundation/AVFoundation.h>
@interface C1LocaAudioTool ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *currentPlayer;
@property (nonatomic, copy) AudioFinishedBlock completionHandler;

@end

@implementation C1LocaAudioTool

- (instancetype)playAudioWithAudioPath:(NSString *)audioPath completionHandler:(AudioFinishedBlock)completionHandler{
    return [self initWithAudioPath:audioPath completionHandler:completionHandler];
}
- (instancetype)initWithAudioPath:(NSString *)audioPath completionHandler:(AudioFinishedBlock)completionHandler{
    self = [super init];
    if (self) {
        self.currentPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:audioPath] error:nil];
        self.currentPlayer.delegate = self;
        self.completionHandler =  [completionHandler copy];
        [self.currentPlayer prepareToPlay];
    }
    return self;
}

- (void)play{
    if (self.currentPlayer.isPlaying) {
        return;
    }else{
        [self.currentPlayer play];
    }
}
- (BOOL)isPlaying{
    return self.currentPlayer.isPlaying;
}

- (void)pause{
    if (self.currentPlayer.isPlaying) {
        [self.currentPlayer pause];
    }else{
    }
}
- (BOOL)isPaused{
    return !self.currentPlayer.isPlaying;
}
- (void)stop{
    if (self.currentPlayer.isPlaying) {
        [self.currentPlayer stop];
    }
}
- (BOOL)isWaiting{
    return [self.currentPlayer prepareToPlay];
}

- (void)SeekToTime:(double)newSeekTime{
    [self.currentPlayer setCurrentTime:newSeekTime];
}

- (double)progress{
    return self.currentPlayer.currentTime;
}
- (double)duration{
    return self.currentPlayer.duration;
}

#pragma mark - AVAudioPlayerDelegate
/**
 *  音乐播放完成, 发送通知告诉外界
 *
 *  @param player 音乐播放器
 *  @param flag   是否完成
 */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CNotificationPlayFinish object:self.currentPlayer];
        if(self.completionHandler) self.completionHandler();
    }
}

@end

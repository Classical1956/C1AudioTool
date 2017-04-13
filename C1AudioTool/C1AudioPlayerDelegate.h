//
//  C1AudioPlayerDelegate.h
//  C1AudioTool
//
//  Created by 李磊 on 2017/4/13.
//  Copyright © 2017年 sowcjhone00@sina.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^AudioFinishedBlock)();

#define CNotificationPlayFinish @"NotificationPlayFinish"

@protocol C1AudioPlayerDelegate <NSObject>

- (void)play;
- (void)pause;
- (void)stop;
- (BOOL)isPlaying;
- (BOOL)isWaiting;
- (BOOL)isPaused;
- (void)SeekToTime:(double)newSeekTime;
- (instancetype)playAudioWithAudioPath:(NSString *)audioPath completionHandler:(AudioFinishedBlock)completionHandler;

@optional
@property (readonly) double progress;
@property (readonly) double duration;
- (instancetype)asyn_playAudioWithAudioPath:(NSString *)audioPath completionHandler:(AudioFinishedBlock)completionHandler;

/** audioStreamer 用*/
- (BOOL)isIdle;
- (double)calculatedBitRate;


@end

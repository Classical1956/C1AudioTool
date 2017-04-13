//
//  C1StreamerAudioTool.m
//  C1AudioTool
//
//  Created by 李磊 on 2017/4/13.
//  Copyright © 2017年 sowcjhone00@sina.com. All rights reserved.
//

#import "C1StreamerAudioTool.h"
#import <AudioStreamer/AudioStreamer.h>

@interface C1StreamerAudioTool ()
@property (nonatomic, strong) AudioStreamer *streamer;
@end

@implementation C1StreamerAudioTool

- (instancetype)playAudioWithAudioPath:(NSString *)audioPath completionHandler:(AudioFinishedBlock)completionHandler{
    return [self initWithAudioPath:audioPath completionHandler:completionHandler];
}
- (instancetype)initWithAudioPath:(NSString *)audioPath completionHandler:(AudioFinishedBlock)completionHandler{
    self = [super init];
    if (self) {
        self.streamer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:audioPath]];
    }
    return self;
}

- (void)play{
    if (self.streamer.isPlaying) {
        return;
    }else{
        [self.streamer start];
    }
}
- (BOOL)isPlaying{
    return self.streamer.isPlaying;
}

- (void)pause{
    if (self.streamer.isPlaying) {
        [self.streamer pause];
    }else{
    }
}
- (BOOL)isPaused{
    return !self.streamer.isPaused;
}
- (void)stop{
    [self.streamer stop];
}
- (BOOL)isWaiting{
    return [self.streamer isWaiting];
}

- (void)SeekToTime:(double)newSeekTime{
    [self.streamer seekToTime:newSeekTime];
}

- (double)progress{
    return self.streamer.progress;
}
- (double)duration{
    return self.streamer.duration;
}
@end

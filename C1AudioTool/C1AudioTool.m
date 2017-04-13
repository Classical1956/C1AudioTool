//
//  C1AudioTool.m
//  Pods
//
//  Created by 李磊 on 2017/4/13.
//
//

#import "C1AudioTool.h"
#import "C1LocaAudioTool.h"
#import "C1StreamerAudioTool.h"
#import <AVFoundation/AVFoundation.h>

@interface C1AudioTool ()

@property (nonatomic, strong) id <C1AudioPlayerDelegate> audioTool;

@end

@implementation C1AudioTool
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static C1AudioTool *tool = nil;
    dispatch_once(&onceToken, ^{
        tool = [[C1AudioTool alloc] init];
        [tool backgroupPlay];
    });
    return tool;
}

- (instancetype)playAudioWithAudioPath:(NSString *)audioPath completionHandler:(AudioFinishedBlock)completionHandler{
    if (!audioPath) {
        return nil;
    }
    if ([audioPath hasPrefix:@"http"]) {
        NSString *urlstr = [audioPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        C1StreamerAudioTool *streamerTool = [[C1StreamerAudioTool alloc] playAudioWithAudioPath:urlstr completionHandler:completionHandler];
        self.audioTool = streamerTool;
    }else{
        C1LocaAudioTool *locatool = [[C1LocaAudioTool alloc] playAudioWithAudioPath:audioPath completionHandler:completionHandler];
        self.audioTool = locatool;
    }
    return self;
}

- (void)backgroupPlay{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 设置会话类别为后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    // 激活会话
    [session setActive:YES error:nil];
}

#pragma mark - C1AudioPlayerDelegate
- (void)play{
    [self.audioTool play];
}
- (void)pause{
    [self.audioTool pause];
}
- (void)stop{
    [self.audioTool stop];
}
- (BOOL)isPlaying{
    return [self.audioTool isPlaying];
}
- (BOOL)isWaiting{
    return [self.audioTool isWaiting];
}
- (BOOL)isPaused{
    return [self.audioTool isPaused];
}
- (void)SeekToTime:(double)newSeekTime{
    [self.audioTool SeekToTime:newSeekTime];
}

- (double)progress{
    return self.audioTool.progress;
}
- (double)duration{
    return self.audioTool.duration;
}

@end

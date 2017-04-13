//
//  C1ViewController.m
//  C1AudioTool
//
//  Created by sowcjhone00@sina.com on 04/13/2017.
//  Copyright (c) 2017 sowcjhone00@sina.com. All rights reserved.
//

#import "C1ViewController.h"
#import "C1AudioTool.h"

@interface C1ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *durtionLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic, strong) NSTimer *updateTimer;
@end

@implementation C1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"10405520" ofType:@"mp3"];
//    
//    [AUDIOTOOL playAudioWithAudioPath:@"http://xiaoyuandailu.com:8080/piecefile/699af46a-0b9b-4bec-854a-be453979317e_1.mp3" completionHandler:^{
//    }];
//    [AUDIOTOOL play];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapAction:)];
    self.slider.userInteractionEnabled = YES;
    [self.slider addGestureRecognizer:tap];
    
    [self preparePlayBtn];
    [self oncePlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - prepare

- (void)preparePlayBtn{
    [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [self.playBtn setTitle:@"暂停" forState:UIControlStateSelected];
}
- (void)oncePlay{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"10405520" ofType:@"mp3"];
//    NSString *path = @"http://xiaoyuandailu.com:8080/piecefile/699af46a-0b9b-4bec-854a-be453979317e_1.mp3";
    [AUDIOTOOL playAudioWithAudioPath:path completionHandler:^{
        [AUDIOTOOL SeekToTime:0];
        [self.updateTimer invalidate];
        self.updateTimer = nil;
        self.playBtn.selected = NO;
    }];
    [AUDIOTOOL play];
    
    [self updateTimer];
    self.playBtn.selected = YES;
    
    
    
}
#pragma mark - actions
- (IBAction)changePlayStatusAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        [self updateTimer];
        [AUDIOTOOL play];
    }else{
        
        [AUDIOTOOL pause];
        [self.updateTimer invalidate];
        self.updateTimer = nil;
    }
}

- (IBAction)sliderTouchDown:(UISlider *)sender {
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}
- (IBAction)sliderTouchUp:(UISlider *)sender {
    [self updateTimer];
    
    double currentTime = sender.value * AUDIOTOOL.duration;
    
    if (isnan(currentTime)) {
        return;
    }
    
    [AUDIOTOOL SeekToTime:currentTime];
    
}
- (IBAction)sliderValueChange:(UISlider *)sender {

    NSInteger currentTime = AUDIOTOOL.duration *sender.value;
    // 获取分钟数
    NSInteger min = currentTime / 60;
    // 获取秒数
    NSInteger sec = (NSInteger)currentTime % 60;
    // 返回计算后的数值
    NSString *sliderStr = [NSString stringWithFormat:@"%02zd:%02zd", min, sec];
    self.progressLabel.text = sliderStr;
}
- (void)sliderTapAction:(UITapGestureRecognizer *)tap{
    [self updateTimer];
    // 获取手指触摸的点
    CGPoint point = [tap locationInView:self.slider];
    
    // 计算触摸点在整个视图上的比例
    CGFloat scale = point.x / self.slider.frame.size.width;
    
    // 更改进度条的值
    self.slider.value = scale;
    
    NSInteger currentTime = AUDIOTOOL.duration *self.slider.value;
    // 获取分钟数
    NSInteger min = currentTime / 60;
    // 获取秒数
    NSInteger sec = (NSInteger)currentTime % 60;
    // 返回计算后的数值
    NSString *sliderStr = [NSString stringWithFormat:@"%02zd:%02zd", min, sec];
    self.progressLabel.text = sliderStr;
    [AUDIOTOOL SeekToTime:currentTime];

}
- (void)updateTimeUI{
    double scale = AUDIOTOOL.progress/AUDIOTOOL.duration;
    if (isnan(scale)) {
        return;
    }
    self.slider.value = scale;
    
    NSInteger currentTime = AUDIOTOOL.duration *self.slider.value;
    // 获取分钟数
    NSInteger min = currentTime / 60;
    // 获取秒数
    NSInteger sec = (NSInteger)currentTime % 60;
    // 返回计算后的数值
    NSString *sliderStr = [NSString stringWithFormat:@"%02zd:%02zd", min, sec];
    self.progressLabel.text = sliderStr;
    
    self.playBtn.selected = AUDIOTOOL.isPlaying;
    
    min = AUDIOTOOL.duration / 60;
    // 获取秒数
    sec = (NSInteger)AUDIOTOOL.duration % 60;
    // 返回计算后的数值
    sliderStr = [NSString stringWithFormat:@"%02zd:%02zd", min, sec];
    self.durtionLabel.text = sliderStr;
}
#pragma mark - lazy loading

/**
 *  负责更新进度等信息的timer
 *
 *  @return timer
 */
- (NSTimer *)updateTimer
{
    if (!_updateTimer) {
        _updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimeUI) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_updateTimer forMode:NSRunLoopCommonModes];
    }
    return _updateTimer;
}

@end

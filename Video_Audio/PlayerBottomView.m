//
//  BottomView.m
//  Video_Audio
//
//  Created by 朱来飞 on 2018/3/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "PlayerBottomView.h"
#import "UIView+Layout.h"
#import "ProgressView.h"

@interface PlayerBottomView()

@property (nonatomic ,strong)UIButton * oprationBtn ;
@property (nonatomic ,strong)UILabel * timeLabel ;
@property (nonatomic ,strong)ProgressView * progressView ;
@property (nonatomic ,strong)CADisplayLink * displayLink ;

@end

@implementation PlayerBottomView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.alpha = 0.5;
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.oprationBtn];
        [self addSubview:self.timeLabel];
        [self addSubview:self.progressView];
        
        _oprationBtn.maker.topTo(self, 10).leftTo(self, 10).widthEqualTo(40).heightEqualTo(40);
        _timeLabel.maker.centerYTo(self, 0).rightTo(self, 10).heightEqualTo(20).widthGraterThan(44);
        _progressView.maker.leftTo(_oprationBtn, 10).rightTo(self, 200).centerYTo(self,0).heightEqualTo(40);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayDidEnd)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePlayProcess)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
    }
    return self ;
}
- (void)moviePlayDidEnd {
    
    [_playerView moviePlayDidEnd];
    [_displayLink invalidate];
    
    _oprationBtn.selected = YES ;
}
- (void)updatePlayProcess {
    
    NSTimeInterval current = CMTimeGetSeconds(_playerView.aPlayer.currentTime);
    NSTimeInterval total = CMTimeGetSeconds(_playerView.aPlayer.currentItem.duration);

    _progressView.currentPercent = current/total;
    _timeLabel.text = [NSString stringWithFormat:@"%@/%@", [self formatPlayTime:current], isnan(total)?@"00:00:00":[self formatPlayTime:total]];
}
- (void)playOrPauseAction:(UIButton *)btn {
    
    btn.selected = !btn.selected ;
    if (btn.selected) {
        [_playerView playerPause];
    }else{
        [_playerView playerPlay];
    }
}
- (void)sliderValueChanged:(ProgressView *)progressView{
    
    if (self.playerView) {
        [self.playerView moveToPercent:progressView.currentPercent];
    }
}
- (void)setPlayerView:(PlayerView *)playerView{
    _playerView = playerView ;
    
    __weak typeof (self) wSelf = self ;
    [_playerView setCacheProcess:^(CGFloat percent) {
        wSelf.progressView.cachePercent = percent;
    }];
}
- (NSString *)formatPlayTime:(NSTimeInterval)duration
{
    int minute = 0, hour = 0, secend = duration;
    minute = (secend % 3600)/60;
    hour = secend / 3600;
    secend = secend % 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, secend];
}
- (ProgressView *)progressView{
    if (!_progressView) {
        _progressView = [ProgressView new];
        [_progressView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _progressView ;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.text = @"00:00:00/00:00:00";
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}
- (UIButton *)oprationBtn{
    
    if (!_oprationBtn) {
        _oprationBtn = [[UIButton alloc]init];
        [_oprationBtn setImage:[UIImage imageNamed:@"pauseBtn"] forState:UIControlStateNormal];
        [_oprationBtn setImage:[UIImage imageNamed:@"playBtn"] forState:UIControlStateSelected];
        [_oprationBtn addTarget:self action:@selector(playOrPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oprationBtn;
}
- (void)dealloc {
    
    [_displayLink invalidate];
    _displayLink = nil ;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

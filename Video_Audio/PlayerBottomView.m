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
        
    }
    return self ;
}
- (void)playOrPauseAction:(UIButton *)btn {
    
    btn.selected = !btn.selected ;
    if (self.operation) {
        self.operation(btn.selected);
    }
}
- (void)sliderValueChanged:(ProgressView *)progressView{
    if (self.slider) {
        self.slider(progressView.currentPercent);
    }
}
- (void)setPlayerCachePercent:(CGFloat)playerCachePercent{
    _progressView.cachePercent = playerCachePercent;
}
- (void)setPlayerCurrentPercent:(CGFloat)playerCurrentPercent{
    _progressView.currentPercent = playerCurrentPercent ;
}
- (void)setTimeProcess:(NSString *)timeProcess{
    _timeLabel.text = timeProcess ;
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
@end

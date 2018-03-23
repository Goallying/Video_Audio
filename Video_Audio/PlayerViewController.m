//
//  PlayerViewController.m
//  Video_Audio
//
//  Created by 朱来飞 on 2018/3/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "PlayerViewController.h"
#import "PlayerView.h"
#import "UIView+Layout.h"
#import "PlayerTopView.h"
#import "PlayerBottomView.h"
@interface PlayerViewController ()
//@property (nonatomic ,strong) AVPlayer * player ;
//@property (nonatomic ,strong)AVPlayerLayer * playerLayer ;
@property (nonatomic ,strong)PlayerView * playerView ;
@property (nonatomic ,strong)PlayerTopView * topView ;
@property (nonatomic ,strong)PlayerBottomView * bottomView ;
@property (nonatomic ,strong)CADisplayLink * displayLink ;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.playerView];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    
    _topView.maker.topTo(self.view, 0).leftTo(self.view, 0).rightTo(self.view, 0).heightEqualTo(60);
    _bottomView.maker.leftTo(self.view, 0).rightTo(self.view, 0).bottomTo(self.view, 0).heightEqualTo(60);
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePlayProcess)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayDidEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
}
- (void)moviePlayDidEnd{
    [_displayLink invalidate];

}
- (void)play {
//为0时是暂停状态 ，iOS 10 之前和之后 代表的意思不同
//设置非0 值，AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate or AVPlayerTimeControlStatusPlaying
    if (_playerView.aPlayer.rate == 0) {
        [_playerView.aPlayer play];
    }
}
- (void)pause {
    if (_playerView.aPlayer.rate == 1) {
        [_playerView.aPlayer pause];
    }
}
//每秒更新bottomView UI。
- (void)updatePlayProcess {
    
    NSTimeInterval current = CMTimeGetSeconds(_playerView.aPlayer.currentTime);
    NSTimeInterval total = CMTimeGetSeconds(_playerView.aPlayer.currentItem.duration);
    
    _bottomView.playerCurrentPercent = current/total;
    _bottomView.timeProcess = [NSString stringWithFormat:@"%@/%@", [self formatPlayTime:current], isnan(total)?@"00:00:00":[self formatPlayTime:total]];
    
}
- (NSString *)formatPlayTime:(NSTimeInterval)duration
{
    int minute = 0, hour = 0, secend = duration;
    minute = (secend % 3600)/60;
    hour = secend / 3600;
    secend = secend % 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, secend];
}
- (PlayerBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [PlayerBottomView new];
        __weak typeof(self)wSelf = self ;
        [_bottomView setOperation:^(BOOL pause) {
            if (pause) {
                [wSelf pause];
            }else{
                [wSelf play];
            }
        }];
        
        [_bottomView setSlider:^(CGFloat percent) {
            if (_playerView.aPlayer.status == AVPlayerStatusReadyToPlay) {
                NSTimeInterval duration = percent * CMTimeGetSeconds(_playerView.aPlayer.currentItem.duration);
                CMTime seekTime = CMTimeMake(duration, 1);
                [wSelf.playerView.aPlayer seekToTime:seekTime completionHandler:^(BOOL finished) {
                    if (finished) {
                        NSLog(@"---- 跳转结束");
                    }
                }];
            }
        }];
    }
    return _bottomView ;
}
- (PlayerTopView *)topView{
    if (!_topView) {
        _topView = [[PlayerTopView alloc]init];
        __weak typeof(self) wSelf = self ;
        [_topView setGoBack:^{
            [wSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _topView;
}
- (PlayerView *)playerView{
    
    if (!_playerView) {
        _playerView = [[PlayerView alloc]initWithVideoURL:self.videoURL];
        _playerView.frame = self.view.bounds ;
        _playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        __weak typeof(self) wSelf = self ;
        [_playerView setPlayProcess:^(CGFloat percent) {
            wSelf.bottomView.playerCachePercent = percent;
        }];
    }
    return _playerView ;
}
// 横竖屏
- (BOOL)shouldAutorotate{
    return YES ;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape ;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight ;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent ;
}


@end

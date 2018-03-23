//
//  PlayerView.m
//  Video_Audio
//
//  Created by 朱来飞 on 2018/3/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "PlayerView.h"

@interface PlayerView()
@property (nonatomic ,strong)AVPlayer * player ;
@property (nonatomic ,strong)AVPlayerLayer * playerLayer ;
@property (nonatomic ,strong)NSURL * videoURL ;

@end

@implementation PlayerView

- (instancetype)initWithVideoURL:(NSURL *)url{
    if (self = [super init]) {
        
        _videoURL = url ;
        [self.layer addSublayer:self.playerLayer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayDidEnd)
                                               name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:nil];
    }
    return self ;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    AVPlayerItem * playerItem = (AVPlayerItem *)object ;
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        NSTimeInterval loadedTime = [self availableDurationWithplayerItem:playerItem];
        NSTimeInterval totalTime = CMTimeGetSeconds(playerItem.duration);
        if (self.playProcess) {
            self.playProcess(loadedTime/totalTime);
        }
    }else if ([keyPath isEqualToString:@"status"]){
        if (playerItem.status == AVPlayerStatusReadyToPlay) {
            [_player play];
        }else if (playerItem.status == AVPlayerStatusFailed){
            NSLog(@"------ 播放器准备播放失败");
        }else if (playerItem.status == AVPlayerStatusUnknown){
            NSLog(@"------ 播放器准备播放状态未知");
        }
    }
}
- (void)moviePlayDidEnd{
    [_player pause];
}

- (NSTimeInterval)availableDurationWithplayerItem:(AVPlayerItem *)playerItem
{
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);
    NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (AVPlayerLayer *)playerLayer{
    
    if (!_playerLayer) {
        
        AVPlayerItem * playerItem = [AVPlayerItem playerItemWithURL:self.videoURL];
        // 监听缓存时间 和 播放器状态
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
        // 专门负责播放视频
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        
        //展示视频播放
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.backgroundColor = [UIColor blackColor].CGColor;
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        _playerLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _playerLayer ;
}
- (void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    _playerLayer.frame = self.frame ;
}
- (AVPlayer *)aPlayer{
    return _player ;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    // 必须移除
    [_player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_player.currentItem removeObserver:self forKeyPath:@"status"];
    
    NSLog(@"PlayView dealloc");
}
@end

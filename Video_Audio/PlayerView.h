//
//  PlayerView.h
//  Video_Audio
//
//  Created by 朱来飞 on 2018/3/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView

@property (nonatomic ,strong ,readonly)AVPlayer * aPlayer;
@property (nonatomic ,copy)void (^cacheProcess)(CGFloat percent) ;
@property (nonatomic ,copy)void (^playEnd)(void) ;

- (instancetype)initWithVideoURL:(NSURL *)url ;
//test
- (void)moveToPercent:(CGFloat)percent ;
- (void)playerPause ;
- (void)playerPlay ;
- (void)moviePlayDidEnd ;

@end

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
@property (nonatomic ,copy)void (^playProcess)(CGFloat percent) ;
- (instancetype)initWithVideoURL:(NSURL *)url ;


@end

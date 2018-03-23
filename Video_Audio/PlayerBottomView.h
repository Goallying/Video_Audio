//
//  BottomView.h
//  Video_Audio
//
//  Created by 朱来飞 on 2018/3/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerView.h"
@interface PlayerBottomView : UIView
@property (nonatomic ,copy)void(^operation)(BOOL pause) ;
@property (nonatomic ,assign)CGFloat playerCachePercent ;
@property (nonatomic ,assign)CGFloat playerCurrentPercent ;
@property (nonatomic ,copy)NSString * timeProcess;
@property (nonatomic ,weak)PlayerView * playerView ;
@end

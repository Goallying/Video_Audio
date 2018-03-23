//
//  ProgressView.h
//  Video_Audio
//
//  Created by 朱来飞 on 2018/3/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIControl

@property (nonatomic ,assign)CGFloat max ;
@property (nonatomic ,assign)CGFloat min ;
@property (nonatomic ,assign)CGFloat currentValue ;

@property (nonatomic ,assign)CGFloat currentPercent ;
@property (nonatomic ,assign)CGFloat cachePercent ;

@property (nonatomic ,assign)CGFloat   lineWidth ;
@property (nonatomic ,strong)UIColor * lineColor ;//整条线颜色
@property (nonatomic ,strong)UIColor * progessLineColor ;// 进度线颜色。
@property (nonatomic ,strong)UIColor * cacheLineColor ;//缓存线颜色.
@property (nonatomic ,assign)CGFloat   circleRadius ;
@property (nonatomic ,strong)UIColor * circleColor ;

@end

//
//  PlayerTopView.m
//  Video_Audio
//
//  Created by 朱来飞 on 2018/3/23.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "PlayerTopView.h"
#import "UIView+Layout.h"

@interface PlayerTopView()
@property (nonatomic ,strong)UIButton * backBtn ;
@end

@implementation PlayerTopView

- (instancetype)init{
    if (self = [super init]) {
        
        self.alpha = 0.5 ;
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.backBtn];
        _backBtn.maker.leftTo(self, 10).topTo(self, 10).widthEqualTo(40).heightEqualTo(40);
    }
    return self ;
}
- (void)backClick {
    if (self.goBack) {
        self.goBack();
    }
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]init];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"gobackBtn"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn ;
}
@end

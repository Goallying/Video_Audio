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
@property (nonatomic ,strong)PlayerView * playerView ;
@property (nonatomic ,strong)PlayerTopView * topView ;
@property (nonatomic ,strong)PlayerBottomView * bottomView ;

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
}
- (PlayerBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [PlayerBottomView new];
        //桥接模式。
        _bottomView.playerView = self.playerView ;
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
        [_playerView setPlayEnd:^{
            [wSelf dismissViewControllerAnimated:YES completion:nil];
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

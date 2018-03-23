//
//  ViewController.m
//  Video_Audio
//
//  Created by 朱来飞 on 2018/3/22.
//  Copyright © 2018年 朱来飞. All rights reserved.
//

#import "ViewController.h"
#import "PlayerViewController.h"

#define kVideoURL @"http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)playLocalVideo:(UIButton *)sender {
    NSURL * localURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"海贼王精彩剪辑" ofType:@"mp4"]];
    
    PlayerViewController * playerVC = [[PlayerViewController alloc]init];
    playerVC.videoURL = localURL ;
    [self presentViewController:playerVC animated:YES completion:nil];
    //present 横屏
//    [self.navigationController pushViewController:playerVC animated:YES];
}

- (IBAction)playVideoOnline:(UIButton *)sender {
    
    NSURL * onlineURL = [NSURL URLWithString:kVideoURL];
    
    PlayerViewController * playerVC = [[PlayerViewController alloc]init];
    playerVC.videoURL = onlineURL ;
    [self presentViewController:playerVC animated:YES completion:nil];

}


@end

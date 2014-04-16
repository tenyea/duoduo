//
//  ShakeViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-10.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ShakeViewController : TenyeaBaseViewController{
    
    IBOutlet UIImageView *shake;
    SystemSoundID soundID;
//    今日剩余次数
    int residue_degree;
    IBOutlet UIImageView *shake_marquee1;
    IBOutlet UIImageView *shake_marquee2;
    IBOutlet UILabel *label;
    IBOutlet UIView *shakeResultView;//返回结果页面
    
    IBOutlet UILabel *titleLabel;//商品标题
    
    IBOutlet UILabel *sellLabel;//现价
    IBOutlet UIButton *closeResultButton;//关闭按钮
    NSString *course_id ;//商品编号
//    返回视图的图片
    UIImageView *resultImageView;
}



- (IBAction)exitAction:(UIButton *)sender;//离开

- (IBAction)closeResultAction:(UIButton *)sender;//关闭

//查看结果
- (IBAction)lookatAction:(UIButton *)sender;

@end

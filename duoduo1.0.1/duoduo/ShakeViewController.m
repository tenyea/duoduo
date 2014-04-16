//
//  ShakeViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-10.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "ShakeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "OpenUDID.h"
#import "UIImageView+WebCache.h"
#import "TYLabel.h"
#import "CourseViewController.h"
#define params_count @"count"
#define params_deviceID @"DeviceID"

#define user_count @"count"
#define user_date @"date"
@interface ShakeViewController ()
{
}
@end

@implementation ShakeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    获取剩余次数
    [self _getShakeCount];
//    更新剩余次数
    [self _updateShakeCount];
//    摇一摇声音
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"wav"];
	AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:path]), &soundID);
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(addAnimations) userInfo:nil repeats:YES];
//    动画
    [NSTimer scheduledTimerWithTimeInterval:.4 target:self selector:@selector(changeMarquee) userInfo:Nil repeats:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    打开摇动手势
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
//    关闭摇动手势
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = NO;
    [super viewWillDisappear:animated];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (![UIApplication sharedApplication].applicationSupportsShakeToEdit) {
        return;
    }
    
    if(motion==UIEventSubtypeMotionShake)
    {
//        不等于0
        if (residue_degree) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            [params setValue:[OpenUDID value] forKey:params_deviceID];
            [params setValue:[NSString stringWithFormat:@"%d",residue_degree] forKey:params_count];
            //        禁用摇一摇
            [UIApplication sharedApplication].applicationSupportsShakeToEdit = NO;
            
            [self showHUDwithLabel:@"test"];
            [self getDate:URL_home_shake andParams:params andcachePolicy:1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self showResult:responseObject];
//              今日次数减少,更新userdefaults
                residue_degree --;
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                [dic setValue:[self getNowDate] forKey:user_date];
                [dic setValue:[NSString stringWithFormat:@"%d",residue_degree] forKey:user_count];
                [[NSUserDefaults standardUserDefaults]setValue:dic forKey:kshakeCount];
//                更新label
                [self _updateShakeCount];
                [self  removeHUD];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                _po([error localizedDescription]);
                //        启用摇一摇
                [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
            }];
            AudioServicesPlaySystemSound (soundID);
        }else{
            
            HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            HUD.customView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Smilemark.png"]];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.labelText = String_shake_nochance;
            HUD.labelFont = HUD.detailsLabelFont;
            HUD.detailsLabelText = String_shake_tomorrow;

            
            [HUD show:YES];
            [HUD hide:YES afterDelay:1.5];
        }
        
        
    }
    
}


#pragma mark method
//隐藏结果页面
-(void)hiddenResultView {
    [UIView animateWithDuration:.6 animations:^{
        shakeResultView.bottom = 0;
        shakeResultView.alpha = 0;
    } completion:^(BOOL finished) {
        [resultImageView removeFromSuperview];
        UILabel *slabel = (UILabel *)VIEWWITHTAG(shakeResultView, 100);
        if (slabel) {
            [slabel removeFromSuperview];
        }
    }];
    //        启用摇一摇
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
}
-(void)showResult:(NSDictionary *)resultobject{
    NSDictionary *result =[resultobject objectForKey:@"course"];
    course_id = [result objectForKey:@"course_id"];//编号id
    NSString *course_name = [result objectForKey:@"courseName"];//标题
    NSString *course_images = [result objectForKey:@"course_images"];//图片地址
    NSString *course_price = [result objectForKey:@"course_price"];//现价
    NSString *course_sell_price = [result objectForKey:@"course_sell_price"];//原价
    
    
//    视图显示
    [UIView animateWithDuration:.6 animations:^{
        shakeResultView.alpha = 1;
        shakeResultView.top = 0;

    } completion:^(BOOL finished) {
        if (!resultImageView) {
            //        图片
            resultImageView = [[UIImageView alloc]init];
            resultImageView.frame = CGRectMake(40+4, 93+10, 240-8, 165-2);
            //        圆角
            resultImageView.layer.cornerRadius = 13;
            resultImageView.layer.masksToBounds = YES;
        }
        [resultImageView setImageWithURL:[NSURL URLWithString:course_images]];
        [shakeResultView insertSubview:resultImageView belowSubview:closeResultButton];

        
        titleLabel.text = course_name;
        sellLabel.text = [NSString stringWithFormat:@"￥%.2f",[course_price floatValue]];
        [sellLabel sizeToFit];
//        原价和现价不同
        if ([course_price floatValue] !=[course_sell_price floatValue]) {
            CGRect frame = sellLabel.frame;
            //            删除线的label  显示原价
            TYLabel *sell_price = [[TYLabel alloc]initWithFrame: frame];
            sell_price.isWithStrikeThrough = YES;
            sell_price.left = 10 +sellLabel.right;
            sell_price.width = 80;
            sell_price.top += 3;
            sell_price.text = [NSString stringWithFormat:@"￥%.2f",[course_sell_price floatValue]];
            sell_price.textColor = [UIColor whiteColor];
            sell_price.font = [UIFont boldSystemFontOfSize:13];
            sell_price.tag = 100;
            [sell_price sizeToFit];
            [shakeResultView addSubview:sell_price];
        }
    }];
    
}

-(void)changeMarquee{
    [UIView animateWithDuration:.2 animations:^{
        shake_marquee1.alpha = 0;
        shake_marquee2.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            shake_marquee1.alpha = 1;
            shake_marquee2.alpha = 0;
        }];
    }];
}

-(void)addAnimations
{
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_4/2,  0, 0,  -1.0)];
    translation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4/2,  0, 0,  -1.0)];
    translation.duration = 0.15;
    translation.repeatCount = 2;
    translation.autoreverses = YES;
    [shake.layer addAnimation:translation forKey:@"translation"];
    
}
//    获取剩余次数
-(void) _getShakeCount{
    NSDictionary *shakeDic = [[NSUserDefaults standardUserDefaults] objectForKey:kshakeCount];
    //        初始化shake
    if (!shakeDic) {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [formatter stringFromDate:date];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:[NSNumber numberWithInt:3] forKey:user_count];
        [dic setValue:dateStr forKey:user_date];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kshakeCount];
        shakeDic = [NSDictionary dictionaryWithDictionary:dic];
    }
    
    //        获取上次摇动时间
    NSString *lastDate = [shakeDic objectForKey:user_date];
    NSString *nowdate = [self getNowDate];
    //        判断是否是同一天
    if ([lastDate isEqualToString:nowdate]) {
        NSString *count = [shakeDic objectForKey:user_count];
        residue_degree = [count intValue];
    }else{
        residue_degree = 3;
    }

}
//获取当前时间
-(NSString *)getNowDate{
    //        获取当前时间
    NSDate *now_date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowdate = [formatter stringFromDate:now_date];
    return nowdate;
}
//    更新剩余次数
-(void)_updateShakeCount{
    label.text = [NSString stringWithFormat:@"%d",residue_degree];
}

#pragma mark action
- (IBAction)exitAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//关闭
- (IBAction)closeResultAction:(UIButton *)sender {
    [self hiddenResultView];
}
- (IBAction)lookatAction:(UIButton *)sender {
    CourseViewController *VC = [[CourseViewController alloc]init];
    VC.CourseID = course_id;
    [self.navigationController pushViewController:VC animated:YES];
}
@end

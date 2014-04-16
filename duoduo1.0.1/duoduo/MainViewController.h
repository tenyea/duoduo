//
//  MainViewController.h
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "TenyeaBaseTabBarViewController.h"
@interface MainViewController : TenyeaBaseTabBarViewController <UINavigationControllerDelegate,UIScrollViewDelegate>{
    UIView *_tabbarView;//tabbar
    UIImageView *_sliderView;//滑动器
    UIImageView *_badgeView;
    //引导页scroll
    UIScrollView *_scrollView;
//  启动图
    UIImageView *homeView;
}
//-(void)showBadge:(BOOL)show;
-(void)showTabbar:(BOOL)show;
-(void)refreshBadge:(int)item andCount:(int)count;
@end

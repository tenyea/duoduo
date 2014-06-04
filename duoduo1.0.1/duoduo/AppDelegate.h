//
//  AppDelegate.h
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@class MainViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIScrollViewDelegate>{
    Reachability *hostReach;
    //引导页scroll
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainVC;
@end

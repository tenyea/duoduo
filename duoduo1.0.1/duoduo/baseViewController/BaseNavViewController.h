//
//  BaseNavViewController.h
//  tabbartest
//
//  Created by 佐筱猪 on 13-10-15.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavViewController : UINavigationController
{
    UISwipeGestureRecognizer *swipeGesture;
}
@property (nonatomic,strong ) UISwipeGestureRecognizer *swipeGesture;
/*
- (void)customPushViewController:(UIViewController *)viewController;
//从左到右
- (void)customLeftToRightPushViewController:(UIViewController *)viewController;

- (void)pushViewController: (UIViewController*)controller  animatedWithTransition: (UIViewAnimationTransition)transition;
- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition;
 */
@end

//
//  TYtouchView.h
//  duoduo
//
//  Created by tenyea on 14-4-12.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ViewBlock)(void);
@interface TYtouchView : UIView
@property (nonatomic,copy)ViewBlock touchBlock;
@end

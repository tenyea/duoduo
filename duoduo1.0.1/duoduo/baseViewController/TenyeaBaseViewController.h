//
//  TenyeaBaseViewController.h
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "MBProgressHUD.h"
@interface TenyeaBaseViewController : UIViewController{
//    加载框
    MBProgressHUD *HUD;
}

#pragma mark method
//返回appdelegate
-(AppDelegate *)appDelegate;
//访问网络获取数据
-(void)getDate: (NSString *)url andParams:(NSDictionary *)param  andcachePolicy:(int)cachePolicyType success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//显示加载框
-(void)showHUDwithLabel :(NSString *)title;
//隐藏移除加载框
-(void)removeHUD;
#pragma mark property
//取消按钮
@property (nonatomic,assign)BOOL isCancelButton;


@end

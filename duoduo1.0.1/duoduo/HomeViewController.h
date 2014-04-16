//
//  HomeViewController.h
//  duoduo
//
//  Created by tenyea on 14-3-25.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "HomeTableView.h"
@interface HomeViewController : TenyeaBaseViewController <UITextFieldDelegate,TYTableViewDelegate>{
//    左侧logo
    UIImageView *logoImageView;
    //navi右侧照相按钮
    UIButton *cameraButton;
    //navi右侧取消按钮
    UIButton *cancelButton;
//  背景view
    HomeTableView *bgTabelView;

}
//搜索栏
@property (strong, nonatomic) UITextField *searchBar;
//搜索栏背景
@end

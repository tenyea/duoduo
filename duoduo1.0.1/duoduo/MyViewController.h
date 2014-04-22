//
//  MyViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-18.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "RollView.h"
@interface MyViewController : TenyeaBaseViewController<UITableViewDataSource,UITableViewDelegate,RollViewDelegate>{
    NSArray *section1Arr;
    NSArray *section2Arr;
    NSArray *image1Arr;
    NSArray *image2Arr;

    IBOutlet RollView *roolView;
}


//顶部视图
@property (strong, nonatomic) IBOutlet UIView *topView;
//推荐视图
@property (strong, nonatomic) IBOutlet UIView *recommendView;
@end

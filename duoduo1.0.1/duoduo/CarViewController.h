//
//  CarViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-23.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "TYTableView.h"
#import "BuyCarCell.h"
@class Reachability;
@interface CarViewController : TenyeaBaseViewController<UITableViewDataSource,UITableViewDelegate,TYTableViewDelegate,changeValueDelegate>{
    
    UIView *bottomBgView;
    UILabel *priceLabel ;//价格
    UILabel *payLabel ; //结算
    TYTableView *bgTableView ;
    NSArray *dataArr;
    UILabel *noneCarLabel;
    UILabel *netLabel;
}
@property(nonatomic,retain)Reachability *reachability;

@end

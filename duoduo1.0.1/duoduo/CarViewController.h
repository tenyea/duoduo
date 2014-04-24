//
//  CarViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-23.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "TYTableView.h"
@interface CarViewController : TenyeaBaseViewController<UITableViewDataSource,UITableViewDelegate,TYTableViewDelegate>{
    
    UIView *bottomBgView;
    UILabel *priceLabel ;//价格
    UILabel *payLabel ; //结算
    TYTableView *bgTableView ;
    NSArray *dataArr;
    UILabel *noneCarLabel;
    UILabel *netLabel;
}

@end

//
//  MyMessageViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-22.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface MyMessageViewController : TenyeaBaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *bgtableView;
    NSArray *dataArr;
}

@end

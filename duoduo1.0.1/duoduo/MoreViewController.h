//
//  MoreViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-28.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface MoreViewController : TenyeaBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain ,  nonatomic) NSString *updateURL;
@end

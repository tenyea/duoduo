//
//  CourseViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-11.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface CourseViewController : TenyeaBaseViewController<UITableViewDataSource,UITableViewDelegate>

-(id) initWithCourseID:(NSString *)CourseId;

@property (nonatomic ,strong) NSString *CourseID;

@end

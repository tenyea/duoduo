//
//  CourseSearchViewController.h
//  duoduo
//
//  Created by tenyea on 14-4-19.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "TdCalendarView.h"

@interface CourseSearchViewController : TenyeaBaseViewController <CalendarViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    


    IBOutlet TdCalendarView *Calendar;
    IBOutlet UITableView *courseTbleView;
    NSArray *oneDataArray;
    NSDictionary *allMonthDic;
    
    NSString *userID;
}

@end

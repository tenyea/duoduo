//
//  CourseSearchViewController.m
//  duoduo
//
//  Created by tenyea on 14-4-19.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "CourseSearchViewController.h"
#import "TYButton.h"
@interface CourseSearchViewController ()

@end

@implementation CourseSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    Calendar设置代理
    Calendar.calendarViewDelegate = self;
    
//    右侧按钮初始化
    TYButton *nextButton = [[TYButton alloc]initWithFrame: CGRectMake(40, 0, 40, 40)];
    nextButton.backgroundColor = CLEARCOLOR;
//    [nextButton setImage:[UIImage imageNamed:@"shake_exit1.png"] forState:UIControlStateNormal];
    [nextButton setTitle:@"上月" forState:UIControlStateNormal];
    nextButton.touchBlock = ^(TYButton *button ){
        [Calendar movePrevMonth];

    };
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    TYButton *prevButton = [[TYButton alloc]initWithFrame: CGRectMake(0, 0, 40, 40)];
    prevButton.backgroundColor = CLEARCOLOR;
//    [prevButton setImage:[UIImage imageNamed:@"shake_exit1.png"] forState:UIControlStateNormal];
    [prevButton setTitle:@"下月" forState:UIControlStateNormal];
    prevButton.touchBlock = ^(TYButton *button ){
        [Calendar  moveNextMonth];
    };
    UIBarButtonItem *prevItem = [[UIBarButtonItem alloc] initWithCustomView:prevButton];
    self.navigationItem.rightBarButtonItems = @[prevItem,nextItem];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark CalendarViewDelegate

- (void) selectDateChanged:(CFGregorianDate) selectDate{
    _pn(selectDate.day);
}
- (void) monthChanged:(CFGregorianDate) currentMonth viewLeftTop:(CGPoint)viewLeftTop height:(float)height{
    _pn(currentMonth.month);
}
- (void) beforeMonthChange:(TdCalendarView*) calendarView willto:(CFGregorianDate) currentMonth{
    [calendarView clearAllDayFlag];
    for (int i = 1; i <28 ; i ++) {
        [calendarView setDayFlag:i flag:1];

    }
}
-(void)titleChanged:(NSString *)title{
    self.title = title;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;//oneDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"course";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OneDayCell" owner:self options:nil]lastObject];
    }
//    标题
    UILabel *title = (UILabel *)VIEWWITHTAG(cell.contentView, 10);
    title.text = @"123123123";
//    开始时间
    UILabel *begin = (UILabel *)VIEWWITHTAG(cell.contentView, 20);
    begin.text = @"10:00";
//    结束时间
    UILabel *end = (UILabel *)VIEWWITHTAG(cell.contentView, 30);
    end.text = @"11:30";
//    按钮
    TYButton *button = (TYButton *)VIEWWITHTAG(cell.contentView, 40);
    button.touchBlock = ^(TYButton *button ){
        _pn(indexPath.row);
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark UITableViewDelegate

#pragma mark 本地推送
-(void)pushLocalNotification:(NSDate *)data key:(NSString *)key{
    // 创建一个本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init] ;

    if (notification != nil) {
        // 设置推送时间
        notification.fireDate = data;
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitDay;
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 推送内容
        notification.alertBody = @"推送内容";
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObject:key forKey:@"key"];
        notification.userInfo = info;
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:notification];
        
    }
}
//解除本地推送
-(void)unbindLocalNotification :(NSString *)key {
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification;
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:key]) {
                    if (localNotification){
//                        [localNotification release];
                        localNotification = nil;
                    }
//                    localNotification = [noti retain];
                    localNotification = noti;
                    break;
                }
            }
        }
        
        //判断是否找到已经存在的相同key的推送
        if (!localNotification) {
            //不存在初始化
            localNotification = [[UILocalNotification alloc] init];
        }
        
        if (localNotification) {
            //不推送 取消推送
            [app cancelLocalNotification:localNotification];
//            [localNotification release];
            return;
        }
    }
}

@end
